from django.urls import path
from .views import dashboard_view, halaman_contoh

urlpatterns = [
    path('', dashboard_view, name='dashboard'),
    path('contoh/', halaman_contoh, name='contoh'),
]