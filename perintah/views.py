from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied
from django.db.models import Prefetch
from django.shortcuts import get_object_or_404, render
from django.views import View

from core.crud.base import BaseCRUDView, BaseMasterDetailCRUDView
from menus.models import RolePermission, SubMenu
from profiles.models import UserProfile
from umum.models import Pemda

from .forms import PelaksanaFormSet, PemberiTugasForm, SptForm
from .models import Pelaksana, PemberiTugas, Spt
from .tables import PemberiTugasTable, SptTable


class PerintahPermissionMixin(LoginRequiredMixin):
    permission_url_name = "pemberi_tugas_list"

    def has_view_permission(self):
        user = self.request.user

        if not user.is_authenticated:
            return False

        if user.is_superuser:
            return True

        try:
            profile = UserProfile.objects.select_related("role").get(user=user)
            submenu = SubMenu.objects.get(url=self.permission_url_name)
        except (UserProfile.DoesNotExist, SubMenu.DoesNotExist):
            return False

        return RolePermission.objects.filter(
            role=profile.role,
            submenu=submenu,
            can_view=True,
        ).exists()

    def dispatch(self, request, *args, **kwargs):
        self.request = request

        if not self.has_view_permission():
            raise PermissionDenied(
                "Anda tidak memiliki izin untuk melihat dokumen ini."
            )

        return super().dispatch(request, *args, **kwargs)


class SptView(BaseMasterDetailCRUDView):
    model = Spt
    form_class = SptForm
    formset_class = PelaksanaFormSet
    table_class = SptTable
    enable_excel = False

    title = "Daftar SPT"

    url_list = "spt_list"
    url_action = "spt_action"
    url_action_pk = "spt_action_pk"
    url_export = None
    url_import = None

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
            .order_by("-id")
        )


class PemberiTugasView(BaseCRUDView):
    model = PemberiTugas
    form_class = PemberiTugasForm
    table_class = PemberiTugasTable
    enable_excel = False

    title = "Daftar Pemberi Tugas"

    url_list = "pemberi_tugas_list"
    url_action = "pemberi_tugas_action"
    url_action_pk = "pemberi_tugas_action_pk"

    def get_queryset(self):
        return (
            super()
            .get_queryset()
            .select_related(
                "spt",
                "spt__kota_tujuan",
                "penandatangan",
                "penandatangan__jenis_jabatan",
                "penandatangan__opd",
            )
            .order_by("-tanggal_spt", "-id")
        )


class PemberiTugasPrintBaseView(PerintahPermissionMixin, View):
    template_name = ""

    def get_object(self, pk):
        return get_object_or_404(
            PemberiTugas.objects.select_related(
                "spt",
                "spt__kota_tujuan",
                "spt__jenis_kegiatan",
                "penandatangan",
                "penandatangan__pangkat",
                "penandatangan__jenis_jabatan",
                "penandatangan__opd",
            ).prefetch_related(
                Prefetch(
                    "spt__pelaksana",
                    queryset=Pelaksana.objects.select_related(
                        "nama",
                        "nama__pangkat",
                        "nama__tingkat",
                        "nama__opd",
                    ).order_by("id"),
                )
            ),
            pk=pk,
        )

    def get_context_data(self, pemberi_tugas):
        spt = pemberi_tugas.spt
        pemda = Pemda.objects.order_by("id").first()

        return {
            "pemda": pemda,
            "pemberi_tugas": pemberi_tugas,
            "spt": spt,
            "pelaksana_list": list(spt.pelaksana.all()),
            "tanggal_dokumen": (
                pemberi_tugas.tanggal_spt or spt.tgl_berangkat
            ),
            "asal_instansi": (
                pemberi_tugas.opd
                or getattr(pemda, "nama_dinas", "")
                or "Instansi Asal"
            ),
            "auto_print": (
                self.request.GET.get("autoprint", "1") != "0"
            ),
        }

    def get(self, request, pk):
        pemberi_tugas = self.get_object(pk)
        context = self.get_context_data(pemberi_tugas)
        return render(request, self.template_name, context)


class PemberiTugasPrintSptView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/spt.html"


class PemberiTugasPrintSpdView(PemberiTugasPrintBaseView):
    template_name = "components/pdf/spd.html"
