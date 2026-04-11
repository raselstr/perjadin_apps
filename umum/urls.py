from django.urls import path
from .views import PegawaiView, PenandatanganView, umum_view

urlpatterns = [
    path('', umum_view, name='umum'),

    path("pegawai/", PegawaiView.as_view(), name="pegawai_list"),
    path("pegawai/form/", PegawaiView.as_view(), name="pegawai_action"),
    path("pegawai/form/<int:pk>/<str:action>/", PegawaiView.as_view(), name="pegawai_action_pk"),
    path("pegawai/delete/<int:pk>/<str:action>/", PegawaiView.as_view(), name="pegawai_delete"),
    
    path("penandatangan/", PenandatanganView.as_view(), name="penandatangan_list"),
    path("penandatangan/form/", PenandatanganView.as_view(), name="penandatangan_action"),
    path("penandatangan/form/<int:pk>/<str:action>/", PenandatanganView.as_view(), name="penandatangan_action_pk"),
    path("penandatangan/delete/<int:pk>/<str:action>/", PenandatanganView.as_view(), name="penandatangan_delete"),
]