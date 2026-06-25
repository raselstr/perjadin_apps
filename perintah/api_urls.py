from django.urls import path

from .api_views import (
    MasterDataWAApiView,
    PrintSpdBelakangWAApiView,
    PrintSpdWAApiView,
    PrintSptWAApiView,
    SearchPegawaiWAApiView,
    SearchPenandatanganWAApiView,
    SearchJenisKegiatanWAApiView,
    CreateSptFromWAApiView,
    SearchLokasiWAApiView,
    WaSessionApiView,
)

urlpatterns = [
    path(
        "wa/session/",
        WaSessionApiView.as_view(),
        name="wa_session",
    ),

    path(
        "wa/master-data/",
        MasterDataWAApiView.as_view(),
        name="wa_master_data",
    ),

    path(
        "wa/search-pegawai/",
        SearchPegawaiWAApiView.as_view(),
        name="wa_search_pegawai",
    ),

    path(
        "wa/search-penandatangan/",
        SearchPenandatanganWAApiView.as_view(),
        name="wa_search_penandatangan",
    ),

    path(
        "wa/search-jenis-kegiatan/",
        SearchJenisKegiatanWAApiView.as_view(),
        name="wa_search_jenis_kegiatan",
    ),

    path(
        "wa/create-spt/",
        CreateSptFromWAApiView.as_view(),
        name="wa_create_spt",
    ),

    path(
        "wa/search-lokasi/",
        SearchLokasiWAApiView.as_view(),
        name="wa_search_lokasi",
    ),
    path(
        "wa/cetak/spt/<int:pk>/",
        PrintSptWAApiView.as_view(),
        name="wa_print_spt",
    ),
    
    path(
        "wa/cetak/spd/<int:pk>/",
        PrintSpdWAApiView.as_view(),
        name="wa_print_spd",
    ),

    path(
        "wa/cetak/spd-belakang/<int:pk>/",
        PrintSpdBelakangWAApiView.as_view(),
        name="wa_print_spd_belakang",
    ),
]
