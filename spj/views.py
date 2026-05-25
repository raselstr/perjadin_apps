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


class SupervisorReportView(LoginRequiredMixin, View):
    template_name = "spj/laporan_pengawas.html"

    def _filter(self, queryset):
        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def get_filter_dates(self):
        """Extract filter dates from GET/POST parameters"""
        tgl_mulai = self.request.GET.get("tgl_mulai") or self.request.POST.get("tgl_mulai")
        tgl_akhir = self.request.GET.get("tgl_akhir") or self.request.POST.get("tgl_akhir")
        return tgl_mulai, tgl_akhir

    def get_filtered_spt(self):
        """Get SPT data with date filters"""
        from perintah.models import Spt
        
        queryset = Spt.objects.select_related(
            "kota_tujuan",
            "jenis_kegiatan",
        ).order_by("-tgl_berangkat", "-id")
        
        tgl_mulai, tgl_akhir = self.get_filter_dates()
        
        if tgl_mulai:
            queryset = queryset.filter(tgl_berangkat__gte=tgl_mulai)
        if tgl_akhir:
            queryset = queryset.filter(tgl_berangkat__lte=tgl_akhir)
        
        return queryset

    def get_data_for_row(self, spt, pelaksana):
        """Aggregate SPJ data for a specific SPT + Pelaksana combination"""
        result = {
            "pesawat_berangkat": [],
            "pesawat_kembali": [],
            "hotel": [],
            "transport_berangkat": [],
            "transport_kembali": [],
            "uang_harian": None,
            "uang_representasi": None,
            "total_biaya": Decimal("0"),
        }
        
        # Pesawat Berangkat
        pesawat_berangkat = Pesawat.objects.filter(
            spt=spt,
            pelaksana=pelaksana,
            jenis_spj__jenis_spj="Berangkat"
        ).select_related("lokasi_bandara", "tujuan_bandara", "jenis_spj")
        result["pesawat_berangkat"] = list(pesawat_berangkat)
        result["total_biaya"] += sum(p.total_biaya for p in pesawat_berangkat)
        
        # Pesawat Kembali
        pesawat_kembali = Pesawat.objects.filter(
            spt=spt,
            pelaksana=pelaksana,
            jenis_spj__jenis_spj="Kembali"
        ).select_related("lokasi_bandara", "tujuan_bandara", "jenis_spj")
        result["pesawat_kembali"] = list(pesawat_kembali)
        result["total_biaya"] += sum(p.total_biaya for p in pesawat_kembali)
        
        # Hotel
        hotel = Penginapan.objects.filter(
            spt=spt,
            pelaksana=pelaksana
        )
        result["hotel"] = list(hotel)
        result["total_biaya"] += sum(h.total_biaya for h in hotel)
        
        # Transport Berangkat
        transport_berangkat = Transport.objects.filter(
            spt=spt,
            pelaksana=pelaksana,
            jenis_spj__jenis_spj="Berangkat"
        ).select_related(
            "jenis_transportasi",
            "lokasi_berangkat",
            "tujuan",
            "jenis_spj"
        )
        result["transport_berangkat"] = list(transport_berangkat)
        result["total_biaya"] += sum(t.total_biaya for t in transport_berangkat)
        
        # Transport Kembali
        transport_kembali = Transport.objects.filter(
            spt=spt,
            pelaksana=pelaksana,
            jenis_spj__jenis_spj="Kembali"
        ).select_related(
            "jenis_transportasi",
            "lokasi_berangkat",
            "tujuan",
            "jenis_spj"
        )
        result["transport_kembali"] = list(transport_kembali)
        result["total_biaya"] += sum(t.total_biaya for t in transport_kembali)
        
        # Uang Harian
        uang_harian = UangHarian.objects.filter(
            spt=spt,
            pelaksana=pelaksana
        ).first()
        if uang_harian:
            result["uang_harian"] = uang_harian
            result["total_biaya"] += uang_harian.total_biaya
        
        # Uang Representasi
        uang_representasi = UangRepresentasi.objects.filter(
            spt=spt,
            pelaksana=pelaksana
        ).first()
        if uang_representasi:
            result["uang_representasi"] = uang_representasi
            result["total_biaya"] += uang_representasi.total_biaya
        
        return result

    def get(self, request):
        from perintah.models import Spt
        
        spt_list = self.get_filtered_spt()
        
        data = []
        grand_total = Decimal("0")
        
        for spt in spt_list:
            # Get pelaksana directly from database
            from perintah.models import Pelaksana
            
            pelaksana_qs = Pelaksana.objects.filter(spt=spt).select_related(
                "nama",
                "nama__opd",
                "nama__tingkat",
                "nama__pangkat",
            ).order_by("nama__nama")
            
            # Filter by permission - check if user can see this OPD
            for pelaksana in pelaksana_qs:
                # Create a mock request-like object for filtering check
                if self._can_access_pelaksana(pelaksana):
                    row_data = self.get_data_for_row(spt, pelaksana)
                    row_data["spt"] = spt
                    row_data["pelaksana"] = pelaksana
                    data.append(row_data)
                    grand_total += row_data["total_biaya"]
        
        tgl_mulai, tgl_akhir = self.get_filter_dates()
        
        return render(request, self.template_name, {
            "title": "Laporan Pengawas",
            "data": data,
            "grand_total": grand_total,
            "tgl_mulai": tgl_mulai,
            "tgl_akhir": tgl_akhir,
        })

    def _can_access_pelaksana(self, pelaksana):
        """Check if current user can access this pelaksana"""
        from .access import is_spj_admin_user, is_spj_pengguna_user
        
        user = self.request.user
        
        if is_spj_admin_user(user):
            return True
        
        if is_spj_pengguna_user(user):
            return user.username == pelaksana.nama.nip
        
        # Check by OPD
        user_opd_ids = self.request.session.get("active_opd", [])
        if pelaksana.nama.opd_id in user_opd_ids:
            return True
        
        return False

    def post(self, request):
        """Handle POST request with same logic as GET"""
        return self.get(request)
