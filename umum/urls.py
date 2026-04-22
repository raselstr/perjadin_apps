from django.urls import path
from .views import (
    PegawaiView, PenandatanganView, PangkatView, JenisJabatanView, StatusASNView, TingkatExportView, TingkatImportView, TingkatView, umum_view,
    PegawaiExportView, PegawaiImportView,
    PangkatExportView, PangkatImportView,
    JenisJabatanExportView, JenisJabatanImportView,
    StatusASNExportView, StatusASNImportView,
    PenandatanganExportView, PenandatanganImportView,
)

urlpatterns = [
    path('', umum_view, name='umum'),

    path("pangkat/", PangkatView.as_view(), name="pangkat_list"),
    path("pangkat/form/", PangkatView.as_view(), name="pangkat_action"),
    path("pangkat/form/<int:pk>/<str:action>/", PangkatView.as_view(), name="pangkat_action_pk"),
    path("pangkat/delete/<int:pk>/<str:action>/", PangkatView.as_view(), name="pangkat_delete"),
    path("pangkat/export/", PangkatExportView.as_view(), name="pangkat_export"),
    path("pangkat/import/", PangkatImportView.as_view(), name="pangkat_import"),

    path("jenis-jabatan/", JenisJabatanView.as_view(), name="jenis_jabatan_list"),
    path("jenis-jabatan/form/", JenisJabatanView.as_view(), name="jenis_jabatan_action"),
    path("jenis-jabatan/form/<int:pk>/<str:action>/", JenisJabatanView.as_view(), name="jenis_jabatan_action_pk"),
    path("jenis-jabatan/delete/<int:pk>/<str:action>/", JenisJabatanView.as_view(), name="jenis_jabatan_delete"),
    path("jenis-jabatan/export/", JenisJabatanExportView.as_view(), name="jenis_jabatan_export"),
    path("jenis-jabatan/import/", JenisJabatanImportView.as_view(), name="jenis_jabatan_import"),

    path("status-asn/", StatusASNView.as_view(), name="status_asn_list"),
    path("status-asn/form/", StatusASNView.as_view(), name="status_asn_action"),
    path("status-asn/form/<int:pk>/<str:action>/", StatusASNView.as_view(), name="status_asn_action_pk"),
    path("status-asn/delete/<int:pk>/<str:action>/", StatusASNView.as_view(), name="status_asn_delete"),
    path("status-asn/export/", StatusASNExportView.as_view(), name="status_asn_export"),
    path("status-asn/import/", StatusASNImportView.as_view(), name="status_asn_import"),

    path("pegawai/", PegawaiView.as_view(), name="pegawai_list"),
    path("pegawai/form/", PegawaiView.as_view(), name="pegawai_action"),
    path("pegawai/form/<int:pk>/<str:action>/", PegawaiView.as_view(), name="pegawai_action_pk"),
    path("pegawai/delete/<int:pk>/<str:action>/", PegawaiView.as_view(), name="pegawai_delete"),
    path("pegawai/export/", PegawaiExportView.as_view(), name="pegawai_export"),
    path("pegawai/import/", PegawaiImportView.as_view(), name="pegawai_import"),
    
    path("penandatangan/", PenandatanganView.as_view(), name="penandatangan_list"),
    path("penandatangan/form/", PenandatanganView.as_view(), name="penandatangan_action"),
    path("penandatangan/form/<int:pk>/<str:action>/", PenandatanganView.as_view(), name="penandatangan_action_pk"),
    path("penandatangan/delete/<int:pk>/<str:action>/", PenandatanganView.as_view(), name="penandatangan_delete"),
    path("penandatangan/export/", PenandatanganExportView.as_view(), name="penandatangan_export"),
    path("penandatangan/import/", PenandatanganImportView.as_view(), name="penandatangan_import"),

    path("tingkat/", TingkatView.as_view(), name="tingkat_list"),
    path("tingkat/form/", TingkatView.as_view(), name="tingkat_action"),
    path("tingkat/form/<int:pk>/<str:action>/", TingkatView.as_view(), name="tingkat_action_pk"),
    path("tingkat/delete/<int:pk>/<str:action>/", TingkatView.as_view(), name="tingkat_delete"),
    path("tingkat/export/", TingkatExportView.as_view(), name="tingkat_export"),
    path("tingkat/import/", TingkatImportView.as_view(), name="tingkat_import"),
]