from django.urls import path
from .views import (
    DasarPeraturanView,
    JenisKegiatanView,
    JenisSPDView,
    LokasiView,
    DasarPeraturanExportView,
    DasarPeraturanImportView,
    JenisKegiatanExportView,
    JenisKegiatanImportView,
    JenisSPDExportView,
    JenisSPDImportView,
    LokasiExportView,
    LokasiImportView,
    
)

urlpatterns = [
    path("dasar-peraturan/", DasarPeraturanView.as_view(), name="dasar_peraturan_list"),
    path("dasar-peraturan/form/", DasarPeraturanView.as_view(), name="dasar_peraturan_action"),
    path("dasar-peraturan/form/<int:pk>/<str:action>/", DasarPeraturanView.as_view(), name="dasar_peraturan_action_pk"),
    path("dasar-peraturan/delete/<int:pk>/<str:action>/", DasarPeraturanView.as_view(), name="dasar_peraturan_delete"),
    path("dasar-peraturan/export/", DasarPeraturanExportView.as_view(), name="dasar_peraturan_export"),
    path("dasar-peraturan/import/", DasarPeraturanImportView.as_view(), name="dasar_peraturan_import"),

    path("jenis-spd/", JenisSPDView.as_view(), name="jenis_spd_list"),
    path("jenis-spd/form/", JenisSPDView.as_view(), name="jenis_spd_action"),
    path("jenis-spd/form/<int:pk>/<str:action>/", JenisSPDView.as_view(), name="jenis_spd_action_pk"),
    path("jenis-spd/delete/<int:pk>/<str:action>/", JenisSPDView.as_view(), name="jenis_spd_delete"),
    path("jenis-spd/export/", JenisSPDExportView.as_view(), name="jenis_spd_export"),
    path("jenis-spd/import/", JenisSPDImportView.as_view(), name="jenis_spd_import"),

    path("jenis-kegiatan/", JenisKegiatanView.as_view(), name="jenis_kegiatan_list"),
    path("jenis-kegiatan/form/", JenisKegiatanView.as_view(), name="jenis_kegiatan_action"),
    path("jenis-kegiatan/form/<int:pk>/<str:action>/", JenisKegiatanView.as_view(), name="jenis_kegiatan_action_pk"),
    path("jenis-kegiatan/delete/<int:pk>/<str:action>/", JenisKegiatanView.as_view(), name="jenis_kegiatan_delete"),
    path("jenis-kegiatan/export/", JenisKegiatanExportView.as_view(), name="jenis_kegiatan_export"),
    path("jenis-kegiatan/import/", JenisKegiatanImportView.as_view(), name="jenis_kegiatan_import"),

    path("lokasi-kegiatan/", LokasiView.as_view(), name="lokasi_kegiatan_list"),
    path("lokasi-kegiatan/form/", LokasiView.as_view(), name="lokasi_kegiatan_action"),
    path("lokasi-kegiatan/form/<int:pk>/<str:action>/", LokasiView.as_view(), name="lokasi_kegiatan_action_pk"),
    path("lokasi-kegiatan/delete/<int:pk>/<str:action>/", LokasiView.as_view(), name="lokasi_kegiatan_delete"),
    path("lokasi-kegiatan/export/", LokasiExportView.as_view(), name="lokasi_kegiatan_export"),
    path("lokasi-kegiatan/import/", LokasiImportView.as_view(), name="lokasi_kegiatan_import"),
]