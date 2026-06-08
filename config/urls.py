from django.urls import path, include,re_path
from dashboard.views import home_redirect
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from profiles.views import logout_view
from django.views.static import serve

urlpatterns = [
    path('admin/', admin.site.urls),

    path('', home_redirect),
    path('logout/', logout_view, name='logout'),
    path('menus/', include('menus.urls')),
    path('dashboard/', include('dashboard.urls')),
    path('profiles/', include('profiles.urls')),
    path('umum/', include('umum.urls')),
    path('core/', include('core.urls')),
    path('spd/', include('spd.urls')),
    path('perintah/', include('perintah.urls')),
    path('spj/', include('spj.urls')),
    path('api/',include('perintah.api_urls')),
]

# Media selalu dilayani
urlpatterns += [
    re_path(
        r'^media/(?P<path>.*)$',
        serve,
        {'document_root': settings.MEDIA_ROOT},
    ),
]

# Static hanya saat development
if settings.DEBUG:
    urlpatterns += static(
        settings.STATIC_URL,
        document_root=settings.STATICFILES_DIRS[0]
    )