from decimal import Decimal

from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render
from django.views import View

from core.crud.base import BaseCRUDView

from .access import filter_spj_queryset_for_user
from .forms import (
    JenisSPJForm,
    PenginapanForm,
    PesawatForm,
    TransportForm,
    UangHarianForm,
    UangRepresentasiForm,
)
from .models import (
    JenisSPJ,
    Penginapan,
    Pesawat,
    Transport,
    UangHarian,
    UangRepresentasi,
)
from .tables import (
    JenisSPJTable,
    PenginapanTable,
    PesawatTable,
    TransportTable,
    UangHarianTable,
    UangRepresentasiTable,
)


class SPJQuerysetMixin:
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


class JenisSPJView(BaseCRUDView):
    model = JenisSPJ
    form_class = JenisSPJForm
    table_class = JenisSPJTable
    enable_excel = False

    title = "Jenis SPJ"
    url_list = "jenis_spj_list"
    url_action = "jenis_spj_action"
    url_action_pk = "jenis_spj_action_pk"


class PenginapanView(SPJQuerysetMixin, BaseCRUDView):
    model = Penginapan
    form_class = PenginapanForm
    table_class = PenginapanTable
    enable_excel = False

    title = "SPJ Penginapan"
    url_list = "penginapan_list"
    url_action = "penginapan_action"
    url_action_pk = "penginapan_action_pk"


class PesawatView(SPJQuerysetMixin, BaseCRUDView):
    model = Pesawat
    form_class = PesawatForm
    table_class = PesawatTable
    enable_excel = False

    title = "SPJ Pesawat"
    url_list = "pesawat_list"
    url_action = "pesawat_action"
    url_action_pk = "pesawat_action_pk"

    def get_base_queryset(self):
        return super().get_base_queryset().select_related(
            "jenis_spj",
            "lokasi_bandara",
            "tujuan_bandara",
        )


class UangHarianView(SPJQuerysetMixin, BaseCRUDView):
    model = UangHarian
    form_class = UangHarianForm
    table_class = UangHarianTable
    enable_excel = False

    title = "SPJ Uang Harian"
    url_list = "uang_harian_list"
    url_action = "uang_harian_action"
    url_action_pk = "uang_harian_action_pk"


class TransportView(SPJQuerysetMixin, BaseCRUDView):
    model = Transport
    form_class = TransportForm
    table_class = TransportTable
    enable_excel = False

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
    enable_excel = False

    title = "SPJ Uang Representasi"
    url_list = "uang_representasi_list"
    url_action = "uang_representasi_action"
    url_action_pk = "uang_representasi_action_pk"


class SPJReportView(LoginRequiredMixin, View):
    template_name = "spj/report.html"

    def _filter(self, queryset):
        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def get(self, request):
        base_select = (
            "spt",
            "spt__kota_tujuan",
            "pelaksana",
            "pelaksana__nama",
            "pelaksana__nama__opd",
        )
        penginapan = self._filter(
            Penginapan.objects.select_related(*base_select)
        )
        pesawat = self._filter(
            Pesawat.objects.select_related(*base_select, "jenis_spj")
        )
        uang_harian = self._filter(
            UangHarian.objects.select_related(*base_select)
        )
        transport = self._filter(
            Transport.objects.select_related(
                *base_select,
                "jenis_spj",
                "jenis_transportasi",
            )
        )
        uang_representasi = self._filter(
            UangRepresentasi.objects.select_related(*base_select)
        )

        summary = {}

        def get_row(item):
            key = (item.spt_id, item.pelaksana_id)
            if key not in summary:
                summary[key] = {
                    "spt": item.spt,
                    "pelaksana": item.pelaksana,
                    "penginapan": Decimal("0"),
                    "pesawat": Decimal("0"),
                    "uang_harian": Decimal("0"),
                    "transport": Decimal("0"),
                    "representasi": Decimal("0"),
                    "total": Decimal("0"),
                }
            return summary[key]

        for item in penginapan:
            row = get_row(item)
            row["penginapan"] += item.total_biaya
            row["total"] += item.total_biaya

        for item in pesawat:
            row = get_row(item)
            row["pesawat"] += item.total_biaya
            row["total"] += item.total_biaya

        for item in uang_harian:
            row = get_row(item)
            row["uang_harian"] += item.total_biaya
            row["total"] += item.total_biaya

        for item in transport:
            row = get_row(item)
            row["transport"] += item.total_biaya
            row["total"] += item.total_biaya

        for item in uang_representasi:
            row = get_row(item)
            row["representasi"] += item.total_biaya
            row["total"] += item.total_biaya

        rows = sorted(
            summary.values(),
            key=lambda row: (row["spt"].id, row["pelaksana"].nama.nama),
        )
        grand_total = sum((row["total"] for row in rows), Decimal("0"))

        return render(request, self.template_name, {
            "title": "Laporan SPJ",
            "rows": rows,
            "grand_total": grand_total,
        })
