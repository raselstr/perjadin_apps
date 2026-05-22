from decimal import Decimal

from django.core.exceptions import ValidationError
from django.core.validators import FileExtensionValidator, MinValueValidator
from django.db import models


BUKTI_VALIDATOR = FileExtensionValidator(
    allowed_extensions=["pdf", "jpg", "jpeg"],
    message="Bukti dukung hanya boleh berupa PDF atau JPEG.",
)

JENIS_SPJ_CHOICES = [
    ("Berangkat", "Berangkat"),
    ("Kembali", "Kembali"),
]


def _latest_standard(queryset):
    return queryset.select_related("dasar_peraturan").order_by(
        "-dasar_peraturan__tanggal_peraturan",
        "-dasar_peraturan_id",
        "-id",
    ).first()


def _pelaksana_tingkat(pelaksana):
    pegawai = getattr(pelaksana, "nama", None)
    return getattr(pegawai, "tingkat", None)


def _spt_jenis_spd(spt):
    lokasi = getattr(spt, "kota_tujuan", None)
    return getattr(lokasi, "jenis_spd", None)


class JenisSPJ(models.Model):
    jenis_spj = models.CharField(max_length=20, unique=True)

    class Meta:
        ordering = ["id"]
        verbose_name = "Jenis SPJ"
        verbose_name_plural = "Jenis SPJ"

    def __str__(self):
        return self.jenis_spj


class BaseSPJModel(models.Model):
    spt = models.ForeignKey(
        "perintah.Spt",
        on_delete=models.CASCADE,
        related_name="%(class)s_items",
    )
    pelaksana = models.ForeignKey(
        "perintah.Pelaksana",
        on_delete=models.CASCADE,
        related_name="%(class)s_items",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True

    def clean(self):
        super().clean()
        if (
            self.spt_id
            and self.pelaksana_id
            and self.pelaksana.spt_id != self.spt_id
        ):
            raise ValidationError({
                "pelaksana": (
                    "Pelaksana harus berasal dari SPT yang dipilih."
                )
            })

    def get_tingkat(self):
        if not self.pelaksana_id:
            return None
        return _pelaksana_tingkat(self.pelaksana)

    def get_jenis_spd(self):
        if not self.spt_id:
            return None
        return _spt_jenis_spd(self.spt)


class Penginapan(BaseSPJModel):
    nama_hotel = models.CharField(max_length=200)
    alamat_hotel = models.TextField(blank=True, default="")
    lama_menginap = models.PositiveIntegerField(
        validators=[MinValueValidator(1)]
    )
    harga_per_malam = models.DecimalField(
        max_digits=14,
        decimal_places=2,
        validators=[MinValueValidator(Decimal("0"))],
    )
    bukti = models.FileField(
        upload_to="spj/penginapan/",
        validators=[BUKTI_VALIDATOR],
        blank=True,
        null=True,
    )

    class Meta:
        ordering = ["-id"]
        verbose_name = "SPJ Penginapan"
        verbose_name_plural = "SPJ Penginapan"

    @property
    def total_biaya(self):
        return (self.harga_per_malam or 0) * (self.lama_menginap or 0)

    def get_standar_maksimal(self):
        from spd.models import StandardPenginapan

        tingkat = self.get_tingkat()
        if not self.spt_id or not self.spt.kota_tujuan_id or not tingkat:
            return None

        standard = _latest_standard(
            StandardPenginapan.objects.filter(
                lokasi=self.spt.kota_tujuan,
                tingkat=tingkat,
            )
        )
        return standard.biaya if standard else None

    def clean(self):
        super().clean()
        maksimal = self.get_standar_maksimal()
        if (
            maksimal is not None
            and self.harga_per_malam is not None
            and self.harga_per_malam > maksimal
        ):
            raise ValidationError({
                "harga_per_malam": (
                    f"Harga per malam melebihi standar maksimal {maksimal}."
                )
            })

    def __str__(self):
        return f"{self.pelaksana} - {self.nama_hotel}"


class Pesawat(BaseSPJModel):
    jenis_spj = models.ForeignKey(
        JenisSPJ,
        on_delete=models.PROTECT,
        related_name="pesawat_items",
    )
    lokasi_bandara = models.ForeignKey(
        "spd.Lokasi",
        on_delete=models.PROTECT,
        related_name="spj_pesawat_lokasi_bandara",
    )
    tujuan_bandara = models.ForeignKey(
        "spd.Lokasi",
        on_delete=models.PROTECT,
        related_name="spj_pesawat_tujuan_bandara",
    )
    harga_tiket = models.DecimalField(
        max_digits=14,
        decimal_places=2,
        validators=[MinValueValidator(Decimal("0"))],
    )
    bukti = models.FileField(
        upload_to="spj/pesawat/",
        validators=[BUKTI_VALIDATOR],
        blank=True,
        null=True,
    )

    class Meta:
        ordering = ["-id"]
        verbose_name = "SPJ Pesawat"
        verbose_name_plural = "SPJ Pesawat"

    @property
    def total_biaya(self):
        return self.harga_tiket or Decimal("0")

    def get_standar_maksimal(self):
        from spd.models import StandardPesawat

        tingkat = self.get_tingkat()
        if (
            not tingkat
            or not self.lokasi_bandara_id
            or not self.tujuan_bandara_id
        ):
            return None

        standard = _latest_standard(
            StandardPesawat.objects.filter(
                kota_asal=self.lokasi_bandara,
                kota_tujuan=self.tujuan_bandara,
                tingkat=tingkat,
            )
        )
        return standard.biaya if standard else None

    def clean(self):
        super().clean()
        maksimal = self.get_standar_maksimal()
        if (
            maksimal is not None
            and self.harga_tiket is not None
            and self.harga_tiket > maksimal
        ):
            raise ValidationError({
                "harga_tiket": (
                    f"Harga tiket melebihi standar maksimal {maksimal}."
                )
            })

    def __str__(self):
        return f"{self.pelaksana} - {self.jenis_spj}"


class UangHarian(BaseSPJModel):
    uang_harian_per_hari = models.DecimalField(
        max_digits=14,
        decimal_places=2,
        validators=[MinValueValidator(Decimal("0"))],
    )
    total_uang_harian = models.DecimalField(
        max_digits=14,
        decimal_places=2,
        default=0,
        editable=False,
    )

    class Meta:
        ordering = ["-id"]
        verbose_name = "SPJ Uang Harian"
        verbose_name_plural = "SPJ Uang Harian"

    @property
    def total_biaya(self):
        return self.total_uang_harian or Decimal("0")

    def get_standar_maksimal(self):
        from spd.models import StandardUangHarian

        if (
            not self.spt_id
            or not self.spt.kota_tujuan_id
            or not self.spt.jenis_kegiatan_id
        ):
            return None

        standard = _latest_standard(
            StandardUangHarian.objects.filter(
                lokasi=self.spt.kota_tujuan,
                jenis_kegiatan=self.spt.jenis_kegiatan,
            )
        )
        return standard.biaya if standard else None

    def clean(self):
        super().clean()
        maksimal = self.get_standar_maksimal()
        if (
            maksimal is not None
            and self.uang_harian_per_hari is not None
            and self.uang_harian_per_hari > maksimal
        ):
            raise ValidationError({
                "uang_harian_per_hari": (
                    f"Uang harian melebihi standar maksimal {maksimal}."
                )
            })

    def save(self, *args, **kwargs):
        self.total_uang_harian = (
            (self.uang_harian_per_hari or Decimal("0"))
            * (self.spt.lama_perjalanan if self.spt_id else 0)
        )
        self.full_clean()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.pelaksana} - {self.total_uang_harian}"


class Transport(BaseSPJModel):
    jenis_spj = models.ForeignKey(
        JenisSPJ,
        on_delete=models.PROTECT,
        related_name="transport_items",
    )
    jenis_transportasi = models.ForeignKey(
        "spd.JenisTransportasi",
        on_delete=models.PROTECT,
        related_name="spj_transport",
    )
    lokasi_berangkat = models.ForeignKey(
        "spd.Lokasi",
        on_delete=models.PROTECT,
        related_name="spj_transport_lokasi_berangkat",
    )
    tujuan = models.ForeignKey(
        "spd.Lokasi",
        on_delete=models.PROTECT,
        related_name="spj_transport_tujuan",
    )
    biaya = models.DecimalField(
        max_digits=14,
        decimal_places=2,
        validators=[MinValueValidator(Decimal("0"))],
    )
    bukti = models.FileField(
        upload_to="spj/transport/",
        validators=[BUKTI_VALIDATOR],
        blank=True,
        null=True,
    )

    class Meta:
        ordering = ["-id"]
        verbose_name = "SPJ Transport"
        verbose_name_plural = "SPJ Transport"

    @property
    def total_biaya(self):
        return self.biaya or Decimal("0")

    def get_standar_maksimal(self):
        from spd.models import StandardTransportasi

        if not self.jenis_transportasi_id or not self.tujuan_id:
            return None

        standard = _latest_standard(
            StandardTransportasi.objects.filter(
                jenis_transportasi=self.jenis_transportasi,
                kota_tujuan=self.tujuan,
            )
        )
        return standard.biaya if standard else None

    def clean(self):
        super().clean()
        maksimal = self.get_standar_maksimal()
        if (
            maksimal is not None
            and self.biaya is not None
            and self.biaya > maksimal
        ):
            raise ValidationError({
                "biaya": f"Biaya transport melebihi standar maksimal {maksimal}."
            })

    def __str__(self):
        return f"{self.pelaksana} - {self.jenis_transportasi}"


class UangRepresentasi(BaseSPJModel):
    biaya = models.DecimalField(
        max_digits=14,
        decimal_places=2,
        validators=[MinValueValidator(Decimal("0"))],
    )

    class Meta:
        ordering = ["-id"]
        verbose_name = "SPJ Uang Representasi"
        verbose_name_plural = "SPJ Uang Representasi"

    @property
    def total_biaya(self):
        return self.biaya or Decimal("0")

    def get_standar_maksimal(self):
        from spd.models import StandardRepresentasi

        tingkat = self.get_tingkat()
        jenis_spd = self.get_jenis_spd()
        if not tingkat or not jenis_spd:
            return None

        standard = _latest_standard(
            StandardRepresentasi.objects.filter(
                tingkat_spd=tingkat,
                jenis_spd=jenis_spd,
            )
        )
        return standard.biaya if standard else None

    def clean(self):
        super().clean()
        maksimal = self.get_standar_maksimal()
        if (
            maksimal is not None
            and self.biaya is not None
            and self.biaya > maksimal
        ):
            raise ValidationError({
                "biaya": (
                    f"Uang representasi melebihi standar maksimal {maksimal}."
                )
            })

    def __str__(self):
        return f"{self.pelaksana} - {self.biaya}"

# Create your models here.
