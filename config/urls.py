from django.urls import path, include
from dashboard.views import home_redirect
from django.contrib.auth import views as auth_views
from django.contrib import admin............................

urlpatterns = [
    path('admin/', admin.site.urls),  # 🔥 INI WAJIB ADA

    path('', home_redirect),
    path('login/', auth_views.LoginView.as_view(template_name='login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='/login/'), name='logout'),

    path('dashboard/', include('dashboard.urls')),
]