from django.urls import path
from .views import page_view

urlpatterns = [
    path("page/", page_view, name="core_page"),
]