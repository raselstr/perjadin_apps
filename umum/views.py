from django.shortcuts import render
from django.urls import reverse
from core.crud.base import BaseCRUDView
from core.views_excel import ExcelExportView, ExcelImportView
from .models import Pegawai, Penandatangan, Pangkat, JenisJabatan, StatusASN
from .forms import PegawaiForm, PenandatanganForm, PangkatForm, JenisJabatanForm, StatusASNForm
from .tables import PegawaiTable, PenandatanganTable, PangkatTable, JenisJabatanTable, StatusASNTable

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

    def get_queryset(self):
        return super().get_queryset().select_related(
            'pangkat',
            'jenis_jabatan',
            'status',
            'opd'
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
    
    def get_queryset(self):
        return super().get_queryset().select_related(
            'pangkat',
            'jenis_jabatan',
            'opd'
        )


# ===========================
# 📊 EXCEL EXPORT/IMPORT
# ===========================

class PegawaiExportView(ExcelExportView):
    """Download Pegawai data sebagai Excel"""
    model = Pegawai
    
    # Custom columns untuk export (sesuai dengan PegawaiTable)
    columns = [
        ('nip', 'NIP'),
        ('nama', 'Nama Pegawai'),
        ('pangkat', 'Pangkat'),
        ('jabatan', 'Jabatan'),
        ('jenis_jabatan', 'Jenis Jabatan'),
        ('status', 'Status ASN'),
        ('tgl_lahir', 'Tanggal Lahir'),
        ('opd', 'OPD'),
    ]
    
    def get_queryset(self):
        """Filter & select_related untuk performance"""
        return Pegawai.objects.all().select_related(
            'pangkat',
            'jenis_jabatan',
            'status',
            'opd'
        ).order_by('-id')


class PegawaiImportView(ExcelImportView):
    """Upload & import Pegawai data dari Excel"""
    model = Pegawai
    success_url = '/umum/pegawai/'
    
    # Column mapping untuk import
    columns = ['nip', 'nama', 'email', 'no_hp', 'jenis_jabatan', 'pangkat', 'status']


class PangkatExportView(ExcelExportView):
    """Download Pangkat data sebagai Excel"""
    model = Pangkat
    columns = [
        ('golongan', 'Golongan'),
        ('ruang', 'Ruang'),
        ('nama_pangkat', 'Nama Pangkat'),
    ]


class PangkatImportView(ExcelImportView):
    """Upload & import Pangkat data dari Excel"""
    model = Pangkat
    success_url = '/umum/pangkat/'
    columns = ['golongan', 'ruang', 'nama_pangkat']


class JenisJabatanExportView(ExcelExportView):
    """Download Jenis Jabatan data sebagai Excel"""
    model = JenisJabatan
    columns = [('nama', 'Nama Jenis Jabatan')]


class JenisJabatanImportView(ExcelImportView):
    """Upload & import Jenis Jabatan data dari Excel"""
    model = JenisJabatan
    success_url = '/umum/jenis-jabatan/'
    columns = ['nama']


class StatusASNExportView(ExcelExportView):
    """Download Status ASN data sebagai Excel"""
    model = StatusASN
    columns = [('nama', 'Nama Status ASN')]


class StatusASNImportView(ExcelImportView):
    """Upload & import Status ASN data dari Excel"""
    model = StatusASN
    success_url = '/umum/status-asn/'
    columns = ['nama']


class PenandatanganExportView(ExcelExportView):
    """Download Penandatangan data sebagai Excel"""
    model = Penandatangan
    columns = [
        ('nama', 'Nama'),
        ('nip', 'NIP'),
        ('jabatan', 'Jabatan'),
    ]


class PenandatanganImportView(ExcelImportView):
    """Upload & import Penandatangan data dari Excel"""
    model = Penandatangan
    success_url = '/umum/penandatangan/'
    columns = ['nama', 'nip', 'jabatan']