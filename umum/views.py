from django.shortcuts import render
from django.urls import reverse
from core.crud.base import BaseCRUDView
from .models import Pegawai, Penandatangan
from .forms import PegawaiForm, PenandatanganForm
from .tables import PegawaiTable, PenandatanganTable

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

class PegawaiView(BaseCRUDView):
    model = Pegawai
    form_class = PegawaiForm
    table_class = PegawaiTable

    title = "Daftar Pegawai"

    # URL NAME (WAJIB SESUAI urls.py)
    url_list = "pegawai_list"
    url_action = "pegawai_action"
    url_action_pk = "pegawai_action_pk"

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
    
    def get_queryset(self):
        return super().get_queryset().select_related(
            'pangkat',
            'jenis_jabatan',
            'opd'
        )