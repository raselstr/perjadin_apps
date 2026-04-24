from django.shortcuts import render
from core.crud.base import BaseCRUDView
from core.views_excel import ExcelExportView, ExcelImportView
from .models import DasarPeraturan, JenisSPD, JenisKegiatan, JenisTransportasi, Lokasi, StandardPenginapan, StandardPesawat, StandardRepresentasi, StandardTransportasi, StandardUangHarian
from .forms import DasarPeraturanForm, JenisSPDForm, JenisKegiatanForm, JenisTransportasiForm, LokasiForm, StandardPenginapanForm, StandardPesawatForm, StandardRepresentasiForm, StandardTransportasiForm, StandardUangHarianForm
from .tables import DasarPeraturanTable, JenisSPDTable, JenisKegiatanTable, JenisTransportasiTable, LokasiTable, StandardPenginapanTable, StandardPesawatTable, StandardRepresentasiTable, StandardTransportasiTable, StandardUangHarianTable

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
        return super().get_queryset().select_related('jenis_spd').order_by('jenis_spd_id', 'lokasi')

class LokasiExportView(ExcelExportView):
    """Download Lokasi data sebagai Excel"""
    model = Lokasi

class LokasiImportView(ExcelImportView):
    """Upload & import Lokasi data dari Excel"""
    model = Lokasi
    success_url = '/spd/lokasi-kegiatan/'
    
    # Column mapping untuk import
    columns = ('lokasi', 'kota', 'jenis_spd')

class StandardPenginapanView(BaseCRUDView):
    model = StandardPenginapan
    form_class = StandardPenginapanForm
    table_class = StandardPenginapanTable

    title = "Daftar Standard Penginapan"
    url_list = "standard_penginapan_list"
    url_action = "standard_penginapan_action"
    url_action_pk = "standard_penginapan_action_pk"
    url_export = "standard_penginapan_export"
    url_import = "standard_penginapan_import"

    def get_queryset(self):
        return super().get_queryset().select_related('lokasi', 'tingkat').order_by('lokasi__lokasi', 'tingkat__tingkat')   

class StandardPenginapanExportView(ExcelExportView):
    """Download Standard Penginapan data sebagai Excel"""
    model = StandardPenginapan

class StandardPenginapanImportView(ExcelImportView):
    """Upload & import Standard Penginapan data dari Excel"""
    model = StandardPenginapan
    success_url = '/spd/standard-penginapan/'
    
    # Column mapping untuk import
    columns = ('dasar_peraturan', 'lokasi', 'tingkat', 'satuan', 'biaya')

class StandardPesawatView(BaseCRUDView):
    model = StandardPesawat
    form_class = StandardPesawatForm
    table_class = StandardPesawatTable

    title = "Daftar Standard Pesawat"
    url_list = "standard_pesawat_list"
    url_action = "standard_pesawat_action"
    url_action_pk = "standard_pesawat_action_pk"
    url_export = "standard_pesawat_export"
    url_import = "standard_pesawat_import"

    def get_queryset(self):
        return super().get_queryset().select_related('kota_asal', 'kota_tujuan', 'tingkat').order_by('kota_asal__lokasi', 'kota_tujuan__lokasi', 'tingkat__tingkat')

class StandardPesawatExportView(ExcelExportView):
    """Download Standard Pesawat data sebagai Excel"""
    model = StandardPesawat

class StandardPesawatImportView(ExcelImportView):
    """Upload & import Standard Pesawat data dari Excel"""
    model = StandardPesawat
    success_url = '/spd/standard-pesawat/'
    
    # Column mapping untuk import
    columns = ('dasar_peraturan', 'kota_asal', 'kota_tujuan', 'tingkat', 'biaya')

class StandardUangHarianView(BaseCRUDView):
    model = StandardUangHarian
    form_class = StandardUangHarianForm
    table_class = StandardUangHarianTable

    title = "Daftar Standard Uang Harian"
    url_list = "standard_uang_harian_list"
    url_action = "standard_uang_harian_action"
    url_action_pk = "standard_uang_harian_action_pk"
    url_export = "standard_uang_harian_export"
    url_import = "standard_uang_harian_import"

    def get_queryset(self):
        return super().get_queryset().select_related('jenis_kegiatan').order_by('jenis_kegiatan__nama')

class StandardUangHarianExportView(ExcelExportView):
    """Download Standard Uang Harian data sebagai Excel"""
    model = StandardUangHarian

class StandardUangHarianImportView(ExcelImportView):
    """Upload & import Standard Uang Harian data dari Excel"""
    model = StandardUangHarian
    success_url = '/spd/standard-uang-harian/'
    
    # Column mapping untuk import
    columns = ('dasar_peraturan', 'jenis_kegiatan', 'lokasi', 'satuan', 'biaya')

class JenisTransportasiView(BaseCRUDView):
    model = JenisTransportasi
    form_class = JenisTransportasiForm
    table_class = JenisTransportasiTable

    title = "Daftar Jenis Transportasi"
    url_list = "jenis_transportasi_list"
    url_action = "jenis_transportasi_action"
    url_action_pk = "jenis_transportasi_action_pk"
    url_export = "jenis_transportasi_export"
    url_import = "jenis_transportasi_import"

    def get_queryset(self):
        return super().get_queryset().order_by('nama')

class JenisTransportasiExportView(ExcelExportView):
    """Download Jenis Transportasi data sebagai Excel"""
    model = JenisTransportasi

class JenisTransportasiImportView(ExcelImportView):
    """Upload & import Jenis Transportasi data dari Excel"""
    model = JenisTransportasi
    success_url = '/spd/jenis-transportasi/'
    
    # Column mapping untuk import
    columns = ('nama',)

class StandardTransportasiView(BaseCRUDView):
    model = StandardTransportasi
    form_class = StandardTransportasiForm
    table_class = StandardTransportasiTable

    title = "Daftar Standard Transportasi"
    url_list = "standard_transportasi_list"
    url_action = "standard_transportasi_action"
    url_action_pk = "standard_transportasi_action_pk"
    url_export = "standard_transportasi_export"
    url_import = "standard_transportasi_import"

    def get_queryset(self):
        return super().get_queryset().select_related('jenis_transportasi','kota_tujuan').order_by('jenis_transportasi__nama')

class StandardTransportasiExportView(ExcelExportView):
    """Download Standard Transportasi data sebagai Excel"""
    model = StandardTransportasi

class StandardTransportasiImportView(ExcelImportView):
    """Upload & import Standard Transportasi data dari Excel"""
    model = StandardTransportasi
    success_url = '/spd/standard-transportasi/'
    
    # Column mapping untuk import
    columns = ('dasar_peraturan','jenis_transportasi', 'kota_tujuan', 'satuan', 'biaya')

class StandardRepresentasiView(BaseCRUDView):
    model = StandardRepresentasi
    form_class = StandardRepresentasiForm
    table_class = StandardRepresentasiTable

    title = "Daftar Standard Representasi"
    url_list = "standard_representasi_list"
    url_action = "standard_representasi_action"
    url_action_pk = "standard_representasi_action_pk"
    url_export = "standard_representasi_export"
    url_import = "standard_representasi_import"

    def get_queryset(self):
        return super().get_queryset().select_related('dasar_peraturan', 'jenis_jabatan', 'jenis_spd').order_by('jenis_jabatan__nama', 'jenis_spd__nama')

class StandardRepresentasiExportView(ExcelExportView):
    """Download Standard Representasi data sebagai Excel"""
    model = StandardRepresentasi

class StandardRepresentasiImportView(ExcelImportView):
    """Upload & import Standard Representasi data dari Excel"""
    model = StandardRepresentasi
    success_url = '/spd/standard-representasi/'
    
    # Column mapping untuk import
    columns = ('dasar_peraturan', 'jenis_jabatan', 'jenis_spds', 'biaya')
