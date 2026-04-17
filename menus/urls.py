from django.urls import path
from . import views

urlpatterns = [
    path("permissions/", views.permission_view, name="permission_page"),
    path("permissions/update/", views.update_permission, name="permission_update"),
]