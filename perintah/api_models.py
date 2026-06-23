from django.db import models


class WaSession(models.Model):

    STEP_CHOICES = [
    ("DASAR_SPT", "Input Dasar SPT"),
    ("BERITA_SPT", "Input Berita SPT"),

    ("KOTA_TUJUAN", "Input Kota Tujuan"),
    ("PILIH_KOTA_TUJUAN", "Pilih Kota Tujuan"),

    ("KOTA_TUJUAN_TAMBAHAN", "Input Kota Tujuan Tambahan"),
    ("PILIH_KOTA_TUJUAN_TAMBAHAN", "Pilih Kota Tujuan Tambahan"),
    ("KONFIRMASI_KOTA_TUJUAN_TAMBAHAN", "Konfirmasi Kota Tujuan Tambahan"),

    ("TEMPAT_TUJUAN", "Input Tempat Tujuan"),

    ("INPUT_PELAKSANA", "Input Pelaksana"),
    ("PILIH_PELAKSANA", "Pilih Pelaksana"),

    ("TAMBAH_PELAKSANA", "Tambah Pelaksana"),

    ("INPUT_JENIS_KEGIATAN", "Input Jenis Kegiatan"),
    ("PILIH_JENIS_KEGIATAN", "Pilih Jenis Kegiatan"),

    ("INPUT_LAMA_PERJALANAN", "Input Lama Perjalanan"),
    ("INPUT_TANGGAL", "Input Tanggal"),
    ("INPUT_KENDERAAN", "Input Kendaraan"),
    ("PILIH_JENIS_KENDARAAN", "Pilih Jenis Kendaraan"),

    ("INPUT_PENANDATANGAN", "Input Penandatangan"),
    ("PILIH_PENANDATANGAN", "Pilih Penandatangan"),

    ("KONFIRMASI", "Konfirmasi"),
    ("SELESAI", "Selesai"),
]

    nomor = models.CharField(
        max_length=30,
        unique=True,
        db_index=True,
        verbose_name="Nomor WhatsApp",
    )

    step = models.CharField(
        max_length=50,
        choices=STEP_CHOICES,
        default="INPUT_PELAKSANA",
        db_index=True,
    )

    payload = models.JSONField(
        default=dict,
        blank=True,
        help_text="Data sementara percakapan WhatsApp"
    )

    created_at = models.DateTimeField(
        auto_now_add=True
    )

    updated_at = models.DateTimeField(
        auto_now=True
    )

    class Meta:
        ordering = ["-updated_at"]
        verbose_name = "WA Session"
        verbose_name_plural = "WA Sessions"

    def __str__(self):
        return f"{self.nomor} - {self.get_step_display()}"