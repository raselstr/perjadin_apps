from django.urls import path
from django.shortcuts import render
from .views import SptView
urlpatterns = [
    path("spt/", SptView.as_view(), name="spt_list"),
    path("spt/form/", SptView.as_view(), name="spt_action"),
    path("spt/form/<int:pk>/<str:action>/", SptView.as_view(), name="spt_action_pk"),
    path("spt/delete/<int:pk>/<str:action>/", SptView.as_view(), name="spt_delete"),
    path("spt/export/", SptView.as_view(), name="spt_export"),
    path("spt/import/", SptView.as_view(), name="spt_import"),
]