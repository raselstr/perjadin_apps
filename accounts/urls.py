from django.urls import path
from . import views

urlpatterns = [
    path('user/', views.user_list, name='user_list'),
    path('user/create/', views.user_create, name='user_create'),
    path('user/update/<int:id>/', views.user_update, name='user_update'),
    path('user/delete/<int:id>/', views.user_delete, name='user_delete'),
]