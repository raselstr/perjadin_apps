from django.urls import path, include
from dashboard.views import home_redirect
from django.contrib.auth import views as auth_views
from django.contrib import admin

urlpatterns = [
    path('admin/', admin.site.urls),

    path('', home_redirect),
    # Perbaikan: login_view adalah fungsi, panggil langsung namanya
    path('logout/', auth_views.LogoutView.as_view(next_page='/profiles/masuk/'), name='logout'),

    path('dashboard/', include('dashboard.urls')),
    path('profiles/', include('profiles.urls')),
    path('umum/', include('umum.urls')),
    path('core/', include('core.urls')),
]
