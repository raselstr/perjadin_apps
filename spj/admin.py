from django.contrib import admin

from .models import (
    JenisSPJ,
    Penginapan,
    Pesawat,
    Transport,
    UangHarian,
    UangRepresentasi,
)


admin.site.register(JenisSPJ)
admin.site.register(Penginapan)
admin.site.register(Pesawat)
admin.site.register(UangHarian)
admin.site.register(Transport)
admin.site.register(UangRepresentasi)
