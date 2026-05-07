from django.urls import path
from .views import (
    PemberiTugasPreviewSpdView,
    PemberiTugasPreviewSptView,
    PemberiTugasPrintSpdView,
    PemberiTugasPrintSptView,
    PemberiTugasView,
    SptView,
)
urlpatterns = [
    path("spt/", SptView.as_view(), name="spt_list"),
    path("spt/form/", SptView.as_view(), name="spt_action"),
    path("spt/form/<int:pk>/<str:action>/", SptView.as_view(), name="spt_action_pk"),
    path("spt/delete/<int:pk>/<str:action>/", SptView.as_view(), name="spt_delete"),
    path("spt/export/", SptView.as_view(), name="spt_export"),
    path("spt/import/", SptView.as_view(), name="spt_import"),

    path("pemberi-tugas/", PemberiTugasView.as_view(), name="pemberi_tugas_list"),
    path("pemberi-tugas/form/", PemberiTugasView.as_view(), name="pemberi_tugas_action"),
    path("pemberi-tugas/form/<int:pk>/<str:action>/", PemberiTugasView.as_view(), name="pemberi_tugas_action_pk"),
    path("pemberi-tugas/delete/<int:pk>/<str:action>/", PemberiTugasView.as_view(), name="pemberi_tugas_delete"),
    path(
        "pemberi-tugas/preview/spt/<int:pk>/",
        PemberiTugasPreviewSptView.as_view(),
        name="pemberi_tugas_preview_spt",
    ),
    path(
        "pemberi-tugas/preview/spd/<int:pk>/",
        PemberiTugasPreviewSpdView.as_view(),
        name="pemberi_tugas_preview_spd",
    ),
    path(
        "pemberi-tugas/cetak/spt/<int:pk>/",
        PemberiTugasPrintSptView.as_view(),
        name="pemberi_tugas_print_spt",
    ),
    path(
        "pemberi-tugas/cetak/spd/<int:pk>/",
        PemberiTugasPrintSpdView.as_view(),
        name="pemberi_tugas_print_spd",
    ),
]
