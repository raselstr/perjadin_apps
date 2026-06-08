from django.urls import path

from .api_views import (
    MasterDataWAApiView,
    SearchPegawaiWAApiView,
    SearchPenandatanganWAApiView,
    CreateSptFromWAApiView,
    SearchLokasiWAApiView,
)

urlpatterns = [

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
        "wa/create-spt/",
        CreateSptFromWAApiView.as_view(),
        name="wa_create_spt",
    ),

    path(
        "wa/search-lokasi/",
        SearchLokasiWAApiView.as_view(),
        name="wa_search_lokasi",
    ),
]