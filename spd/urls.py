from django.urls import path
from .views import (
    DasarPeraturanView
)

urlpatterns = [
    path("dasar-peraturan/", DasarPeraturanView.as_view(), name="dasar_peraturan_list"),
    path("dasar-peraturan/form/", DasarPeraturanView.as_view(), name="dasar_peraturan_action"),
    path("dasar-peraturan/form/<int:pk>/<str:action>/", DasarPeraturanView.as_view(), name="dasar_peraturan_action_pk"),
    path("dasar-peraturan/delete/<int:pk>/<str:action>/", DasarPeraturanView.as_view(), name="dasar_peraturan_delete"),
    path("dasar-peraturan/export/", DasarPeraturanView.as_view(), name="dasar_peraturan_export"),
    path("dasar-peraturan/import/", DasarPeraturanView.as_view(), name="dasar_peraturan_import"),
]