from django.shortcuts import render
from django.urls import reverse
from core.crud.base import BaseCRUDView
from .models import Pegawai
from .forms import PegawaiForm
from .tables import PegawaiTable

def umum_view(request):
    context = {
        "title": "Dashboard",
        "total_pegawai": Pegawai.objects.count()
    }
    if request.headers.get("HX-Request"):
        return render(request, "components/crud/list.html", context)
    return render(request, "pages/page.html", context)


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
        return Pegawai.objects.select_related(
            'pangkat',
            'jenis_jabatan',
            'status',
            'opd'
        )