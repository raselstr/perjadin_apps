from core.crud.base import BaseMasterDetailCRUDView
from .models import Spt
from .forms import SptForm, PelaksanaFormSet
from .tables import SptTable


class SptView(BaseMasterDetailCRUDView):
    model = Spt
    form_class = SptForm
    formset_class = PelaksanaFormSet
    table_class = SptTable

    title = "Daftar SPT"

    url_list = "spt_list"
    url_action = "spt_action"
    url_action_pk = "spt_action_pk"
    url_export = "spt_export"
    url_import = "spt_import"

    def get_queryset(self):
        return (
            super()
            .get_queryset()
            .select_related(
                "kota_tujuan",
                "jenis_kegiatan",
            )
            .prefetch_related(
                "pelaksana__nama"
            )
            .order_by("-tanggal_spt", "-id")
        )