from datetime import timedelta
from django.db import models
from django.core.exceptions import ValidationError


class Spt(models.Model):
    KENDARAAN_CHOICES = [
        ('transport_umum', 'Transport Umum'),
        ('kendaraan_dinas', 'Kenderaan Dinas'),
    ]

    HARI_CHOICES = [
        (i, f"{i} hari") for i in range(1, 31)
    ]

    nomor_spt = models.CharField(
        max_length=150,
        blank=True,
        default=""
    )

    tanggal_spt = models.DateField(
        blank=True,
        null=True
    )

    dasar = models.TextField(
        blank=True,
        null=True
    )

    berita = models.TextField(
        blank=True,
        null=True
    )

    kota_tujuan = models.ForeignKey(
        "spd.Lokasi",
        on_delete=models.PROTECT,
        related_name="spt_kota_tujuan",
        blank=True,
        null=True,
    )

    lama_perjalanan = models.IntegerField(
        choices=HARI_CHOICES
    )

    tgl_berangkat = models.DateField()

    tgl_kembali = models.DateField(
        blank=True,
        null=True
    )

    jenis_kegiatan = models.ForeignKey(
        "spd.JenisKegiatan",
        on_delete=models.PROTECT,
        related_name="spt_jenis_kegiatan"
    )

    kendaraan = models.CharField(
        max_length=50,
        choices=KENDARAAN_CHOICES,
        blank=True,
        default=""
    )

    class Meta:
        ordering = ["-tanggal_spt", "-id"]
        verbose_name = "SPT"
        verbose_name_plural = "SPT"

    def clean(self):
        """
        Validasi:
        tanggal kembali tidak boleh lebih kecil
        dari tanggal berangkat
        """
        if self.tgl_berangkat and self.tgl_kembali:
            if self.tgl_kembali < self.tgl_berangkat:
                raise ValidationError({
                    "tgl_kembali": (
                        "Tanggal kembali tidak boleh "
                        "lebih kecil dari tanggal berangkat."
                    )
                })

    def save(self, *args, **kwargs):
        """
        Otomatis hitung tanggal kembali dari:
        tgl_berangkat + lama_perjalanan

        Contoh:
        1 hari = hari yang sama
        2 hari = +1 hari
        3 hari = +2 hari
        """
        if self.tgl_berangkat and self.lama_perjalanan:
            self.tgl_kembali = (
                self.tgl_berangkat +
                timedelta(days=self.lama_perjalanan - 1)
            )

        self.full_clean()
        super().save(*args, **kwargs)

    def lama_perjalanan_display(self):
        return f"{self.lama_perjalanan} hari"

    def __str__(self):
        nomor = self.nomor_spt if self.nomor_spt else "Tanpa Nomor"
        kota = self.kota_tujuan.lokasi if self.kota_tujuan else "Tanpa Tujuan"
        return f"{nomor} - {kota}"

class Pelaksana(models.Model):
    spt = models.ForeignKey(
        Spt,
        on_delete=models.CASCADE,
        related_name="pelaksana",
    )
    nama = models.ForeignKey(
        "umum.Pegawai",
        on_delete=models.PROTECT,
        related_name="pelaksana",
    )

    class Meta:
        ordering = ["spt", "nama"]
        verbose_name = "Pelaksana"
        verbose_name_plural = "Pelaksana"

    def __str__(self):
        return str(self.nama)
