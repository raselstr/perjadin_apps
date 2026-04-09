from django.contrib import admin
from .models import OPD, Role, UserProfile

admin.site.register(OPD)
admin.site.register(Role)
admin.site.register(UserProfile)