from django.shortcuts import render
from core.crud.base import BaseCRUDView
from core.views_excel import ExcelExportView, ExcelImportView
from .models import DasarPeraturan, JenisSPD, JenisKegiatan, Lokasi
from .forms import DasarPeraturanForm, JenisSPDForm, JenisKegiatanForm, LokasiForm
from .tables import DasarPeraturanTable, JenisSPDTable, JenisKegiatanTable, LokasiTable

def get_paginate_by(self, queryset):
    per_page = self.request.GET.get("per_page")

    if per_page == "all":
        return None  # disable pagination

    try:
        return int(per_page)
    except (TypeError, ValueError):
        return 10

class DasarPeraturanView(BaseCRUDView):
    model = DasarPeraturan
    form_class = DasarPeraturanForm
    table_class = DasarPeraturanTable

    title = "Daftar Dasar Peraturan"
    url_list = "dasar_peraturan_list"
    url_action = "dasar_peraturan_action"
    url_action_pk = "dasar_peraturan_action_pk"
    url_export = "dasar_peraturan_export"
    url_import = "dasar_peraturan_import"

    def get_queryset(self):
        return super().get_queryset().order_by('-tanggal_peraturan', 'nomor_peraturan')

class DasarPeraturanExportView(ExcelExportView):
    """Download Dasar Peraturan data sebagai Excel"""
    model = DasarPeraturan

class DasarPeraturanImportView(ExcelImportView):
    """Upload & import Dasar Peraturan data dari Excel"""
    model = DasarPeraturan
    success_url = '/spd/dasar-peraturan/'
    
    # Column mapping untuk import
    columns = ('nama_peraturan', 'nomor_peraturan', 'tanggal_peraturan', 'keterangan')

class JenisSPDView(BaseCRUDView):
    model = JenisSPD
    form_class = JenisSPDForm
    table_class = JenisSPDTable

    title = "Daftar Jenis SPD"
    url_list = "jenis_spd_list"
    url_action = "jenis_spd_action"
    url_action_pk = "jenis_spd_action_pk"
    url_export = "jenis_spd_export"
    url_import = "jenis_spd_import"

    def get_queryset(self):
        return super().get_queryset().order_by('nama')

class JenisSPDExportView(ExcelExportView):
    """Download Jenis SPD data sebagai Excel"""
    model = JenisSPD

class JenisSPDImportView(ExcelImportView):
    """Upload & import Jenis SPD data dari Excel"""
    model = JenisSPD
    success_url = '/spd/jenis-spd/'
    
    # Column mapping untuk import
    columns = ('nama',)


class JenisKegiatanView(BaseCRUDView):
    model = JenisKegiatan
    form_class = JenisKegiatanForm
    table_class = JenisKegiatanTable

    title = "Daftar Jenis Kegiatan"
    url_list = "jenis_kegiatan_list"
    url_action = "jenis_kegiatan_action"
    url_action_pk = "jenis_kegiatan_action_pk"
    url_export = "jenis_kegiatan_export"
    url_import = "jenis_kegiatan_import"

    def get_queryset(self):
        return super().get_queryset().order_by('nama')

class JenisKegiatanExportView(ExcelExportView):
    """Download Jenis Kegiatan data sebagai Excel"""
    model = JenisKegiatan

class JenisKegiatanImportView(ExcelImportView):
    """Upload & import Jenis Kegiatan data dari Excel"""
    model = JenisKegiatan
    success_url = '/spd/jenis-kegiatan/'
    
    # Column mapping untuk import
    columns = ('nama',)

class LokasiView(BaseCRUDView):
    model = Lokasi
    form_class = LokasiForm
    table_class = LokasiTable

    title = "Daftar Lokasi"
    url_list = "lokasi_kegiatan_list"
    url_action = "lokasi_kegiatan_action"
    url_action_pk = "lokasi_kegiatan_action_pk"
    url_export = "lokasi_kegiatan_export"
    url_import = "lokasi_kegiatan_import"

    def get_queryset(self):
        return super().get_queryset().select_related('jenis_spd').order_by('lokasi')

class LokasiExportView(ExcelExportView):
    """Download Lokasi data sebagai Excel"""
    model = Lokasi

class LokasiImportView(ExcelImportView):
    """Upload & import Lokasi data dari Excel"""
    model = Lokasi
    success_url = '/spd/lokasi-kegiatan/'
    
    # Column mapping untuk import
    columns = ('lokasi', 'jenis_spd')
