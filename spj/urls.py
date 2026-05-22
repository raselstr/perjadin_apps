from django.urls import path

from .views import (
    JenisSPJView,
    PenginapanView,
    PesawatView,
    SPJReportView,
    TransportView,
    UangHarianView,
    UangRepresentasiView,
)

urlpatterns = [
    path("jenis-spj/", JenisSPJView.as_view(), name="jenis_spj_list"),
    path("jenis-spj/form/", JenisSPJView.as_view(), name="jenis_spj_action"),
    path(
        "jenis-spj/form/<int:pk>/<str:action>/",
        JenisSPJView.as_view(),
        name="jenis_spj_action_pk",
    ),
    path(
        "jenis-spj/delete/<int:pk>/<str:action>/",
        JenisSPJView.as_view(),
        name="jenis_spj_delete",
    ),

    path("penginapan/", PenginapanView.as_view(), name="penginapan_list"),
    path("penginapan/form/", PenginapanView.as_view(), name="penginapan_action"),
    path(
        "penginapan/form/<int:pk>/<str:action>/",
        PenginapanView.as_view(),
        name="penginapan_action_pk",
    ),
    path(
        "penginapan/delete/<int:pk>/<str:action>/",
        PenginapanView.as_view(),
        name="penginapan_delete",
    ),

    path("pesawat/", PesawatView.as_view(), name="pesawat_list"),
    path("pesawat/form/", PesawatView.as_view(), name="pesawat_action"),
    path(
        "pesawat/form/<int:pk>/<str:action>/",
        PesawatView.as_view(),
        name="pesawat_action_pk",
    ),
    path(
        "pesawat/delete/<int:pk>/<str:action>/",
        PesawatView.as_view(),
        name="pesawat_delete",
    ),

    path("uang-harian/", UangHarianView.as_view(), name="uang_harian_list"),
    path(
        "uang-harian/form/",
        UangHarianView.as_view(),
        name="uang_harian_action",
    ),
    path(
        "uang-harian/form/<int:pk>/<str:action>/",
        UangHarianView.as_view(),
        name="uang_harian_action_pk",
    ),
    path(
        "uang-harian/delete/<int:pk>/<str:action>/",
        UangHarianView.as_view(),
        name="uang_harian_delete",
    ),

    path("transport/", TransportView.as_view(), name="transport_list"),
    path("transport/form/", TransportView.as_view(), name="transport_action"),
    path(
        "transport/form/<int:pk>/<str:action>/",
        TransportView.as_view(),
        name="transport_action_pk",
    ),
    path(
        "transport/delete/<int:pk>/<str:action>/",
        TransportView.as_view(),
        name="transport_delete",
    ),

    path(
        "uang-representasi/",
        UangRepresentasiView.as_view(),
        name="uang_representasi_list",
    ),
    path(
        "uang-representasi/form/",
        UangRepresentasiView.as_view(),
        name="uang_representasi_action",
    ),
    path(
        "uang-representasi/form/<int:pk>/<str:action>/",
        UangRepresentasiView.as_view(),
        name="uang_representasi_action_pk",
    ),
    path(
        "uang-representasi/delete/<int:pk>/<str:action>/",
        UangRepresentasiView.as_view(),
        name="uang_representasi_delete",
    ),

    path("laporan/", SPJReportView.as_view(), name="spj_report"),
]
