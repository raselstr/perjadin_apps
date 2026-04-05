from django.urls import path, include
from dashboard.views import home_redirect
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('', home_redirect),  # 👈 ROOT diarahkan ke sini

    path('login/', auth_views.LoginView.as_view(template_name='auth/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='/login/'), name='logout'),

    path('dashboard/', include('dashboard.urls')),
]
