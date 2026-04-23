from django.contrib import admin

from spd.models import DasarPeraturan, JenisKegiatan, JenisSPD, JenisTransportasi, Lokasi, StandardPenginapan, StandardPesawat, StandardRepresentasi, StandardTransportasi, StandardUangHarian

# Register your models here.
admin.site.register(DasarPeraturan)
admin.site.register(JenisSPD)
admin.site.register(JenisKegiatan)
admin.site.register(Lokasi)
admin.site.register(StandardPenginapan)
admin.site.register(StandardPesawat)
admin.site.register(StandardUangHarian)
admin.site.register(JenisTransportasi)
admin.site.register(StandardTransportasi)
admin.site.register(StandardRepresentasi)