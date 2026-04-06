from django.urls import path, include
from dashboard.views import home_redirect
from django.contrib.auth import views as auth_views
from django.contrib import admin
from accounts.views import login_view # Pastikan path import benar

urlpatterns = [
    path('admin/', admin.site.urls),

    path('', home_redirect),
    # Perbaikan: login_view adalah fungsi, panggil langsung namanya
    path('login/', login_view, name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='/login/'), name='logout'),

    path('dashboard/', include('dashboard.urls')),
]
