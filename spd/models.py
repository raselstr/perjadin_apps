from django.db import models
from django.utils import timezone


class DasarPeraturan(models.Model):
    """
    Master dasar hukum / peraturan.

    Contoh:
    - PMK No. 49 Tahun 2023
    - Perpres Standar Biaya Masukan 2026
    - Surat Edaran Internal
    """
    nama_peraturan = models.CharField(max_length=255)
    nomor_peraturan = models.CharField(max_length=150, blank=True, null=True)
    tanggal_peraturan = models.DateField(blank=True, null=True)
    keterangan = models.TextField(blank=True, null=True)
    aktif = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-tanggal_peraturan", "nama_peraturan"]
        verbose_name = "Dasar Peraturan"
        verbose_name_plural = "Dasar Peraturan"

    def __str__(self):
        nomor = f" ({self.nomor_peraturan})" if self.nomor_peraturan else ""
        return f"{self.nama_peraturan}{nomor}"


class BaseMasterModel(models.Model):
    """
    Base model untuk seluruh master biaya.

    Yang disimpan di sini hanya:
    - referensi dasar peraturan
    - status aktif
    - audit dasar

    Masa berlaku tidak disimpan per row,
    tetapi mengikuti tabel DasarPeraturan.
    """
    dasar_peraturan = models.ForeignKey(
        DasarPeraturan,
        on_delete=models.PROTECT,
        related_name="%(class)s_items",
    )
    aktif = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class JenisSPD(models.Model):
    nama = models.CharField(max_length=100, unique=True)

    class Meta:
        ordering = ["nama"]
        verbose_name = "Jenis SPD"
        verbose_name_plural = "Jenis SPD"

    def __str__(self):
        return self.nama


class JenisKegiatan(models.Model):
    nama = models.CharField(max_length=100, unique=True)

    class Meta:
        ordering = ["nama"]
        verbose_name = "Jenis Kegiatan"
        verbose_name_plural = "Jenis Kegiatan"

    def __str__(self):
        return self.nama


class Lokasi(models.Model):
    lokasi = models.CharField(max_length=150, unique=True)
    jenis_spd = models.ForeignKey(
        JenisSPD,
        on_delete=models.PROTECT,
        related_name="lokasi",
        null=True,
        blank=True,
    )

    class Meta:
        ordering = ["jenis_spd", "lokasi"]
        verbose_name = "Lokasi"
        verbose_name_plural = "Lokasi"

    def __str__(self):
        return self.lokasi


class StandardPenginapan(BaseMasterModel):
    lokasi = models.ForeignKey(
        Lokasi,
        on_delete=models.PROTECT,
        related_name="standard_penginapan",
    )
    tingkat = models.ForeignKey(
        "umum.Tingkat",
        on_delete=models.PROTECT,
        related_name="standard_penginapan",
    )
    biaya = models.DecimalField(max_digits=14, decimal_places=2)

    class Meta:
        ordering = ["lokasi", "tingkat"]
        verbose_name = "Standar Penginapan"
        verbose_name_plural = "Standar Penginapan"
        constraints = [
            models.UniqueConstraint(
                fields=["lokasi", "tingkat", "dasar_peraturan"],
                name="unique_penginapan_lokasi_tingkat_dasar_peraturan",
            )
        ]

    def __str__(self):
        return f"{self.lokasi} - {self.tingkat} - {self.biaya}"


class StandardPesawat(BaseMasterModel):
    kota_asal = models.ForeignKey(
        Lokasi,
        on_delete=models.PROTECT,
        related_name="standard_pesawat_asal",
    )
    kota_tujuan = models.ForeignKey(
        Lokasi,
        on_delete=models.PROTECT,
        related_name="standard_pesawat_tujuan",
    )
    tingkat = models.ForeignKey(
        "umum.Tingkat",
        on_delete=models.PROTECT,
        related_name="standard_pesawat",
    )
    biaya = models.DecimalField(max_digits=14, decimal_places=2)

    class Meta:
        ordering = ["kota_asal", "kota_tujuan", "tingkat"]
        verbose_name = "Standar Tiket Pesawat"
        verbose_name_plural = "Standar Tiket Pesawat"
        constraints = [
            models.UniqueConstraint(
                fields=["kota_asal", "kota_tujuan", "tingkat", "dasar_peraturan"],
                name="unique_pesawat_asal_tujuan_tingkat_dasar_peraturan",
            )
        ]

    def __str__(self):
        return f"{self.kota_asal} → {self.kota_tujuan} - {self.tingkat}"


class StandardUangHarian(BaseMasterModel):
    lokasi = models.ForeignKey(
        Lokasi,
        on_delete=models.PROTECT,
        related_name="standard_uang_harian",
    )
    jenis_kegiatan = models.ForeignKey(
        JenisKegiatan,
        on_delete=models.PROTECT,
        related_name="standard_uang_harian",
    )
    satuan = models.CharField(max_length=50)
    biaya = models.DecimalField(max_digits=14, decimal_places=2)

    class Meta:
        ordering = ["lokasi", "jenis_kegiatan"]
        verbose_name = "Standar Uang Harian"
        verbose_name_plural = "Standar Uang Harian"
        constraints = [
            models.UniqueConstraint(
                fields=["lokasi", "jenis_kegiatan", "dasar_peraturan"],
                name="unique_uang_harian_lokasi_kegiatan_dasar_peraturan",
            )
        ]

    def __str__(self):
        return f"{self.lokasi} - {self.jenis_kegiatan} - {self.biaya}"


class JenisTransportasi(models.Model):
    """
    Menggabungkan:
    - Taksi
    - Transportasi Lokal
    - Sewa Kendaraan
    """
    nama = models.CharField(max_length=100, unique=True)

    class Meta:
        ordering = ["nama"]
        verbose_name = "Jenis Transportasi"
        verbose_name_plural = "Jenis Transportasi"

    def __str__(self):
        return self.nama


class StandardTransportasi(BaseMasterModel):
    jenis_transportasi = models.ForeignKey(
        JenisTransportasi,
        on_delete=models.PROTECT,
        related_name="standard_transportasi",
    )
    kota_tujuan = models.ForeignKey(
        Lokasi,
        on_delete=models.PROTECT,
        related_name="standard_transportasi",
    )
    satuan = models.CharField(max_length=50)
    biaya = models.DecimalField(max_digits=14, decimal_places=2)

    class Meta:
        ordering = ["jenis_transportasi", "kota_tujuan"]
        verbose_name = "Standar Transportasi"
        verbose_name_plural = "Standar Transportasi"
        constraints = [
            models.UniqueConstraint(
                fields=["jenis_transportasi", "kota_tujuan", "dasar_peraturan"],
                name="unique_transportasi_jenis_kota_dasar_peraturan",
            )
        ]

    def __str__(self):
        return f"{self.jenis_transportasi} - {self.kota_tujuan}"


class StandardRepresentasi(BaseMasterModel):
    jenis_jabatan = models.ForeignKey(
        "umum.JenisJabatan",
        on_delete=models.PROTECT,
        related_name="standard_representasi",
    )
    jenis_spd = models.ForeignKey(
        JenisSPD,
        on_delete=models.PROTECT,
        related_name="standard_representasi",
    )
    biaya = models.DecimalField(max_digits=14, decimal_places=2)

    class Meta:
        ordering = ["jenis_jabatan", "jenis_spd"]
        verbose_name = "Standar Representasi"
        verbose_name_plural = "Standar Representasi"
        constraints = [
            models.UniqueConstraint(
                fields=["jenis_jabatan", "jenis_spd", "dasar_peraturan"],
                name="unique_representasi_jabatan_spd_dasar_peraturan",
            )
        ]

    def __str__(self):
        return f"{self.jenis_jabatan} - {self.jenis_spd}"

