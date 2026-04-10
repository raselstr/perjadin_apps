from django.contrib import admin
from .models import Pegawai, Pangkat, JenisJabatan, StatusASN, Penandatangan

admin.site.register(Pegawai)
admin.site.register(Pangkat)
admin.site.register(JenisJabatan)
admin.site.register(StatusASN)
admin.site.register(Penandatangan)