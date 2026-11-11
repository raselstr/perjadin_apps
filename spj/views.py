import json
from decimal import Decimal
from datetime import datetime
from io import BytesIO
from PIL import Image, ImageOps

from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from django.db import models, IntegrityError
from django.http import HttpResponse, JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.urls import reverse
from django.db.models import Count, Exists, OuterRef, Q
from django.utils.html import format_html, format_html_join
from django.utils import timezone
from django.views import View
from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter

from core.crud.base import BaseCRUDView
from core.utils.formatting import format_indonesian_number, is_money_identifier, number_to_words
from perintah.models import Pelaksana, PemberiTugas
from profiles.utils import get_active_opd_id, get_pengguna_nip
from umum.models import Pemda, Penandatangan

from .access import (
    filter_spj_queryset_for_user,
    is_spj_approver_user,
    is_spj_admin_user,
    is_spj_verifikator_user,
)
from .forms import (
    JenisSPJForm,
    LaporanPerjalananForm,
    LaporanPerjalananMediaForm,
    PenginapanForm,
    PenginapanMediaForm,
    PesawatForm,
    TransportForm,
    UangHarianForm,
    UangRepresentasiForm,
)
from .models import (
    JenisSPJ,
    LaporanPerjalanan,
    Penginapan,
    Pesawat,
    Transport,
    UangHarian,
    UangRepresentasi,
    build_day_breakdown_from_items,
    quantize_money,
)
from .tables import (
    JenisSPJTable,
    LaporanPerjalananTable,
    PenginapanTable,
    PesawatTable,
    TransportTable,
    UangHarianTable,
    UangRepresentasiTable,
)


class SPJPelaksanaOptionsView(LoginRequiredMixin, View):
    @staticmethod
    def _param(request, name):
        value = request.GET.get(name)
        if value:
            return value
        suffix = f"-{name}"
        for key, item in request.GET.items():
            if key.endswith(suffix) and item:
                return item
        return None

    @staticmethod
    def _html_options(queryset, selected_id=None):
        options = [format_html('<option value="">---------</option>')]
        options.append(
            format_html_join(
                "",
                '<option value="{}"{}>{}</option>',
                (
                    (
                        item.id,
                        format_html(" selected") if str(item.id) == str(selected_id) else "",
                        f"SPT #{item.spt_id} - {item.nama}",
                    )
                    for item in queryset.distinct()
                ),
            )
        )
        return HttpResponse("".join(str(option) for option in options))

    def get(self, request):
        spt_id = self._param(request, "spt")
        model = self._param(request, "model")
        jenis_spj_id = self._param(request, "jenis_spj")
        instance_id = self._param(request, "instance")
        selected_id = self._param(request, "pelaksana")
        queryset = Pelaksana.objects.select_related("nama").order_by("nama__nama")

        if not spt_id:
            if request.headers.get("HX-Request"):
                return self._html_options(queryset.none())
            return JsonResponse({"results": []})

        queryset = queryset.filter(spt_id=spt_id)

        pengguna_nip = get_pengguna_nip(request.user)
        if pengguna_nip:
            queryset = queryset.filter(nama__nip=pengguna_nip)
        elif not is_spj_admin_user(request.user):
            active_opd_id = get_active_opd_id(request)
            if active_opd_id:
                queryset = queryset.filter(nama__opd_id=active_opd_id)
            else:
                queryset = queryset.none()

        used = None
        if model == "uang_representasi":
            used = UangRepresentasi.objects.filter(spt_id=spt_id)
        elif model == "pesawat" and jenis_spj_id:
            used = Pesawat.objects.filter(
                spt_id=spt_id,
                jenis_spj_id=jenis_spj_id,
            )

        if used is not None:
            if instance_id:
                used = used.exclude(pk=instance_id)
            queryset = queryset.exclude(
                pk__in=used.values_list("pelaksana_id", flat=True)
            )

        if request.headers.get("HX-Request"):
            return self._html_options(queryset, selected_id)

        return JsonResponse({
            "results": [
                {"id": item.id, "text": f"SPT #{item.spt_id} - {item.nama}"}
                for item in queryset.distinct()
            ]
        })


class SPJCalculationView(LoginRequiredMixin, View):
    def get(self, request):
        jenis = request.GET.get("jenis")
        spt_id = request.GET.get("spt")
        pelaksana_id = request.GET.get("pelaksana")
        jumlah_hari = request.GET.get("jumlah_hari")
        tarif_penginapan = request.GET.get("tarif_penginapan") or "100"
        tarif_uang_harian = request.GET.get("tarif_uang_harian") or "100"
        data = {
            "nilai": None,
            "total": None,
            "eligible": False,
            "lama_perjalanan": None,
        }

        if not spt_id or not pelaksana_id:
            return JsonResponse(data)

        pelaksana_queryset = Pelaksana.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "nama",
            "nama__tingkat",
        )
        pelaksana_queryset = filter_spj_queryset_for_user(
            pelaksana_queryset,
            request,
            "nama__nip",
        )
        try:
            pelaksana = pelaksana_queryset.get(pk=pelaksana_id, spt_id=spt_id)
        except Pelaksana.DoesNotExist:
            return JsonResponse(data)

        data["lama_perjalanan"] = pelaksana.spt.lama_perjalanan
        try:
            jumlah_hari = int(jumlah_hari)
        except (TypeError, ValueError):
            jumlah_hari = pelaksana.spt.lama_perjalanan

        if jenis == "uang_harian":
            obj = UangHarian(spt=pelaksana.spt, pelaksana=pelaksana)
            obj.jenis_tarif_uang_harian = tarif_uang_harian
            nilai = obj.get_tarif_per_hari()
            data["nilai"] = str(nilai) if nilai is not None else None
            data["total"] = (
                str(nilai * jumlah_hari)
                if nilai is not None else None
            )
            data["eligible"] = nilai is not None
            data["rincian"] = f"{jumlah_hari} hari x {tarif_uang_harian}%"
        elif jenis == "penginapan":
            obj = Penginapan(spt=pelaksana.spt, pelaksana=pelaksana)
            nilai = obj.get_standar_maksimal()
            tarif_30 = (
                quantize_money(nilai * Decimal("0.30"))
                if nilai is not None else None
            )
            tarif = (
                tarif_30 if tarif_penginapan == "30"
                else Decimal("0") if tarif_penginapan == "0"
                else None
            )
            data["nilai"] = str(nilai) if nilai is not None else None
            data["harga_30"] = str(tarif_30) if tarif_30 is not None else None
            data["total"] = (
                str(tarif * jumlah_hari)
                if tarif is not None else None
            )
            data["eligible"] = nilai is not None
            data["rincian"] = f"{jumlah_hari} hari x {tarif_penginapan}%"
        elif jenis == "representasi":
            obj = UangRepresentasi(spt=pelaksana.spt, pelaksana=pelaksana)
            nilai = obj.get_standar_maksimal()
            data["nilai"] = str(nilai) if nilai is not None else None
            data["eligible"] = nilai is not None

        return JsonResponse(data)


class SPJAvailableOptionsView(LoginRequiredMixin, View):
    def get(self, request):
        model = request.GET.get("model")
        if model != "transport":
            return JsonResponse({
                "unavailable_jenis_spj": [],
                "unavailable_jenis_transportasi": [],
            })

        spt_id = request.GET.get("spt")
        pelaksana_id = request.GET.get("pelaksana")
        jenis_spj_id = request.GET.get("jenis_spj")
        instance_id = request.GET.get("instance")

        queryset = filter_spj_queryset_for_user(
            Transport.objects.all(),
            request,
            "pelaksana__nama__nip",
        )
        if instance_id:
            queryset = queryset.exclude(pk=instance_id)

        unavailable_transport = []
        unavailable_jenis_spj = []

        if spt_id and pelaksana_id and jenis_spj_id:
            unavailable_transport = list(
                queryset.filter(
                    spt_id=spt_id,
                    pelaksana_id=pelaksana_id,
                    jenis_spj_id=jenis_spj_id,
                ).values_list("jenis_transportasi_id", flat=True)
            )

        if spt_id and pelaksana_id:
            total_transport_types = (
                Transport._meta.get_field("jenis_transportasi")
                .remote_field.model.objects.count()
            )
            if total_transport_types:
                used_by_jenis = (
                    queryset.filter(spt_id=spt_id, pelaksana_id=pelaksana_id)
                    .values("jenis_spj_id")
                    .annotate(
                        used_count=Count("jenis_transportasi_id", distinct=True)
                    )
                    .filter(used_count__gte=total_transport_types)
                )
                unavailable_jenis_spj = [
                    item["jenis_spj_id"] for item in used_by_jenis
                ]

        return JsonResponse({
            "unavailable_jenis_spj": unavailable_jenis_spj,
            "unavailable_jenis_transportasi": unavailable_transport,
        })


def _date_param(request, name):
    value = request.GET.get(name)
    if not value:
        return None
    try:
        return datetime.strptime(value, "%Y-%m-%d").date()
    except ValueError:
        return None


def _first_or_none(queryset):
    return queryset.first()


def _decimal_or_zero(value):
    return value or Decimal("0")


def _append_kwitansi_item(items, label, amount, keterangan=""):
    amount = _decimal_or_zero(amount)
    if amount <= 0:
        return
    items.append({
        "label": label,
        "amount": amount,
        "keterangan": keterangan,
    })


def _transport_queryset_for_direction(transports, direction):
    return [
        transport for transport in transports
        if (
            getattr(getattr(transport, "jenis_spj", None), "jenis_spj", "")
            or ""
        ).strip().lower() == direction
    ]


def _sum_transport(transports):
    return sum(
        (
            getattr(transport, "total_biaya", Decimal("0")) or Decimal("0")
            for transport in transports
        ),
        Decimal("0"),
    )


def _join_transport_summary(transports, attr_name=None):
    values = []
    for transport in transports:
        jenis = str(getattr(transport, "jenis_transportasi", "") or "").strip()
        value = getattr(transport, attr_name) if attr_name else ""
        if hasattr(value, "strftime"):
            value = value.strftime("%d/%m/%Y")
        value = str(value or "").strip()

        if jenis and value:
            values.append(f"{jenis}: {value}")
        elif jenis:
            values.append(jenis)
        elif value:
            values.append(value)

    return "\n".join(values) or "-"


def _build_kwitansi_items(pelaksana):
    spt = pelaksana.spt
    items = []

    uang_harians = UangHarian.objects.filter(
        spt=spt,
        pelaksana=pelaksana,
    )
    for uang_harian in uang_harians:
        _append_kwitansi_item(
            items,
            (
                "Uang harian perjalanan dinas "
                f"({uang_harian.jenis_tarif_uang_harian}%)"
            ),
            uang_harian.total_biaya,
            f"{uang_harian.jumlah_hari_spj} hari",
        )

    representasi = UangRepresentasi.objects.filter(
        spt=spt,
        pelaksana=pelaksana,
    ).first()
    if representasi:
        _append_kwitansi_item(
            items,
            "Uang representasi",
            representasi.total_biaya,
        )

    for pesawat in Pesawat.objects.filter(
        spt=spt,
        pelaksana=pelaksana,
    ).select_related("jenis_spj", "lokasi_bandara", "tujuan_bandara"):
        tujuan = f"{pesawat.lokasi_bandara} - {pesawat.tujuan_bandara}"
        _append_kwitansi_item(
            items,
            f"Tiket pesawat {pesawat.jenis_spj}",
            pesawat.total_biaya,
            tujuan,
        )

    penginapans = Penginapan.objects.filter(
        spt=spt,
        pelaksana=pelaksana,
    )
    for penginapan in penginapans:
        _append_kwitansi_item(
            items,
            (
                f"Penginapan {penginapan.nama_hotel}".strip()
                or "Penginapan"
            ),
            penginapan.total_biaya,
            (
                f"{penginapan.lama_menginap} malam "
                f"({penginapan.jenis_tarif_penginapan}%)"
            ),
        )

    for transport in Transport.objects.filter(
        spt=spt,
        pelaksana=pelaksana,
    ).select_related("jenis_spj", "jenis_transportasi", "tujuan"):
        _append_kwitansi_item(
            items,
            f"Transport {transport.jenis_spj} - {transport.jenis_transportasi}",
            transport.total_biaya,
            str(transport.tujuan or ""),
        )

    total = sum((item["amount"] for item in items), Decimal("0"))
    return items, total


class SPJQuerysetMixin:
    template_name = "spj/page.html"
    template_form = "spj/form_page.html"
    template_delete = "spj/delete_page.html"
    template_detail = "spj/detail_page.html"
    media_form_class = None

    def dispatch(self, request, *args, **kwargs):
        action = kwargs.get("action")
        pk = kwargs.get("pk")
        if action == "detail" and pk:
            return self.detail_view(request, pk)
        if action == "approve" and pk:
            return self.approve_view(request, pk)
        if "media" in request.path:
            return self.media_view(request, pk)
        return super().dispatch(request, *args, **kwargs)

    def get_base_queryset(self):
        queryset = self.model.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "pelaksana",
            "pelaksana__nama",
            "pelaksana__nama__opd",
            "pelaksana__nama__tingkat",
        ).order_by("-id")
        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def _is_locked_for_user(self, instance):
        return (
            getattr(instance, "verif_status", None) == "verified"
            and not is_spj_verifikator_user(self.request.user)
        )

    def _format_detail_value(self, field, value):
        if value in (None, ""):
            return "-"

        if getattr(field, "is_relation", False):
            return str(value)

        if hasattr(value, "url"):
            try:
                return {
                    "label": getattr(value, "name", "") or "Lihat file",
                    "url": value.url,
                }
            except ValueError:
                return "-"

        if is_money_identifier(field.name):
            return format_indonesian_number(value)

        return value

    def _build_detail_rows(self, instance):
        skip_fields = {
            "id",
            "created_at",
            "updated_at",
            "verif_status",
            "verified_by",
            "verified_at",
        }
        rows = []
        for field in instance._meta.fields:
            if field.name in skip_fields:
                continue
            rows.append({
                "label": field.verbose_name,
                "value": self._format_detail_value(
                    field,
                    getattr(instance, field.name),
                ),
            })

        if hasattr(instance, "get_standar_maksimal"):
            standard = instance.get_standar_maksimal()
            rows.append({
                "label": "Standar Maksimal",
                "value": "-" if standard is None else format_indonesian_number(standard),
            })
        if hasattr(instance, "total_biaya"):
            rows.append({
                "label": "Total Biaya",
                "value": format_indonesian_number(instance.total_biaya),
            })

        return rows

    def detail_view(self, request, pk):
        perm = self.get_permission()
        if not perm or not perm.can_view:
            return self._forbidden(request)

        instance = get_object_or_404(self.get_object_queryset(), pk=pk)
        can_approve = is_spj_approver_user(request.user)
        context = {
            "object": instance,
            "detail_rows": self._build_detail_rows(instance),
            "title": self.title,
            "permission": perm,
            "url_list": self.url_list,
            "url_action_pk": self.url_action_pk,
            "can_approve_spj": can_approve,
            "approve_url": reverse(self.url_action_pk, args=[instance.pk, "approve"]),
            "edit_url": reverse(self.url_action_pk, args=[instance.pk, "update"]),
            "delete_url": reverse(self.url_action_pk, args=[instance.pk, "delete"]),
        }
        return render(request, self.template_detail, context)

    def approve_view(self, request, pk):
        if request.method != "POST":
            return redirect(reverse(self.url_action_pk, args=[pk, "detail"]))

        perm = self.get_permission()
        if not perm or not perm.can_view:
            return self._forbidden(request)
        if not is_spj_approver_user(request.user):
            messages.error(
                request,
                "Persetujuan SPJ hanya dapat dilakukan oleh Bendahara atau superuser.",
            )
            return redirect(reverse(self.url_action_pk, args=[pk, "detail"]))

        instance = get_object_or_404(self.get_object_queryset(), pk=pk)
        if instance.verif_status == "verified":
            messages.info(request, "SPJ sudah disetujui.")
        else:
            self.model.objects.filter(pk=instance.pk).update(
                verif_status="verified",
                verified_by=request.user,
                verified_at=timezone.now(),
            )
            messages.success(request, "SPJ berhasil disetujui.")

        return redirect(reverse(self.url_action_pk, args=[pk, "detail"]))

    def form_view(self, request, pk=None):
        perm = self.get_permission()
        if pk:
            if not perm or not perm.can_edit:
                return self._forbidden(request)
        else:
            if not perm or not perm.can_add:
                return self._forbidden(request)

        instance = None
        if pk:
            instance = get_object_or_404(self.get_object_queryset(), pk=pk)
            if self._is_locked_for_user(instance):
                messages.error(
                    request,
                    "Berkas SPJ sudah diverifikasi dan tidak dapat diubah.",
                )
                if request.headers.get("HX-Request"):
                    return self._forbidden(request)
                return redirect(self.url_list)

        form = self.form_class(**self.get_form_kwargs(request, instance=instance))

        if request.method == "POST" and form.is_valid():
            action = "update" if instance else "add"
            obj = form.save(commit=False)
            obj.save()
            form.save_m2m()

            if request.headers.get("HX-Request"):
                return self._build_htmx_success_response(action)

            self._add_success_message(request, action)
            return redirect(self.url_list)

        context = {
            "form": form,
            "title": self.title,
            "permission": perm,
            "url_list": self.url_list,
            "is_multipart_form": form.is_multipart(),
        }

        if request.method == "POST" and request.headers.get("HX-Request"):
            return self._build_htmx_error_response(request, context, form)

        return render(request, self.template_form, context)

    def delete_view(self, request, pk):
        perm = self.get_permission()
        if not perm or not perm.can_delete:
            return self._forbidden(request)

        instance = get_object_or_404(self.get_object_queryset(), pk=pk)
        if self._is_locked_for_user(instance):
            messages.error(
                request,
                "Berkas SPJ sudah diverifikasi dan tidak dapat dihapus.",
            )
            if request.headers.get("HX-Request"):
                return self._forbidden(request)
            return redirect(self.url_list)

        if request.method == "POST":
            try:
                instance.delete()
            except (models.ProtectedError, IntegrityError):
                error_msg = f"Data SPJ '{instance}' tidak dapat dihapus karena masih terkait dengan data lain."
                if request.headers.get("HX-Request"):
                    response = HttpResponse(status=200)
                    response["HX-Trigger"] = json.dumps({
                        "crudError": {
                            "title": "Gagal Menghapus Data",
                            "message": error_msg,
                            "level": "error",
                            "action": "delete",
                        }
                    })
                    return response
                messages.error(request, error_msg)
                return redirect(self.url_list)

            if request.headers.get("HX-Request"):
                return self._build_htmx_success_response("delete")

            self._add_success_message(request, "delete")
            return redirect(self.url_list)

        if request.headers.get("HX-Request"):
            return super().delete_view(request, pk)

        return render(request, self.template_delete, {
            "object": instance,
            "url_list": self.url_list,
            "title": self.title,
        })

    def media_view(self, request, pk):
        perm = self.get_permission()
        if not self.media_form_class:
            return self._forbidden(request)
        if not perm or not perm.can_edit:
            return self._forbidden(request)

        instance = get_object_or_404(self.get_object_queryset(), pk=pk)
        if self._is_locked_for_user(instance):
            messages.error(
                request,
                "Berkas SPJ sudah diverifikasi dan foto/lokasi tidak dapat diubah.",
            )
            return redirect(self.url_list)

        form = self.media_form_class(
            **self.get_form_kwargs(request, instance=instance)
        )

        if request.method == "POST" and form.is_valid():
            obj = form.save(commit=False)
            obj.save()
            form.save_m2m()
            messages.success(request, "Foto dan lokasi berhasil diperbarui.")
            return redirect(self.url_list)

        return render(request, self.template_form, {
            "form": form,
            "title": f"Foto & Lokasi {self.title}",
            "permission": perm,
            "url_list": self.url_list,
            "is_multipart_form": form.is_multipart(),
        })

class JenisSPJView(BaseCRUDView):
    model = JenisSPJ
    form_class = JenisSPJForm
    table_class = JenisSPJTable
    enable_excel = True

    title = "Jenis SPJ"
    url_list = "jenis_spj_list"
    url_action = "jenis_spj_action"
    url_action_pk = "jenis_spj_action_pk"


class PenginapanView(SPJQuerysetMixin, BaseCRUDView):
    model = Penginapan
    form_class = PenginapanForm
    media_form_class = PenginapanMediaForm
    table_class = PenginapanTable
    enable_excel = True

    title = "SPJ Penginapan"
    url_list = "penginapan_list"
    url_action = "penginapan_action"
    url_action_pk = "penginapan_action_pk"


class PesawatView(SPJQuerysetMixin, BaseCRUDView):
    model = Pesawat
    form_class = PesawatForm
    table_class = PesawatTable
    enable_excel = True

    title = "SPJ Pesawat"
    url_list = "pesawat_list"
    url_action = "pesawat_action"
    url_action_pk = "pesawat_action_pk"

    def get_base_queryset(self):
        return super().get_base_queryset().select_related(
            "jenis_spj",
            "lokasi_bandara",
            "lokasi_bandara__provinsi",
            "tujuan_bandara",
            "tujuan_bandara__provinsi",
        )


class UangHarianView(SPJQuerysetMixin, BaseCRUDView):
    model = UangHarian
    form_class = UangHarianForm
    table_class = UangHarianTable
    enable_excel = True

    title = "SPJ Uang Harian"
    url_list = "uang_harian_list"
    url_action = "uang_harian_action"
    url_action_pk = "uang_harian_action_pk"


class TransportView(SPJQuerysetMixin, BaseCRUDView):
    model = Transport
    form_class = TransportForm
    table_class = TransportTable
    enable_excel = True

    title = "SPJ Transport"
    url_list = "transport_list"
    url_action = "transport_action"
    url_action_pk = "transport_action_pk"

    def get_base_queryset(self):
        return super().get_base_queryset().select_related(
            "jenis_spj",
            "jenis_transportasi",
            "lokasi_berangkat",
            "tujuan",
        )


class UangRepresentasiView(SPJQuerysetMixin, BaseCRUDView):
    model = UangRepresentasi
    form_class = UangRepresentasiForm
    table_class = UangRepresentasiTable
    enable_excel = True

    title = "SPJ Uang Representasi"
    url_list = "uang_representasi_list"
    url_action = "uang_representasi_action"
    url_action_pk = "uang_representasi_action_pk"


class LaporanPerjalananView(SPJQuerysetMixin, BaseCRUDView):
    model = LaporanPerjalanan
    form_class = LaporanPerjalananForm
    media_form_class = LaporanPerjalananMediaForm
    table_class = LaporanPerjalananTable
    enable_excel = True

    title = "Laporan Perjalanan Dinas"
    url_list = "laporan_perjalanan_list"
    url_action = "laporan_perjalanan_action"
    url_action_pk = "laporan_perjalanan_action_pk"

    def get_base_queryset(self):
        queryset = self.model.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "pelaksana",
            "pelaksana__nama",
            "pelaksana__nama__opd",
            "pelaksana__nama__tingkat",
        ).order_by("-id")

        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()


class SPJReportView(LoginRequiredMixin, View):
    template_name = "spj/report.html"

    def _filter(self, queryset):
        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def _build_rows(self, request):
        start_date = _date_param(request, "tgl1")
        end_date = _date_param(request, "tgl2")
        nama_pelaksana = (request.GET.get("nama") or "").strip()
        pelaksana = Pelaksana.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "nama",
            "nama__pangkat",
            "nama__tingkat",
            "nama__opd",
        ).order_by("spt__tgl_berangkat", "nama__nama")

        pelaksana = filter_spj_queryset_for_user(
            pelaksana,
            request,
            "nama__nip",
        ).distinct()

        if start_date:
            pelaksana = pelaksana.filter(spt__tgl_berangkat__gte=start_date)
        if end_date:
            pelaksana = pelaksana.filter(spt__tgl_berangkat__lte=end_date)
        if nama_pelaksana:
            pelaksana = pelaksana.filter(nama__nama__icontains=nama_pelaksana)

        rows = []
        for item in pelaksana:
            spt = item.spt
            pemberi = PemberiTugas.objects.filter(spt=spt).first()
            pesawat_berangkat = Pesawat.objects.filter(
                spt=spt,
                pelaksana=item,
                jenis_spj__jenis_spj__iexact="Berangkat",
            ).first()
            pesawat_kembali = Pesawat.objects.filter(
                spt=spt,
                pelaksana=item,
                jenis_spj__jenis_spj__iexact="Kembali",
            ).first()
            hotels = list(Penginapan.objects.filter(spt=spt, pelaksana=item))
            uang_harians = list(UangHarian.objects.filter(spt=spt, pelaksana=item))
            hotel = next(
                (hotel_item for hotel_item in hotels if hotel_item.nama_hotel),
                hotels[0] if hotels else None,
            )
            uang_harian = uang_harians[0] if uang_harians else None
            hotel_total = sum(
                (hotel_item.total_biaya for hotel_item in hotels),
                Decimal("0"),
            )
            uang_harian_total = sum(
                (harian_item.total_biaya for harian_item in uang_harians),
                Decimal("0"),
            )
            representasi = UangRepresentasi.objects.filter(spt=spt, pelaksana=item).first()
            transports = list(
                Transport.objects.filter(spt=spt, pelaksana=item).select_related(
                    "jenis_spj",
                    "jenis_transportasi",
                    "tujuan",
                )
            )
            transport_berangkat = _transport_queryset_for_direction(
                transports,
                "berangkat",
            )
            transport_kembali = _transport_queryset_for_direction(
                transports,
                "kembali",
            )
            transport_berangkat_total = _sum_transport(transport_berangkat)
            transport_kembali_total = _sum_transport(transport_kembali)

            total = sum([
                uang_harian_total,
                getattr(representasi, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(pesawat_berangkat, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(pesawat_kembali, "total_biaya", Decimal("0")) or Decimal("0"),
                hotel_total,
                transport_berangkat_total,
                transport_kembali_total,
            ], Decimal("0"))

            rows.append({
                "spt": spt,
                "pelaksana": item,
                "pemberi": pemberi,
                "pesawat_berangkat": pesawat_berangkat,
                "pesawat_kembali": pesawat_kembali,
                "hotel": hotel,
                "uang_harian": uang_harian,
                "hotel_total": hotel_total,
                "uang_harian_total": uang_harian_total,
                "hotel_rincian": build_day_breakdown_from_items(
                    spt, hotels, "lama_menginap", "jenis_tarif_penginapan",
                ),
                "uang_harian_rincian": build_day_breakdown_from_items(
                    spt, uang_harians, "jumlah_hari_spj", "jenis_tarif_uang_harian",
                ),
                "representasi": representasi,
                "transport_berangkat": transport_berangkat,
                "transport_kembali": transport_kembali,
                "transport_berangkat_tujuan": _join_transport_summary(
                    transport_berangkat,
                    "tujuan",
                ),
                "transport_kembali_tujuan": _join_transport_summary(
                    transport_kembali,
                    "tujuan",
                ),
                "transport_berangkat_tanggal": _join_transport_summary(
                    transport_berangkat,
                    "tanggal_berangkat",
                ),
                "transport_kembali_tanggal": _join_transport_summary(
                    transport_kembali,
                    "tanggal_berangkat",
                ),
                "transport_berangkat_total": transport_berangkat_total,
                "transport_kembali_total": transport_kembali_total,
                "total": total,
            })

        return rows, start_date, end_date, nama_pelaksana

    def _row_values(self, idx, row):
        pegawai = row["pelaksana"].nama
        pangkat = pegawai.pangkat or "-"
        tingkat = pegawai.tingkat or "-"
        spt = row["spt"]
        pemberi = row["pemberi"]
        pb = row["pesawat_berangkat"]
        pk = row["pesawat_kembali"]
        hotel = row["hotel"]

        spt_year = spt.tgl_berangkat.year if (spt and spt.tgl_berangkat) else ""
        spt_id_str = f"SPT #{spt.id}" if spt else ""
        tahun_cell = f"{spt_year}\n{spt_id_str}".strip() if spt_year else spt_id_str

        tgl_spt_str = pemberi.tanggal_spt.strftime("%d/%m/%Y") if getattr(pemberi, "tanggal_spt", None) else "-"
        tgl_brk_str = spt.tgl_berangkat.strftime("%d/%m/%Y") if (spt and spt.tgl_berangkat) else "-"
        tgl_kbl_str = spt.tgl_kembali.strftime("%d/%m/%Y") if (spt and spt.tgl_kembali) else "-"

        tgl_pb_str = pb.tanggal_penerbangan.strftime("%d/%m/%Y") if getattr(pb, "tanggal_penerbangan", None) else "-"
        tgl_pk_str = pk.tanggal_penerbangan.strftime("%d/%m/%Y") if getattr(pk, "tanggal_penerbangan", None) else "-"

        tgl_chin_str = hotel.tanggal_checkin.strftime("%d/%m/%Y") if getattr(hotel, "tanggal_checkin", None) else "-"
        tgl_chout_str = hotel.tanggal_checkout.strftime("%d/%m/%Y") if getattr(hotel, "tanggal_checkout", None) else "-"

        hotel_nama_alamat = f"{getattr(hotel, 'nama_hotel', '')} {getattr(hotel, 'alamat_hotel', '')}".strip() or "-"

        return [
            idx,
            tahun_cell,
            str(spt.jenis_kegiatan or "") if spt else "-",
            pegawai.nama,
            f"{pegawai.jabatan or '-'} / {pangkat} / {tingkat}",
            getattr(pemberi, "nomor_spt", "") or "-",
            tgl_spt_str,
            (spt.tujuan_perjalanan_display if spt else "") or "-",
            spt.lama_perjalanan if spt else 0,
            tgl_brk_str,
            tgl_kbl_str,
            getattr(pemberi, "nomor_spd", "") or "-",
            tgl_spt_str,
            (spt.tujuan_perjalanan_display if spt else "") or "-",
            spt.lama_perjalanan if spt else 0,
            tgl_brk_str,
            tgl_kbl_str,
            float(row["uang_harian_total"] or 0),
            str(row["uang_harian_rincian"] or ""),
            float(getattr(row["representasi"], "total_biaya", 0) or 0),
            getattr(pb, "nama_maskapai", "") or "-",
            getattr(pb, "nomor_tiket", "") or "-",
            getattr(pb, "kode_booking", "") or "-",
            tgl_pb_str,
            float(getattr(pb, "harga_tiket", 0) or 0),
            getattr(pk, "nama_maskapai", "") or "-",
            getattr(pk, "nomor_tiket", "") or "-",
            getattr(pk, "kode_booking", "") or "-",
            tgl_pk_str,
            float(getattr(pk, "harga_tiket", 0) or 0),
            hotel_nama_alamat,
            getattr(hotel, "tipe_kamar", "") or "-",
            getattr(hotel, "nomor_kamar", "") or "-",
            tgl_chin_str,
            tgl_chout_str,
            getattr(hotel, "lama_menginap", "") or "-",
            float(getattr(hotel, "harga_per_malam", 0) or 0),
            float(row["hotel_total"] or 0),
            str(row["hotel_rincian"] or ""),
            str(row["transport_berangkat_tujuan"] or "-"),
            str(row["transport_berangkat_tanggal"] or tgl_brk_str),
            float(row["transport_berangkat_total"] or 0),
            str(row["transport_kembali_tujuan"] or "-"),
            str(row["transport_kembali_tanggal"] or tgl_kbl_str),
            float(row["transport_kembali_total"] or 0),
            float(row["total"] or 0),
        ]

    def _excel_response(self, rows, start_date=None, end_date=None, nama_pelaksana=""):
        wb = Workbook()
        ws = wb.active
        ws.title = "Rekap SPJ"
        ws.views.sheetView[0].showGridLines = True

        font_title = Font(name="Arial", size=13, bold=True, color="1E3A8A")
        font_sub = Font(name="Arial", size=10, bold=True, color="334155")
        font_meta = Font(name="Arial", size=8.5, italic=True, color="64748B")

        fill_h1 = PatternFill(start_color="1E3A8A", end_color="1E3A8A", fill_type="solid")
        font_h1 = Font(name="Arial", size=9, bold=True, color="FFFFFF")

        fill_h2 = PatternFill(start_color="2563EB", end_color="2563EB", fill_type="solid")
        font_h2 = Font(name="Arial", size=8.5, bold=True, color="FFFFFF")

        fill_h3 = PatternFill(start_color="F1F5F9", end_color="F1F5F9", fill_type="solid")
        font_h3 = Font(name="Arial", size=8, bold=True, color="1E293B")

        fill_even = PatternFill(start_color="F8FAFC", end_color="F8FAFC", fill_type="solid")
        fill_odd = PatternFill(start_color="FFFFFF", end_color="FFFFFF", fill_type="solid")
        fill_tot = PatternFill(start_color="E2E8F0", end_color="E2E8F0", fill_type="solid")

        border_thin = Border(
            left=Side(style='thin', color="CBD5E1"),
            right=Side(style='thin', color="CBD5E1"),
            top=Side(style='thin', color="CBD5E1"),
            bottom=Side(style='thin', color="CBD5E1")
        )
        border_head = Border(
            left=Side(style='thin', color="94A3B8"),
            right=Side(style='thin', color="94A3B8"),
            top=Side(style='thin', color="94A3B8"),
            bottom=Side(style='thin', color="94A3B8")
        )
        border_grand = Border(
            left=Side(style='thin', color="94A3B8"),
            right=Side(style='thin', color="94A3B8"),
            top=Side(style='medium', color="0F172A"),
            bottom=Side(style='double', color="0F172A")
        )

        align_c = Alignment(horizontal="center", vertical="center", wrap_text=True)
        align_l = Alignment(horizontal="left", vertical="center", wrap_text=True)
        align_r = Alignment(horizontal="right", vertical="center")

        # 1. Header Information
        ws.merge_cells("A1:AT1")
        ws["A1"] = "PEMERINTAH KABUPATEN ASAHAN - BADAN KEUANGAN DAN ASET DAERAH (BKAD)"
        ws["A1"].font = font_sub
        ws["A1"].alignment = Alignment(horizontal="center", vertical="center")
        ws.row_dimensions[1].height = 20

        ws.merge_cells("A2:AT2")
        ws["A2"] = "LAPORAN REKAPITULASI PENGAWAS PERJALANAN DINAS (SPJ)"
        ws["A2"].font = font_title
        ws["A2"].alignment = Alignment(horizontal="center", vertical="center")
        ws.row_dimensions[2].height = 24

        meta_text = "Periode: "
        if start_date and end_date:
            meta_text += f"{start_date.strftime('%d/%m/%Y')} s.d. {end_date.strftime('%d/%m/%Y')}"
        elif start_date:
            meta_text += f"Mulai {start_date.strftime('%d/%m/%Y')}"
        elif end_date:
            meta_text += f"Sampai {end_date.strftime('%d/%m/%Y')}"
        else:
            meta_text += "Semua Tanggal"
        if nama_pelaksana:
            meta_text += f" | Pelaksana: {nama_pelaksana}"
        meta_text += f" | Total: {len(rows)} data | Dicetak: {timezone.now().strftime('%d/%m/%Y %H:%M')} WIB"

        ws.merge_cells("A3:AT3")
        ws["A3"] = meta_text
        ws["A3"].font = font_meta
        ws["A3"].alignment = Alignment(horizontal="center", vertical="center")
        ws.row_dimensions[3].height = 18
        ws.row_dimensions[4].height = 8

        # 2. Table Headers (Rows 5, 6, 7)
        ws.row_dimensions[5].height = 24
        ws.row_dimensions[6].height = 20
        ws.row_dimensions[7].height = 26

        # Row 5 (Top Level Categories)
        ws.merge_cells("A5:A7"); ws["A5"] = "NO"
        ws.merge_cells("B5:B7"); ws["B5"] = "TAHUN &\nID SPT"
        ws.merge_cells("C5:C7"); ws["C5"] = "JENIS PERJALANAN"
        ws.merge_cells("D5:D7"); ws["D5"] = "NAMA PELAKSANA"
        ws.merge_cells("E5:E7"); ws["E5"] = "JABATAN / GOL / TINGKAT"
        ws.merge_cells("F5:K6"); ws["F5"] = "SURAT PERINTAH TUGAS"
        ws.merge_cells("L5:Q6"); ws["L5"] = "SURAT PERJALANAN DINAS"
        ws.merge_cells("R5:T6"); ws["R5"] = "BIAYA PERJALANAN DINAS"
        ws.merge_cells("U5:AD5"); ws["U5"] = "PESAWAT"
        ws.merge_cells("AE5:AM6"); ws["AE5"] = "HOTEL / AKOMODASI"
        ws.merge_cells("AN5:AS5"); ws["AN5"] = "TAKSI / TRANSPORT LOKAL"
        ws.merge_cells("AT5:AT7"); ws["AT5"] = "TOTAL"

        # Row 6 (Sub Groups)
        ws.merge_cells("U6:Y6"); ws["U6"] = "BERANGKAT"
        ws.merge_cells("Z6:AD6"); ws["Z6"] = "KEMBALI"
        ws.merge_cells("AN6:AP6"); ws["AN6"] = "BERANGKAT"
        ws.merge_cells("AQ6:AS6"); ws["AQ6"] = "KEMBALI"

        # Row 7 (Column Names)
        col_names = [
            (6, "NO. SPT"), (7, "TANGGAL"), (8, "TEMPAT TUJUAN"), (9, "JUMLAH HARI"), (10, "TGL BERANGKAT"), (11, "TGL KEMBALI"),
            (12, "NO. SPD"), (13, "TANGGAL"), (14, "TEMPAT TUJUAN"), (15, "JUMLAH HARI"), (16, "TGL BERANGKAT"), (17, "TGL KEMBALI"),
            (18, "UANG HARIAN"), (19, "RINCIAN HARI"), (20, "REPRESENTATIF"),
            (21, "MASKAPAI"), (22, "NO. TIKET"), (23, "KODE BOOKING"), (24, "TGL PENERBANGAN"), (25, "HARGA"),
            (26, "MASKAPAI"), (27, "NO. TIKET"), (28, "KODE BOOKING"), (29, "TGL PENERBANGAN"), (30, "HARGA"),
            (31, "NAMA & LOKASI HOTEL"), (32, "TIPE KAMAR"), (33, "NOMOR KAMAR"), (34, "TGL CHECKIN"), (35, "TGL CHECKOUT"), (36, "LAMA"), (37, "HARGA / MLM"), (38, "TOTAL HOTEL"), (39, "RINCIAN HARI"),
            (40, "TUJUAN"), (41, "TGL BERANGKAT"), (42, "BIAYA"),
            (43, "TUJUAN"), (44, "TGL KEMBALI"), (45, "BIAYA"),
        ]
        for col_idx, label in col_names:
            ws.cell(row=7, column=col_idx, value=label)

        # Style Header Cells
        for r in range(5, 8):
            for c in range(1, 47):
                cell = ws.cell(row=r, column=c)
                cell.border = border_head
                if r == 5:
                    cell.fill = fill_h1
                    cell.font = font_h1
                    cell.alignment = align_c
                elif r == 6:
                    if c in range(21, 31) or c in range(40, 46):
                        cell.fill = fill_h2
                        cell.font = font_h2
                        cell.alignment = align_c
                    elif not cell.fill.start_color.rgb:
                        cell.fill = fill_h1
                        cell.font = font_h1
                elif r == 7:
                    if not cell.fill.start_color.rgb:
                        cell.fill = fill_h3
                        cell.font = font_h3
                        cell.alignment = align_c

        # 3. Data Rows
        currency_col_indices = {18, 20, 25, 30, 37, 38, 42, 45, 46}
        center_col_indices = {1, 2, 7, 9, 10, 11, 13, 15, 16, 17, 24, 29, 33, 34, 35, 36, 41, 44}

        start_data_row = 8
        for idx, row in enumerate(rows, start=1):
            curr_row = start_data_row + idx - 1
            ws.row_dimensions[curr_row].height = 22
            row_fill = fill_even if idx % 2 == 0 else fill_odd
            row_vals = self._row_values(idx, row)

            for col_idx, val in enumerate(row_vals, start=1):
                cell = ws.cell(row=curr_row, column=col_idx, value=val)
                cell.fill = row_fill
                cell.border = border_thin
                cell.font = Font(name="Arial", size=8.5, color="0F172A")

                if col_idx in currency_col_indices:
                    cell.alignment = align_r
                    cell.number_format = '#,##0'
                elif col_idx in center_col_indices:
                    cell.alignment = align_c
                else:
                    cell.alignment = align_l

        # 4. Grand Total Row
        total_row_num = start_data_row + len(rows)
        ws.row_dimensions[total_row_num].height = 24
        ws.merge_cells(f"A{total_row_num}:AS{total_row_num}")
        ws[f"A{total_row_num}"] = "GRAND TOTAL BIAYA PERJALANAN DINAS"
        ws[f"A{total_row_num}"].font = Font(name="Arial", size=9.5, bold=True, color="0F172A")
        ws[f"A{total_row_num}"].alignment = Alignment(horizontal="right", vertical="center")

        if rows:
            ws[f"AT{total_row_num}"] = f"=SUM(AT{start_data_row}:AT{total_row_num-1})"
        else:
            ws[f"AT{total_row_num}"] = 0

        ws[f"AT{total_row_num}"].font = Font(name="Arial", size=9.5, bold=True, color="1E3A8A")
        ws[f"AT{total_row_num}"].alignment = align_r
        ws[f"AT{total_row_num}"].number_format = '#,##0'

        for c in range(1, 47):
            tot_cell = ws.cell(row=total_row_num, column=c)
            tot_cell.fill = fill_tot
            tot_cell.border = border_grand

        # 5. Column Widths
        fixed_widths = {
            1: 6,    # NO
            2: 13,   # TAHUN & ID SPT
            3: 18,   # JENIS
            4: 25,   # NAMA
            5: 28,   # JABATAN / GOL / TINGKAT
            6: 22,   # NO SPT
            7: 12,   # TGL SPT
            8: 20,   # TUJUAN
            9: 9,    # HARI
            10: 12,  # TGL BRK
            11: 12,  # TGL KBL
            12: 22,  # NO SPD
            13: 12,  # TGL SPD
            14: 20,  # TUJUAN
            15: 9,   # HARI
            16: 12,  # TGL BRK
            17: 12,  # TGL KBL
            18: 15,  # UANG HARIAN
            19: 20,  # RINCIAN HARIAN
            20: 15,  # REPRESENTASI
            21: 16,  # MASKAPAI BRK
            22: 16,  # TIKET BRK
            23: 14,  # BOOKING BRK
            24: 12,  # TGL PENERB BRK
            25: 14,  # HARGA BRK
            26: 16,  # MASKAPAI KBL
            27: 16,  # TIKET KBL
            28: 14,  # BOOKING KBL
            29: 12,  # TGL PENERB KBL
            30: 14,  # HARGA KBL
            31: 28,  # NAMA & LOKASI HOTEL
            32: 14,  # TIPE KAMAR
            33: 12,  # NO KAMAR
            34: 12,  # CHECKIN
            35: 12,  # CHECKOUT
            36: 8,   # LAMA
            37: 14,  # HARGA/MLM
            38: 15,  # TOTAL HOTEL
            39: 20,  # RINCIAN HOTEL
            40: 18,  # TUJUAN TR BRK
            41: 12,  # TGL TR BRK
            42: 14,  # BIAYA TR BRK
            43: 18,  # TUJUAN TR KBL
            44: 12,  # TGL TR KBL
            45: 14,  # BIAYA TR KBL
            46: 17,  # TOTAL
        }
        for col_idx in range(1, 47):
            col_letter = get_column_letter(col_idx)
            ws.column_dimensions[col_letter].width = fixed_widths.get(col_idx, 15)

        stream = BytesIO()
        wb.save(stream)
        response = HttpResponse(
            stream.getvalue(),
            content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        )
        response["Content-Disposition"] = 'attachment; filename="laporan-rekap-spj.xlsx"'
        return response

    def _pdf_response(self, request, rows, start_date=None, end_date=None, nama_pelaksana=""):
        grand_total = sum((row["total"] for row in rows), Decimal("0"))
        response = render(request, "spj/report_print.html", {
            "title": "Laporan Rekapitulasi Pengawas Perjalanan Dinas",
            "rows": rows,
            "grand_total": grand_total,
            "start_date": start_date,
            "end_date": end_date,
            "nama_pelaksana": nama_pelaksana,
            "auto_print": True,
        })
        response["X-Frame-Options"] = "SAMEORIGIN"
        return response

    def get(self, request):
        rows, start_date, end_date, nama_pelaksana = self._build_rows(request)
        export = request.GET.get("export")
        if export == "excel":
            return self._excel_response(rows, start_date, end_date, nama_pelaksana)
        if export == "pdf":
            return self._pdf_response(request, rows, start_date, end_date, nama_pelaksana)

        grand_total = sum((row["total"] for row in rows), Decimal("0"))
        return render(request, self.template_name, {
            "title": "Laporan Pengawas",
            "rows": rows,
            "grand_total": grand_total,
            "start_date": start_date,
            "end_date": end_date,
            "nama_pelaksana": nama_pelaksana,
        })


class DataPerjalananPerOrangView(LoginRequiredMixin, View):
    template_name = "spj/data_perjalanan_per_orang.html"
    title = "Data Perjalanan Per Orang"

    def _base_queryset(self, request):
        has_spt = PemberiTugas.objects.filter(
            spt_id=OuterRef("spt_id"),
            nomor_spt__isnull=False,
        ).exclude(nomor_spt="")
        has_spd = PemberiTugas.objects.filter(
            spt_id=OuterRef("spt_id"),
            nomor_spd__isnull=False,
        ).exclude(nomor_spd="")

        queryset = Pelaksana.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "nama",
            "nama__pangkat",
            "nama__tingkat",
            "nama__eselon",
            "nama__opd",
        ).annotate(
            has_nomor_spt=Exists(has_spt),
            has_nomor_spd=Exists(has_spd),
        ).order_by(
            "nama__nama",
            "spt__tgl_berangkat",
            "spt_id",
        )

        return filter_spj_queryset_for_user(
            queryset,
            request,
            "nama__nip",
        ).distinct()

    def _build_rows(self, request):
        start_date = _date_param(request, "tgl1")
        end_date = _date_param(request, "tgl2")
        keyword = (request.GET.get("nama") or request.GET.get("search") or "").strip()
        queryset = self._base_queryset(request)

        if start_date:
            queryset = queryset.filter(spt__tgl_berangkat__gte=start_date)
        if end_date:
            queryset = queryset.filter(spt__tgl_berangkat__lte=end_date)
        if keyword:
            queryset = queryset.filter(
                Q(nama__nama__icontains=keyword)
                | Q(nama__nip__icontains=keyword)
                | Q(spt__tempat_tujuan__icontains=keyword)
                | Q(spt__kota_tujuan__lokasi__icontains=keyword)
            )

        rows = list(queryset)
        documents_by_spt = {}
        spt_ids = [item.spt_id for item in rows]
        if spt_ids:
            for document in PemberiTugas.objects.filter(
                spt_id__in=spt_ids,
            ).order_by("spt_id", "id").values(
                "spt_id",
                "nomor_spt",
                "nomor_spd",
            ):
                numbers = documents_by_spt.setdefault(
                    document["spt_id"],
                    {
                        "nomor_spt": [],
                        "nomor_spd": [],
                    },
                )
                nomor_spt = (document["nomor_spt"] or "").strip()
                nomor_spd = (document["nomor_spd"] or "").strip()
                if nomor_spt and nomor_spt not in numbers["nomor_spt"]:
                    numbers["nomor_spt"].append(nomor_spt)
                if nomor_spd and nomor_spd not in numbers["nomor_spd"]:
                    numbers["nomor_spd"].append(nomor_spd)

        person_stats = {}
        grouped_map = {}
        for item in rows:
            key = item.nama_id
            stats = person_stats.setdefault(key, {
                "spt_count": 0,
                "spd_count": 0,
            })
            stats["spt_count"] += 1
            if item.has_nomor_spd:
                stats["spd_count"] += 1

            numbers = documents_by_spt.get(item.spt_id, {})
            item.nomor_spt_display = ", ".join(numbers.get("nomor_spt", [])) or "-"
            item.nomor_spd_display = ", ".join(numbers.get("nomor_spd", [])) or "-"

            group = grouped_map.setdefault(key, {
                "pegawai": item.nama,
                "stats": stats,
                "perjalanan": [],
                "rowspan": 0,
            })
            group["perjalanan"].append(item)
            group["rowspan"] += 1

        grouped_rows = list(grouped_map.values())

        return rows, grouped_rows, person_stats, start_date, end_date, keyword

    def _excel_response(self, rows):
        import io
        from openpyxl import Workbook
        from openpyxl.styles import Font, PatternFill, Alignment, Border, Side

        wb = Workbook()
        ws = wb.active
        ws.title = "Rekap Perjalanan"

        header_fill = PatternFill(start_color="065F46", end_color="065F46", fill_type="solid")
        header_font = Font(name="Arial", size=11, bold=True, color="FFFFFF")
        header_alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
        header_border = Border(
            left=Side(style='thin', color="064E3B"),
            right=Side(style='thin', color="064E3B"),
            top=Side(style='thin', color="064E3B"),
            bottom=Side(style='medium', color="D97706")
        )

        headers = [
            "No", "Nama Pelaksana", "NIP", "Pangkat/Gol", "OPD",
            "ID SPT", "Nomor SPT", "Nomor SPD",
            "Tgl Berangkat", "Tgl Kembali", "Tempat Tujuan",
            "Berita Perjadin", "Keterangan"
        ]

        ws.row_dimensions[1].height = 28
        for col_idx, h in enumerate(headers, 1):
            cell = ws.cell(row=1, column=col_idx)
            cell.value = h
            cell.fill = header_fill
            cell.font = header_font
            cell.alignment = header_alignment
            cell.border = header_border

        even_fill = PatternFill(start_color="F4FAF6", end_color="F4FAF6", fill_type="solid")
        odd_fill = PatternFill(start_color="FFFFFF", end_color="FFFFFF", fill_type="solid")
        cell_border = Border(
            left=Side(style='thin', color="E2E8F0"),
            right=Side(style='thin', color="E2E8F0"),
            top=Side(style='thin', color="E2E8F0"),
            bottom=Side(style='thin', color="E2E8F0")
        )
        data_font = Font(name="Arial", size=10, color="0F172A")
        align_left = Alignment(horizontal="left", vertical="center", wrap_text=True)
        align_center = Alignment(horizontal="center", vertical="center")

        for idx, item in enumerate(rows, 1):
            row_num = idx + 1
            ws.row_dimensions[row_num].height = 22
            row_fill = even_fill if row_num % 2 == 0 else odd_fill

            pegawai = item.nama
            spt = item.spt

            tgl_brk = spt.tgl_berangkat.strftime("%d/%m/%Y") if spt and spt.tgl_berangkat else "-"
            tgl_kmb = spt.tgl_kembali.strftime("%d/%m/%Y") if spt and spt.tgl_kembali else "-"

            pangkat_display = str(pegawai.pangkat) if pegawai and pegawai.pangkat else "-"
            opd_display = str(pegawai.opd) if pegawai and pegawai.opd else "-"

            ket = "Ada Nomor SPD" if item.has_nomor_spd else "Belum Ada Nomor SPD"

            row_values = [
                idx,
                pegawai.nama if pegawai else "-",
                pegawai.nip if pegawai else "-",
                pangkat_display,
                opd_display,
                item.spt_id,
                item.nomor_spt_display,
                item.nomor_spd_display,
                tgl_brk,
                tgl_kmb,
                spt.tempat_tujuan_display or spt.tempat_tujuan if spt else "-",
                spt.berita if spt else "-",
                ket,
            ]

            for col_idx, val in enumerate(row_values, 1):
                cell = ws.cell(row=row_num, column=col_idx)
                cell.value = val
                cell.fill = row_fill
                cell.font = data_font
                cell.border = cell_border
                cell.alignment = align_center if col_idx in [1, 3, 6, 9, 10] else align_left

        for col in ws.columns:
            max_len = max(len(str(cell.value or '')) for cell in col)
            col_letter = col[0].column_letter
            ws.column_dimensions[col_letter].width = min(max(max_len + 4, 12), 50)

        ws.freeze_panes = "A2"
        if ws.max_row > 1:
            ws.auto_filter.ref = ws.dimensions

        output = io.BytesIO()
        wb.save(output)
        output.seek(0)

        response = HttpResponse(
            output.getvalue(),
            content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        )
        response["Content-Disposition"] = 'attachment; filename="rekap_perjalanan_per_orang.xlsx"'
        return response

    def get(self, request):
        rows, grouped_rows, person_stats, start_date, end_date, keyword = (
            self._build_rows(request)
        )

        if request.GET.get("export") == "excel":
            return self._excel_response(rows)

        return render(request, self.template_name, {
            "title": self.title,
            "rows": rows,
            "grouped_rows": grouped_rows,
            "person_stats": person_stats,
            "start_date": start_date,
            "end_date": end_date,
            "nama_pelaksana": keyword,
        })


class KwitansiView(LoginRequiredMixin, View):
    template_name = "spj/kwitansi.html"

    def _bendahara_queryset(self, request):
        queryset = Penandatangan.objects.select_related(
            "opd",
            "pangkat",
            "tugas",
            "jenis_jabatan",
        ).filter(tugas__nama="Bendahara")

        active_opd_id = get_active_opd_id(request)
        if active_opd_id:
            queryset = queryset.filter(
                Q(opd_id=active_opd_id) | Q(opd__isnull=True)
            )

        return queryset.order_by("nama")

    def _pelaksana_queryset(self, request):
        queryset = Pelaksana.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "nama",
            "nama__pangkat",
            "nama__tingkat",
            "nama__opd",
        ).order_by("-spt__tgl_berangkat", "-spt_id", "nama__nama")
        return filter_spj_queryset_for_user(
            queryset,
            request,
            "nama__nip",
        ).distinct()

    def _build_rows(self, request):
        start_date = _date_param(request, "tgl1")
        end_date = _date_param(request, "tgl2")
        keyword = (request.GET.get("search") or "").strip()
        pelaksana = self._pelaksana_queryset(request)

        if start_date:
            pelaksana = pelaksana.filter(spt__tgl_berangkat__gte=start_date)
        if end_date:
            pelaksana = pelaksana.filter(spt__tgl_berangkat__lte=end_date)
        if keyword:
            pelaksana = pelaksana.filter(
                Q(nama__nama__icontains=keyword) |
                Q(nama__nip__icontains=keyword) |
                Q(spt__tempat_tujuan__icontains=keyword) |
                Q(spt__kota_tujuan__lokasi__icontains=keyword) |
                Q(spt__pemberi_tugas__nomor_spt__icontains=keyword) |
                Q(spt__pemberi_tugas__nomor_spd__icontains=keyword)
            )

        rows_by_spt = {}
        for item in pelaksana:
            details, total = _build_kwitansi_items(item)
            spt = item.spt
            if spt.id not in rows_by_spt:
                rows_by_spt[spt.id] = {
                    "spt": spt,
                    "pemberi": PemberiTugas.objects.select_related(
                        "penandatangan",
                        "penandatangan__opd",
                    ).filter(spt=spt).first(),
                    "pelaksana": [],
                    "total": Decimal("0"),
                }
            rows_by_spt[spt.id]["pelaksana"].append({
                "item": item,
                "details": details,
                "total": total,
            })
            rows_by_spt[spt.id]["total"] += total

        return list(rows_by_spt.values()), start_date, end_date, keyword

    def get(self, request):
        rows, start_date, end_date, keyword = self._build_rows(request)
        grand_total = sum((row["total"] for row in rows), Decimal("0"))
        bendahara_options = self._bendahara_queryset(request)
        selected_bendahara_id = request.GET.get("bendahara") or ""
        return render(request, self.template_name, {
            "title": "Kwitansi",
            "rows": rows,
            "grand_total": grand_total,
            "start_date": start_date,
            "end_date": end_date,
            "keyword": keyword,
            "bendahara_options": bendahara_options,
            "selected_bendahara_id": selected_bendahara_id,
        })


class KwitansiPrintView(LoginRequiredMixin, View):
    template_name = "spj/kwitansi_print.html"

    def _get_bendahara(self, request, pemberi=None):
        bendahara_id = request.GET.get("bendahara")
        queryset = Penandatangan.objects.select_related(
            "opd",
            "pangkat",
            "tugas",
            "jenis_jabatan",
        ).filter(tugas__nama="Bendahara")

        active_opd_id = get_active_opd_id(request)
        if active_opd_id:
            queryset = queryset.filter(
                Q(opd_id=active_opd_id) | Q(opd__isnull=True)
            )

        if bendahara_id:
            selected = queryset.filter(pk=bendahara_id).first()
            if selected:
                return selected

        pemberi_opd_id = getattr(pemberi, "penandatangan_id", None) and getattr(
            pemberi.penandatangan,
            "opd_id",
            None,
        )
        if pemberi_opd_id:
            selected = queryset.filter(opd_id=pemberi_opd_id).first()
            if selected:
                return selected

        return queryset.first()

    def get_queryset(self, request):
        queryset = Pelaksana.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "nama",
            "nama__pangkat",
            "nama__tingkat",
            "nama__opd",
        )
        return filter_spj_queryset_for_user(
            queryset,
            request,
            "nama__nip",
        ).distinct()

    def get(self, request, pk):
        pelaksana = get_object_or_404(self.get_queryset(request), pk=pk)
        spt = pelaksana.spt
        pemberi = PemberiTugas.objects.select_related(
            "penandatangan",
            "penandatangan__opd",
        ).filter(spt=spt).first()
        details, total = _build_kwitansi_items(pelaksana)
        pemda = Pemda.objects.order_by("id").first()
        bendahara = self._get_bendahara(request, pemberi)
        tempat_tanggal = (
            getattr(pemda, "ibukota", None)
            or getattr(spt, "kota_tujuan_display", "")
            or ""
        )
        total_int = int(total)
        context = {
            "title": "Kwitansi",
            "spt": spt,
            "pemberi": pemberi,
            "pelaksana": pelaksana,
            "details": details,
            "total": total,
            "terbilang": f"{number_to_words(total_int)} rupiah",
            "tempat_tanggal": tempat_tanggal,
            "tanggal_cetak": timezone.localdate(),
            "bendahara": bendahara,
            "auto_print": request.GET.get("autoprint", "1") != "0",
            "empty_rows": range(max(0, 8 - len(details))),
        }
        response = render(request, self.template_name, context)
        response["X-Frame-Options"] = "SAMEORIGIN"
        response["Content-Security-Policy"] = (
            "default-src 'self'; "
            "script-src 'self' 'unsafe-inline'; "
            "style-src 'self' 'unsafe-inline'; "
            "img-src 'self' data: blob:; "
            "font-src 'self' data:; "
            "frame-ancestors 'self'; "
            "base-uri 'self'; "
            "form-action 'self'; "
            "object-src 'none'"
        )
        return response


class KwitansiPreviewView(LoginRequiredMixin, View):
    """
    Render modal preview iframe untuk Kwitansi — mengikuti pola
    PemberiTugasPreviewBaseView pada perintah/views.py.
    Dipanggil via HTMX hx-get, hasilnya dimasukkan ke #print-preview-modal-body.
    """

    template_name = "components/pdf/preview_modal.html"

    def get_queryset(self, request):
        queryset = Pelaksana.objects.select_related(
            "spt",
            "nama",
        )
        return filter_spj_queryset_for_user(queryset, request, "nama__nip").distinct()

    def get(self, request, pk):
        pelaksana = get_object_or_404(self.get_queryset(request), pk=pk)

        # Bangun URL print (dengan autoprint=0 agar tidak langsung cetak di iframe)
        bendahara_id = request.GET.get("bendahara", "")
        print_url = reverse("kwitansi_print", args=[pelaksana.pk]) + "?autoprint=0"
        if bendahara_id:
            print_url += f"&bendahara={bendahara_id}"

        frame_id = f"print-preview-frame-kwitansi-{pelaksana.pk}"
        nama_pelaksana = getattr(getattr(pelaksana, "nama", None), "nama", "") or ""

        context = {
            "title": "Preview Kwitansi",
            "document_code": "KWITANSI",
            "preview_description": (
                f"Tinjau Kwitansi {nama_pelaksana} terlebih dahulu sebelum dicetak."
                if nama_pelaksana
                else "Tinjau Kwitansi terlebih dahulu sebelum dicetak."
            ),
            "iframe_src": print_url,
            "open_url": print_url,
            "frame_id": frame_id,
            "print_button_label": "Cetak Kwitansi",
        }
        return render(request, self.template_name, context)


class LaporanPerjalananPrintView(LoginRequiredMixin, View):
    template_name = "spj/laporan_perjalanan_print.html"

    @staticmethod
    def _laporan_photos(laporan):
        photos = []
        for index in range(1, 5):
            image = getattr(laporan, f"foto_{index}", None)
            if image:
                is_portrait = False
                try:
                    with Image.open(image.path) as img:
                        transposed = ImageOps.exif_transpose(img)
                        target_img = transposed if transposed is not None else img
                        is_portrait = target_img.height > target_img.width
                except Exception:
                    pass
                photos.append({
                    "image": image,
                    "caption": f"Foto kegiatan {index}",
                    "is_portrait": is_portrait,
                })
        return photos

    def get_queryset(self, request):
        queryset = LaporanPerjalanan.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "pelaksana",
            "pelaksana__nama",
            "pelaksana__nama__opd",
        )
        return filter_spj_queryset_for_user(
            queryset,
            request,
            "pelaksana__nama__nip",
        ).distinct()

    def get(self, request, pk):
        laporan = get_object_or_404(self.get_queryset(request), pk=pk)
        pelaksana_list = laporan.spt.pelaksana.select_related(
            "nama",
            "nama__pangkat",
        ).all()
        pengguna_nip = get_pengguna_nip(request.user)
        if pengguna_nip:
            pelaksana_list = pelaksana_list.filter(nama__nip=pengguna_nip)
        elif not is_spj_admin_user(request.user):
            active_opd_id = get_active_opd_id(request)
            pelaksana_list = (
                pelaksana_list.filter(nama__opd_id=active_opd_id)
                if active_opd_id else pelaksana_list.none()
            )
        context = {
            "laporan": laporan,
            "spt": laporan.spt,
            "pelaksana_list": pelaksana_list,
            "laporan_photos": self._laporan_photos(laporan),
            "auto_print": request.GET.get("autoprint", "1") != "0",
        }
        response = render(request, self.template_name, context)
        response["X-Frame-Options"] = "SAMEORIGIN"
        response["Content-Security-Policy"] = (
            "default-src 'self'; "
            "script-src 'self' 'unsafe-inline'; "
            "style-src 'self' 'unsafe-inline'; "
            "img-src 'self' data: blob:; "
            "font-src 'self' data:; "
            "frame-ancestors 'self'; "
            "base-uri 'self'; "
            "form-action 'self'; "
            "object-src 'none'"
        )
        return response


class LaporanPerjalananPreviewView(LaporanPerjalananPrintView):
    template_name = "components/pdf/preview_modal.html"

    def get(self, request, pk):
        laporan = get_object_or_404(self.get_queryset(request), pk=pk)
        iframe_src = (
            reverse("laporan_perjalanan_print", args=[laporan.pk])
            + "?autoprint=0"
        )
        return render(request, self.template_name, {
            "title": "Preview Laporan Perjalanan",
            "document_code": "laporan",
            "preview_description": (
                "Tinjau Laporan Perjalanan terlebih dahulu sebelum dicetak."
            ),
            "iframe_src": iframe_src,
            "open_url": iframe_src,
            "frame_id": f"print-preview-frame-laporan-{laporan.pk}",
            "print_button_label": "Cetak Laporan",
        })
