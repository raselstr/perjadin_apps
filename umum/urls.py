from django.urls import path
from .views import PegawaiView, umum_view

urlpatterns = [
    path('', umum_view, name='umum'),

    path("pegawai/", PegawaiView.as_view(), name="pegawai_list"),
    path("pegawai/form/", PegawaiView.as_view(), name="pegawai_action"),
    path("pegawai/form/<int:pk>/<str:action>/", PegawaiView.as_view(), name="pegawai_action_pk"),
    path("pegawai/delete/<int:pk>/<str:action>/", PegawaiView.as_view(), name="pegawai_delete"),
]