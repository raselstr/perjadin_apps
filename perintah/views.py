from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied
from django.db.models import Prefetch
from django.http import Http404
from django.shortcuts import get_object_or_404, render
from django.views import View

from core.crud.base import BaseCRUDView, BaseMasterDetailCRUDView
from menus.models import RolePermission, SubMenu
from profiles.models import UserProfile
from profiles.utils import filter_queryset_by_active_opd, get_active_opd_id

from .document_utils import (
    build_contact_line,
    build_penandatangan_title,
    filter_spd_pelaksana,
    build_spt_signature_title_parts,
    filter_spt_pelaksana,
    find_ppk_penandatangan,
    generate_default_document_number,
    get_kop_surat_config,
    get_letterhead_office_name,
    get_matching_pemda,
    get_signature_location,
    is_regional_head_task,
    select_spd_primary_pelaksana,
    should_hide_signatory_identity_details,
)
from .forms import PelaksanaFormSet, PemberiTugasForm, SptForm
from .models import Pelaksana, PemberiTugas, Spt
from .tables import PemberiTugasTable, SptTable


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
    nomor_urut = (raw_number or fallback_number or "").strip()
    if not format_template or not nomor_urut:
        return (raw_number or fallback_number or "").strip()

    return generate_default_document_number(
        nomor_urut,
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
            "pelaksana__nama"
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
            "penandatangan__jenis_jabatan",
            "penandatangan__opd",
        ).order_by("-tanggal_spt", "-id")

        queryset = filter_queryset_by_active_opd(
            queryset,
            self.request,
            "spt__pelaksana__nama__opd_id",
        )
        return queryset.distinct()


class PemberiTugasPrintBaseView(PerintahPermissionMixin, View):
    template_name = ""

    def get_base_queryset(self):
        queryset = PemberiTugas.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "penandatangan",
            "penandatangan__pangkat",
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
        tanggal_spt = pemberi_tugas.tanggal_spt or spt.tgl_berangkat

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
        }

    def get_context_data(self, pemberi_tugas):
        raise NotImplementedError

    def get(self, request, pk):
        pemberi_tugas = self.get_object(pk)
        context = self.get_context_data(pemberi_tugas)
        return render(request, self.template_name, context)


class PemberiTugasPrintSptView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/spt.html"

    def get_context_data(self, pemberi_tugas):
        pelaksana_list = filter_spt_pelaksana(
            pemberi_tugas.spt.pelaksana.all(),
            pemberi_tugas.penandatangan.tugas,
        )
        pemda = get_matching_pemda(pemberi_tugas.penandatangan.opd)
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
