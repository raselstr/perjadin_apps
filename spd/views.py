from django.shortcuts import render
from core.crud.base import BaseCRUDView
from core.views_excel import ExcelExportView, ExcelImportView
from .models import DasarPeraturan
from .forms import DasarPeraturanForm

from spd.tables import DasarPeraturanTable

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