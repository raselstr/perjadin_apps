from django.urls import path
from . import views

urlpatterns = [
    path("permissions/", views.permission_view, name="permission_page"),
    path("permissions/update/", views.update_permission, name="permission_update"),

    path("menu/", views.MenuView.as_view(), name="menu_list"),
    path("menu/form/", views.MenuView.as_view(), name="menu_action"),
    path("menu/form/<int:pk>/<str:action>/", views.MenuView.as_view(), name="menu_action_pk"),
    path("menu/delete/<int:pk>/<str:action>/", views.MenuView.as_view(), name="menu_delete"),

    path("submenu/", views.SubMenuView.as_view(), name="submenu_list"),
    path("submenu/form/", views.SubMenuView.as_view(), name="submenu_action"),
    path("submenu/form/<int:pk>/<str:action>/", views.SubMenuView.as_view(), name="submenu_action_pk"),
    path("submenu/delete/<int:pk>/<str:action>/", views.SubMenuView.as_view(), name="submenu_delete"),
]