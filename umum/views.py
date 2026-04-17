from django.shortcuts import render
from django.urls import reverse
from core.crud.base import BaseCRUDView
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