from django.urls import path
from django.shortcuts import render
from .views import *

urlpatterns = [
    # ========================
    # LOGIN
    # ========================
    path('masuk/', login_view, name='masuk'),

    # ========================
    # OPD CRUD
    # ========================
    path('opd/', OPDView.as_view(), name='opd_list'),
    path('opd/form/', OPDView.as_view(), name='opd_action'),
    path('opd/form/<int:pk>/<str:action>/', OPDView.as_view(), name='opd_action_pk'),
    path('opd/delete/<int:pk>/<str:action>/', OPDView.as_view(), name='opd_delete'),

    # ========================
    # ROLE CRUD
    # ========================
    path('role/', RoleView.as_view(), name='role_list'),
    path('role/form/', RoleView.as_view(), name='role_action'),
    path('role/form/<int:pk>/<str:action>/', RoleView.as_view(), name='role_action_pk'),
    path('role/delete/<int:pk>/<str:action>/', RoleView.as_view(), name='role_delete'),

    # ========================
    # USER PROFILE CRUD
    # ========================
    path('userprofile/', UserProfileView.as_view(), name='userprofile_list'),
    path('userprofile/form/', UserProfileView.as_view(), name='userprofile_action'),
    path('userprofile/form/<int:pk>/<str:action>/', UserProfileView.as_view(), name='userprofile_action_pk'),
    path('userprofile/delete/<int:pk>/<str:action>/', UserProfileView.as_view(), name='userprofile_delete'),

    # ========================
    # CREATE USER WITH PROFILE
    # ========================
    path('userprofile/create-user/', create_user_with_profile, name='create_user_with_profile'),
]
