from django.urls import path, include
from dashboard.views import home_redirect
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from profiles.views import logout_view

urlpatterns = [
    path('admin/', admin.site.urls),

    path('', home_redirect),
    path('logout/', logout_view, name='logout'),
    path('menus/', include('menus.urls')),
    path('dashboard/', include('dashboard.urls')),
    path('profiles/', include('profiles.urls')),
    path('umum/', include('umum.urls')),
    path('core/', include('core.urls')),
]
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATICFILES_DIRS[0])
