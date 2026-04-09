from django.urls import path
from django.shortcuts import render
from .views import *

urlpatterns = [
    # ========================
    # LOGIN
    # ========================
    path('masuk/', login_view, name='masuk'),
]