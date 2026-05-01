from django.shortcuts import render
from core.crud.base import BaseCRUDView
from core.views_excel import ExcelExportView, ExcelImportView
from profiles.utils import (
    filter_penandatangan_queryset,
    filter_queryset_by_active_opd,
)
from .models import Eselon, KopSurat, Pegawai, Pemda, Penandatangan, Pangkat, JenisJabatan, StatusASN, Tingkat
from .forms import EselonForm, KopSuratForm, PegawaiForm, PemdaForm, PenandatanganForm, PangkatForm, JenisJabatanForm, StatusASNForm, TingkatForm
from .tables import EselonTable, KopSuratTable, PegawaiTable, PemdaTable, PenandatanganTable, PangkatTable, JenisJabatanTable, StatusASNTable, TingkatTable

def umum_view(request):
    context = {
        "title": "Dashboard",
    }
    if request.headers.get("HX-Request"):
        return render(request, "components/crud/list.html", context)
    return render(request, "pages/page.html", context)

def get_paginate_by(self, queryset):
    per_page = self.request.GET.get("per_page")

    if per_page == "all":
        return None  # disable pagination

    try:
        return int(per_page)
    except (TypeError, ValueError):
        return 10

class PangkatView(BaseCRUDView):
    model = Pangkat
    form_class = PangkatForm
    table_class = PangkatTable

    title = "Daftar Pangkat"
    url_list = "pangkat_list"
    url_action = "pangkat_action"
    url_action_pk = "pangkat_action_pk"
    url_export = "pangkat_export"
    url_import = "pangkat_import"

    def get_queryset(self):
        return super().get_queryset().order_by('golongan', 'ruang')


class JenisJabatanView(BaseCRUDView):
    model = JenisJabatan
    form_class = JenisJabatanForm
    table_class = JenisJabatanTable

    title = "Daftar Jenis Jabatan"
    url_list = "jenis_jabatan_list"
    url_action = "jenis_jabatan_action"
    url_action_pk = "jenis_jabatan_action_pk"
    url_export = "jenis_jabatan_export"
    url_import = "jenis_jabatan_import"

    def get_queryset(self):
        return super().get_queryset().order_by('nama')


class StatusASNView(BaseCRUDView):
    model = StatusASN
    form_class = StatusASNForm
    table_class = StatusASNTable

    title = "Daftar Status ASN"
    url_list = "status_asn_list"
    url_action = "status_asn_action"
    url_action_pk = "status_asn_action_pk"
    url_export = "status_asn_export"
    url_import = "status_asn_import"

    def get_queryset(self):
        return super().get_queryset().order_by('nama')


class PegawaiView(BaseCRUDView):
    model = Pegawai
    form_class = PegawaiForm
    table_class = PegawaiTable

    title = "Daftar Pegawai"

    # URL NAME (WAJIB SESUAI urls.py)
    url_list = "pegawai_list"
    url_action = "pegawai_action"
    url_action_pk = "pegawai_action_pk"
    url_import = "pegawai_import"
    url_export = "pegawai_export"

    def get_base_queryset(self):
        queryset = Pegawai.objects.select_related(
            'pangkat',
            'eselon',
            'jenis_jabatan',
            'status',
            'opd',
            'tingkat',
        )
        return filter_queryset_by_active_opd(
            queryset,
            self.request,
            "opd_id",
        )


class PenandatanganView(BaseCRUDView):
    model = Penandatangan
    form_class = PenandatanganForm
    table_class = PenandatanganTable

    title = "Daftar Penandatangan"

    # URL NAME (WAJIB SESUAI urls.py)
    url_list = "penandatangan_list"
    url_action = "penandatangan_action"
    url_action_pk = "penandatangan_action_pk"
    url_import = "penandatangan_import"
    url_export = "penandatangan_export"
    
    def get_base_queryset(self):
        queryset = Penandatangan.objects.select_related(
            'pangkat',
            'jenis_jabatan',
            'opd'
        )
        return filter_penandatangan_queryset(
            queryset,
            self.request,
        )

class TingkatView(BaseCRUDView):
    model = Tingkat
    form_class = TingkatForm
    table_class = TingkatTable

    title = "Daftar Tingkat"
    url_list = "tingkat_list"
    url_action = "tingkat_action"
    url_action_pk = "tingkat_action_pk"
    url_export = "tingkat_export"
    url_import = "tingkat_import"

    def get_queryset(self):
        return super().get_queryset().order_by('id')


class PemdaView(BaseCRUDView):
    model = Pemda
    form_class = PemdaForm
    table_class = PemdaTable
    enable_excel = False

    title = "Daftar Pemda"
    url_list = "pemda_list"
    url_action = "pemda_action"
    url_action_pk = "pemda_action_pk"

    def get_base_queryset(self):
        queryset = Pemda.objects.select_related(
            "nama_dinas"
        ).order_by('nama_pemda')
        return filter_queryset_by_active_opd(
            queryset,
            self.request,
            "nama_dinas_id",
        )


class KopSuratView(BaseCRUDView):
    model = KopSurat
    form_class = KopSuratForm
    table_class = KopSuratTable
    enable_excel = False

    title = "Daftar Kop Surat"
    url_list = "kop_surat_list"
    url_action = "kop_surat_action"
    url_action_pk = "kop_surat_action_pk"

    def get_base_queryset(self):
        queryset = KopSurat.objects.select_related(
            "pemda",
            "pemda__nama_dinas",
        ).order_by("pemda__nama_pemda")
        return filter_queryset_by_active_opd(
            queryset,
            self.request,
            "pemda__nama_dinas_id",
        )

# ===========================
# 📊 EXCEL EXPORT/IMPORT
# ===========================

class PegawaiExportView(ExcelExportView):
    """Download Pegawai data sebagai Excel"""
    model = Pegawai
    
    def get_queryset(self):
        """Filter & select_related untuk performance"""
        queryset = Pegawai.objects.all().select_related(
            'pangkat',
            'eselon',
            'jenis_jabatan',
            'status',
            'opd',
            'tingkat',
        ).order_by('-id')
        return filter_queryset_by_active_opd(
            queryset,
            self.request,
            "opd_id",
        )


class PegawaiImportView(ExcelImportView):
    """Upload & import Pegawai data dari Excel"""
    model = Pegawai
    success_url = '/umum/pegawai/'
    
    # Column mapping untuk import
    columns = ['nip', 'nama', 'pangkat',  'jabatan', 'eselon','jenis_jabatan', 'status', 'tgl_lahir', 'opd', 'tingkat']
    match_fields = [('nip',)]

class PangkatExportView(ExcelExportView):
    """Download Pangkat data sebagai Excel"""
    model = Pangkat

class PangkatImportView(ExcelImportView):
    """Upload & import Pangkat data dari Excel"""
    model = Pangkat
    success_url = '/umum/pangkat/'
    columns = ['pangkat','golongan', 'ruang']
    match_fields = [('pangkat', 'golongan', 'ruang')]

class JenisJabatanExportView(ExcelExportView):
    """Download Jenis Jabatan data sebagai Excel"""
    model = JenisJabatan

class JenisJabatanImportView(ExcelImportView):
    """Upload & import Jenis Jabatan data dari Excel"""
    model = JenisJabatan
    success_url = '/umum/jenis-jabatan/'
    columns = ['nama', 'keterangan', 'fungsi']

class EselonView(BaseCRUDView):
    model = Eselon
    form_class = EselonForm
    table_class = EselonTable

    title = "Daftar Eselon"
    url_list = "eselon_list"
    url_action = "eselon_action"
    url_action_pk = "eselon_action_pk"
    url_export = "eselon_export"
    url_import = "eselon_import"


class EselonExportView(ExcelExportView):
    """Download Eselon data sebagai Excel"""
    model = Eselon  

class EselonImportView(ExcelImportView):
    """Upload & import Eselon data dari Excel"""
    model = Eselon
    success_url = '/umum/eselon/'
    columns = ['eselon', 'keterangan']
    match_fields = [('eselon','keterangan')] 

class StatusASNExportView(ExcelExportView):
    """Download Status ASN data sebagai Excel"""
    model = StatusASN

class StatusASNImportView(ExcelImportView):
    """Upload & import Status ASN data dari Excel"""
    model = StatusASN
    success_url = '/umum/status-asn/'
    columns = ['nama']


class PenandatanganExportView(ExcelExportView):
    """Download Penandatangan data sebagai Excel"""
    model = Penandatangan

    def get_queryset(self):
        queryset = Penandatangan.objects.select_related(
            "pangkat",
            "jenis_jabatan",
            "opd",
        ).order_by("-id")
        return filter_penandatangan_queryset(
            queryset,
            self.request,
        )

class PenandatanganImportView(ExcelImportView):
    """Upload & import Penandatangan data dari Excel"""
    model = Penandatangan
    success_url = '/umum/penandatangan/'
    columns = ['nama', 'nip', 'pangkat','tugas', 'jenis_jabatan', 'opd']
    match_fields = [('nip', 'nama', 'tugas', 'jenis_jabatan', 'opd')]

class TingkatExportView(ExcelExportView):
    """Download Tingkat data sebagai Excel"""
    model = Tingkat

class TingkatImportView(ExcelImportView):
    """Upload & import Tingkat data dari Excel"""
    model = Tingkat
    success_url = '/umum/tingkat/'
    columns = ['tingkat','ket','pesawat','kapal','keteraapian','lainnya']
