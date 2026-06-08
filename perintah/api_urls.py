from django.urls import path

from .api_views import (
    CreateSptFromWAApiView,
)

urlpatterns = [
    path(
        "wa/create-spt/",
        CreateSptFromWAApiView.as_view(),
        name="api_create_spt",
    ),
]