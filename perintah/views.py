from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied
from django.core.files.storage import default_storage
from django.db import transaction
from django.db.models import Prefetch
from django.http import FileResponse, Http404
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.views import View

from core.crud.base import BaseCRUDView, BaseMasterDetailCRUDView
from menus.models import RolePermission, SubMenu
from profiles.models import UserProfile
from profiles.utils import filter_queryset_by_active_opd, get_active_opd_id

from .document_utils import (
    build_contact_line,
    build_penandatangan_title,
    can_print_spt_document,
    filter_spd_pelaksana,
    build_spt_signature_title_parts,
    filter_spt_pelaksana,
    find_ppk_penandatangan,
    format_spt_date_range,
    generate_default_document_number,
    get_kop_surat_config,
    get_letterhead_office_name,
    get_matching_pemda,
    get_spt_letterhead_pemda,
    get_signature_location,
    is_regional_head_task,
    select_spd_primary_pelaksana,
    should_hide_signatory_identity_details,
)
from .forms import PelaksanaFormSet, PemberiTugasForm, SptForm, TtdSptSpdForm
from .models import Pelaksana, PemberiTugas, Spt, TtdSptSpd
from .tables import PemberiTugasTable, SptTable, TtdSptSpdTable


def _get_default_signature_location(spt):
    if spt.kota_tujuan:
        return spt.kota_tujuan.kota or spt.kota_tujuan.lokasi
    return ""


def _get_primary_instansi_name(pemda, penandatangan=None, fallback=""):
    if pemda and pemda.nama_dinas:
        return pemda.nama_dinas.nama

    if penandatangan and getattr(penandatangan, "opd", None):
        return penandatangan.opd.nama

    return fallback or "Instansi Asal"


def _get_active_opd_name(request, fallback=""):
    if not request:
        return fallback or "-"

    session_opd_name = request.session.get("session_opd_nama")
    if session_opd_name and session_opd_name != "Administrator Pusat":
        return session_opd_name

    user = getattr(request, "user", None)
    if user and user.is_authenticated:
        try:
            profile = user.userprofile
        except UserProfile.DoesNotExist:
            profile = None

        if profile and profile.opd:
            return profile.opd.nama

    return fallback or session_opd_name or "-"


def _build_number_from_format(raw_number, fallback_number, tanggal, format_template):
    raw_number = (raw_number or "").strip()
    if raw_number:
        return raw_number

    if not format_template:
        return (fallback_number or "").strip()

    return generate_default_document_number(
        fallback_number,
        tanggal,
        format_template,
    )


class PerintahPermissionMixin(LoginRequiredMixin):
    permission_url_name = "pemberi_tugas_list"

    def has_view_permission(self):
        user = self.request.user

        if not user.is_authenticated:
            return False

        if user.is_superuser:
            return True

        try:
            profile = UserProfile.objects.select_related("role").get(user=user)
            submenu = SubMenu.objects.get(url=self.permission_url_name)
        except (UserProfile.DoesNotExist, SubMenu.DoesNotExist):
            return False

        return RolePermission.objects.filter(
            role=profile.role,
            submenu=submenu,
            can_view=True,
        ).exists()

    def dispatch(self, request, *args, **kwargs):
        self.request = request

        if not self.has_view_permission():
            raise PermissionDenied(
                "Anda tidak memiliki izin untuk melihat dokumen ini."
            )

        return super().dispatch(request, *args, **kwargs)


class SptView(BaseMasterDetailCRUDView):
    model = Spt
    form_class = SptForm
    formset_class = PelaksanaFormSet
    table_class = SptTable
    enable_excel = False

    title = "Daftar SPT"

    url_list = "spt_list"
    url_action = "spt_action"
    url_action_pk = "spt_action_pk"
    url_export = None
    url_import = None

    def get_base_queryset(self):
        queryset = Spt.objects.select_related(
            "kota_tujuan",
            "jenis_kegiatan",
        ).prefetch_related(
            "pelaksana__nama",
        ).order_by("-id")

        queryset = filter_queryset_by_active_opd(
            queryset,
            self.request,
            "pelaksana__nama__opd_id",
        )
        return queryset.distinct()


class PemberiTugasView(BaseCRUDView):
    model = PemberiTugas
    form_class = PemberiTugasForm
    table_class = PemberiTugasTable
    enable_excel = False

    title = "Daftar Pemberi Tugas"

    url_list = "pemberi_tugas_list"
    url_action = "pemberi_tugas_action"
    url_action_pk = "pemberi_tugas_action_pk"

    def get_base_queryset(self):
        queryset = PemberiTugas.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "penandatangan",
            "penandatangan__tugas",
            "penandatangan__jenis_jabatan",
            "penandatangan__opd",
        ).order_by("-tanggal_spt", "-id")

        queryset = filter_queryset_by_active_opd(
            queryset,
            self.request,
            "spt__pelaksana__nama__opd_id",
        )
        return queryset.distinct()

    def delete_view(self, request, pk):
        if request.method != "POST":
            return super().delete_view(request, pk)

        perm = self.get_permission()

        if not perm or not perm.can_delete:
            return self._forbidden(request)

        pemberi_tugas = get_object_or_404(
            self.get_object_queryset(),
            pk=pk,
        )

        with transaction.atomic():
            ttd = getattr(pemberi_tugas, "ttdsptspd", None)
            hardcopy_name = ""

            if ttd:
                hardcopy_name = ttd.hardcopy.name if ttd.hardcopy else ""
                ttd.delete()

            pemberi_tugas.delete()

        if hardcopy_name:
            default_storage.delete(hardcopy_name)

        if request.headers.get("HX-Request"):
            return self._build_htmx_success_response("delete")

        self._add_success_message(request, "delete")
        return redirect(self.url_list)

class TtdSptSpdView(BaseCRUDView):
    model = TtdSptSpd
    form_class = TtdSptSpdForm
    enable_excel = False

    title = "Berkas Tanda Tangan SPT/SPD"

    url_list = "ttd_spt_spd_list"
    url_action = "ttd_spt_spd_action"
    url_action_pk = "ttd_spt_spd_action_pk"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.table_class is None:
            self.table_class = TtdSptSpdTable

    def get_base_queryset(self):
        pemberi_tugas_queryset = PemberiTugas.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "penandatangan",
            "penandatangan__tugas",
            "penandatangan__jenis_jabatan",
            "penandatangan__opd",
        )
        pemberi_tugas_queryset = filter_queryset_by_active_opd(
            pemberi_tugas_queryset,
            self.request,
            "spt__pelaksana__nama__opd_id",
        ).distinct()

        pemberi_tugas_ids = list(
            pemberi_tugas_queryset.values_list("id", flat=True)
        )

        existing_pemberi_tugas_ids = set(
            TtdSptSpd.objects.filter(
                pemberi_tugas_id__in=pemberi_tugas_ids,
            ).values_list("pemberi_tugas_id", flat=True)
        )
        missing_ttd_records = [
            TtdSptSpd(pemberi_tugas_id=pemberi_tugas_id)
            for pemberi_tugas_id in pemberi_tugas_ids
            if pemberi_tugas_id not in existing_pemberi_tugas_ids
        ]

        if missing_ttd_records:
            TtdSptSpd.objects.bulk_create(
                missing_ttd_records,
                ignore_conflicts=True,
            )

        queryset = TtdSptSpd.objects.select_related(
            "pemberi_tugas",
            "pemberi_tugas__spt",
            "pemberi_tugas__spt__kota_tujuan",
            "pemberi_tugas__penandatangan",
            "pemberi_tugas__penandatangan__tugas",
            "pemberi_tugas__penandatangan__jenis_jabatan",
            "pemberi_tugas__penandatangan__opd",
        ).order_by("-pemberi_tugas__tanggal_spt", "-id")

        queryset = queryset.filter(pemberi_tugas_id__in=pemberi_tugas_ids)
        return queryset.distinct()


class PemberiTugasPrintBaseView(PerintahPermissionMixin, View):
    template_name = ""
    frame_content_security_policy = (
        "default-src 'self'; "
        "script-src 'self' 'unsafe-inline' https://code.jquery.com "
        "https://cdn.jsdelivr.net https://unpkg.com; "
        "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net "
        "https://unpkg.com; "
        "img-src 'self' data: blob:; "
        "font-src 'self' data: https://cdn.jsdelivr.net; "
        "connect-src 'self'; "
        "frame-ancestors 'self'; "
        "base-uri 'self'; "
        "form-action 'self'; "
        "object-src 'none'"
    )

    def get_base_queryset(self):
        queryset = PemberiTugas.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "penandatangan",
            "penandatangan__pangkat",
            "penandatangan__tugas",
            "penandatangan__jenis_jabatan",
            "penandatangan__opd",
        ).prefetch_related(
            Prefetch(
                "spt__pelaksana",
                queryset=Pelaksana.objects.select_related(
                    "nama",
                    "nama__eselon",
                    "nama__pangkat",
                    "nama__tingkat",
                    "nama__opd",
                ).order_by("id"),
            )
        )

        queryset = filter_queryset_by_active_opd(
            queryset,
            self.request,
            "spt__pelaksana__nama__opd_id",
        )
        return queryset.distinct()

    def get_object(self, pk):
        return get_object_or_404(self.get_base_queryset(), pk=pk)

    def build_document_context(
        self,
        pemberi_tugas,
        pemda,
        penandatangan,
        asal_instansi_fallback="",
    ):
        spt = pemberi_tugas.spt
        default_signature_location = _get_default_signature_location(spt)
        asal_instansi = _get_primary_instansi_name(
            pemda,
            penandatangan=penandatangan,
            fallback=asal_instansi_fallback or pemberi_tugas.opd,
        )

        # Get kop_surat config for default number format
        kop_surat = get_kop_surat_config(pemda)
        tanggal_spt = pemberi_tugas.tanggal_spt or ""

        nomor_spt = _build_number_from_format(
            pemberi_tugas.nomor_spt,
            pemberi_tugas.nomor_urut,
            tanggal_spt,
            kop_surat.default_spt_number_format,
        )
        nomor_spd = _build_number_from_format(
            pemberi_tugas.nomor_spd,
            pemberi_tugas.nomor_urut,
            tanggal_spt,
            kop_surat.default_spd_number_format,
        )
        spt_signature_title_parts = build_spt_signature_title_parts(
            penandatangan,
            pemda=pemda,
        )

        return {
            "pemda": pemda,
            "pemberi_tugas": pemberi_tugas,
            "penandatangan_dokumen": penandatangan,
            "spt": spt,
            "tanggal_dokumen": tanggal_spt,
            "asal_instansi": asal_instansi,
            "active_opd_name": _get_active_opd_name(
                self.request,
                fallback=asal_instansi,
            ),
            "kop_office_name": get_letterhead_office_name(
                penandatangan,
                pemda=pemda,
            ),
            "kop_contact_line": build_contact_line(pemda),
            "kop_surat": kop_surat,
            "kop_is_regional_head": is_regional_head_task(
                getattr(penandatangan, "tugas", "")
            ),
            "signature_title": build_penandatangan_title(penandatangan),
            "spt_signature_title_prefix": (
                spt_signature_title_parts["prefix"]
            ),
            "spt_signature_title_lines": spt_signature_title_parts["lines"],
            "show_signature_identity_details": (
                not should_hide_signatory_identity_details(penandatangan)
            ),
            "signature_location": get_signature_location(
                pemda,
                default_location=default_signature_location,
            ),
            "auto_print": (
                self.request.GET.get("autoprint", "1") != "0"
            ),
            "nomor_spt": nomor_spt,
            "nomor_spd": nomor_spd,
            "kota_tujuan_text": spt.kota_tujuan_display,
            "tempat_tujuan_text": spt.tempat_tujuan_display,
            "tujuan_perjalanan_text": spt.tujuan_perjalanan_display,
            "tanggal_perjalanan_spt": format_spt_date_range(
                spt.tgl_berangkat,
                spt.tgl_kembali,
            ),
        }

    def get_context_data(self, pemberi_tugas):
        raise NotImplementedError

    def get(self, request, pk):
        pemberi_tugas = self.get_object(pk)
        context = self.get_context_data(pemberi_tugas)
        response = render(request, self.template_name, context)
        response["X-Frame-Options"] = "SAMEORIGIN"
        response["Content-Security-Policy"] = (
            self.frame_content_security_policy
        )
        return response


class PemberiTugasPrintSptView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/spt.html"

    def get_context_data(self, pemberi_tugas):
        active_opd_id = get_active_opd_id(self.request)
        pelaksana_list = filter_spt_pelaksana(
            pemberi_tugas.spt.pelaksana.all(),
            pemberi_tugas.penandatangan.tugas,
            opd_id=active_opd_id,
            signatory_opd_id=getattr(
                pemberi_tugas.penandatangan,
                "opd_id",
                None,
            ),
        )
        pemda = get_spt_letterhead_pemda(pemberi_tugas.penandatangan)
        context = self.build_document_context(
            pemberi_tugas,
            pemda,
            pemberi_tugas.penandatangan,
        )
        context.update({
            "pelaksana_list": pelaksana_list,
            "show_pelaksana_numbering": len(pelaksana_list) > 1,
        })
        return context


class PemberiTugasPrintSpdView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/spd.html"

    def get_context_data(self, pemberi_tugas):
        if is_regional_head_task(pemberi_tugas.penandatangan.tugas):
            raise Http404(
                "SPD tidak tersedia untuk penandatangan Bupati/Wakil Bupati."
            )

        active_opd_id = get_active_opd_id(self.request)
        ppk = find_ppk_penandatangan(
            opd=pemberi_tugas.penandatangan.opd,
            fallback_opd_id=active_opd_id,
        ) or pemberi_tugas.penandatangan

        pemda = get_matching_pemda(getattr(ppk, "opd", None))
        pelaksana_list = filter_spd_pelaksana(
            pemberi_tugas.spt.pelaksana.all(),
            opd_id=getattr(ppk, "opd_id", None) or active_opd_id,
        )
        primary_pelaksana, followers = select_spd_primary_pelaksana(
            pelaksana_list
        )

        context = self.build_document_context(
            pemberi_tugas,
            pemda,
            ppk,
            asal_instansi_fallback=pemberi_tugas.opd,
        )
        context.update({
            "primary_pelaksana": primary_pelaksana,
            "followers": followers,
            "show_followers": len(followers) > 0,
        })
        return context

class PemberiTugasPrintSPDBelakangView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/belakang.html"
    def get_context_data(self, pemberi_tugas):
        if is_regional_head_task(pemberi_tugas.penandatangan.tugas):
            raise Http404(
                "SPD Belakang tidak tersedia untuk penandatangan Bupati/Wakil Bupati."
            )

        active_opd_id = get_active_opd_id(self.request)
        ppk = find_ppk_penandatangan(
            opd=pemberi_tugas.penandatangan.opd,
            fallback_opd_id=active_opd_id,
        ) or pemberi_tugas.penandatangan
        pemda = get_matching_pemda(getattr(ppk, "opd", None))

        context = self.build_document_context(
            pemberi_tugas,
            pemda,
            ppk,
            asal_instansi_fallback=pemberi_tugas.opd,
        )
        return context


class PemberiTugasPreviewBaseView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/preview_modal.html"
    document_code = ""
    preview_title = "Preview Dokumen"
    print_url_name = ""
    unavailable_message = "Dokumen tidak tersedia untuk dicetak."

    def can_preview(self, pemberi_tugas):
        return True

    def get_iframe_src(self, pemberi_tugas):
        return (
            reverse(self.print_url_name, args=[pemberi_tugas.pk])
            + "?autoprint=0"
        )

    def get_context_data(self, pemberi_tugas):
        iframe_src = self.get_iframe_src(pemberi_tugas)
        document_code = (self.document_code or "").upper() or "DOKUMEN"

        return {
            "title": self.preview_title,
            "document_code": document_code,
            "preview_description": (
                f"Tinjau {document_code} terlebih dahulu sebelum dicetak."
            ),
            "iframe_src": iframe_src,
            "open_url": iframe_src,
            "frame_id": (
                f"print-preview-frame-"
                f"{self.document_code or 'document'}-{pemberi_tugas.pk}"
            ),
            "print_button_label": f"Cetak {document_code}",
        }

    def get(self, request, pk):
        pemberi_tugas = self.get_object(pk)

        if not self.can_preview(pemberi_tugas):
            raise Http404(self.unavailable_message)

        context = self.get_context_data(pemberi_tugas)
        return render(request, self.template_name, context)


class PemberiTugasPreviewSptView(PemberiTugasPreviewBaseView):
    document_code = "spt"
    preview_title = "Preview SPT"
    print_url_name = "pemberi_tugas_print_spt"
    unavailable_message = "SPT tidak tersedia untuk dicetak."

    def can_preview(self, pemberi_tugas):
        return can_print_spt_document(
            pemberi_tugas.spt.pelaksana.select_related(
                "nama",
                "nama__eselon",
            ).all(),
            pemberi_tugas.penandatangan.tugas,
            opd_id=get_active_opd_id(self.request),
            signatory_opd_id=getattr(
                pemberi_tugas.penandatangan,
                "opd_id",
                None,
            ),
        )


class PemberiTugasPreviewSpdView(PemberiTugasPreviewBaseView):
    document_code = "spd"
    preview_title = "Preview SPD"
    print_url_name = "pemberi_tugas_print_spd"
    unavailable_message = "SPD tidak tersedia untuk dicetak."

    def can_preview(self, pemberi_tugas):
        return pemberi_tugas.can_print_spd


class PemberiTugasPreviewSPDBelakangView(PemberiTugasPreviewBaseView):
    document_code = "belakang"
    preview_title = "Preview SPD Belakang"
    print_url_name = "pemberi_tugas_print_spd_belakang"
    unavailable_message = "SPD Belakang tidak tersedia untuk dicetak."

    def can_preview(self, pemberi_tugas):
        return pemberi_tugas.can_print_spd_belakang


class TtdSptSpdViewModalView(LoginRequiredMixin, View):
    def get_queryset(self, request):
        queryset = TtdSptSpd.objects.select_related(
            "pemberi_tugas",
            "pemberi_tugas__spt",
            "pemberi_tugas__spt__kota_tujuan",
        )
        return filter_queryset_by_active_opd(
            queryset,
            request,
            "pemberi_tugas__spt__pelaksana__nama__opd_id",
        ).distinct()

    def get(self, request, pk):
        ttd = get_object_or_404(
            self.get_queryset(request),
            pk=pk,
        )
        
        if not ttd.hardcopy:
            raise Http404("File PDF tidak ditemukan.")
        
        context = {
            'ttd': ttd,
            'pdf_url': reverse("ttd_spt_spd_pdf", kwargs={"pk": ttd.pk}),
            'download_url': ttd.hardcopy.url,
            'pemberi_tugas_name': str(ttd.pemberi_tugas),
        }
        
        return render(request, 'components/ttd/pdf_view_modal.html', context)


class TtdSptSpdPdfView(TtdSptSpdViewModalView):
    def get(self, request, pk):
        ttd = get_object_or_404(
            self.get_queryset(request),
            pk=pk,
        )

        if not ttd.hardcopy:
            raise Http404("File PDF tidak ditemukan.")

        response = FileResponse(
            ttd.hardcopy.open("rb"),
            content_type="application/pdf",
            as_attachment=False,
            filename=ttd.hardcopy.name.rsplit("/", 1)[-1],
        )
        response["X-Frame-Options"] = "SAMEORIGIN"
        response["Content-Security-Policy"] = (
            "default-src 'self'; frame-ancestors 'self'; object-src 'none'"
        )
        return response


class TtdSptSpdUploadView(LoginRequiredMixin, View):
    def get_queryset(self, request):
        queryset = TtdSptSpd.objects.select_related(
            "pemberi_tugas",
            "pemberi_tugas__spt",
        )
        return filter_queryset_by_active_opd(
            queryset,
            request,
            "pemberi_tugas__spt__pelaksana__nama__opd_id",
        ).distinct()

    def post(self, request, pk):
        from django.http import JsonResponse
        from django.core.files.storage import default_storage
        
        ttd = get_object_or_404(self.get_queryset(request), pk=pk)
        
        if 'file' not in request.FILES:
            return JsonResponse({
                'success': False,
                'message': 'File tidak ditemukan.'
            }, status=400)
        
        file = request.FILES['file']
        
        if not file.name.lower().endswith('.pdf'):
            return JsonResponse({
                'success': False,
                'message': 'Hanya file PDF yang diperbolehkan.'
            }, status=400)
        
        if file.size > 50 * 1024 * 1024:
            return JsonResponse({
                'success': False,
                'message': 'Ukuran file terlalu besar (maksimal 50MB).'
            }, status=400)
        
        if ttd.hardcopy:
            default_storage.delete(ttd.hardcopy.name)
        
        ttd.hardcopy = file
        ttd.save()
        
        return JsonResponse({
            'success': True,
            'message': 'File berhasil di-upload.',
            'file_url': ttd.hardcopy.url,
        })
