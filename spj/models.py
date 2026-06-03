import logging
from decimal import Decimal

from django.core.exceptions import ValidationError
from django.conf import settings
from django.core.validators import FileExtensionValidator, MaxValueValidator, MinValueValidator
from django.db import models
from django.utils.dateformat import format as date_format
from django.utils import timezone

from core.utils.image_compression import compress_image_file, ImageCompressionError

logger = logging.getLogger(__name__)


BUKTI_VALIDATOR = FileExtensionValidator(
    allowed_extensions=["pdf", "jpg", "jpeg", "png", "webp"],
    message="Bukti dukung hanya boleh berupa PDF atau foto.",
)

FOTO_VALIDATOR = FileExtensionValidator(
    allowed_extensions=["jpg", "jpeg", "png", "webp"],
    message="Foto hanya boleh berupa JPG, PNG, atau WEBP.",
)

JENIS_SPJ_CHOICES = [
    ("Berangkat", "Berangkat"),
    ("Kembali", "Kembali"),
]

VERIF_STATUS_CHOICES = [
    ("draft", "Belum Diverifikasi"),
    ("verified", "Diverifikasi"),
    ("rejected", "Ditolak"),
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
    verif_status = models.CharField(
        max_length=20,
        choices=VERIF_STATUS_CHOICES,
        default="draft",
        verbose_name="Status Verifikasi",
    )
    verified_by = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="%(class)s_verified_items",
        editable=False,
    )
    verified_at = models.DateTimeField(
        blank=True,
        null=True,
        editable=False,
    )

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

    @property
    def is_verified(self):
        return self.verif_status == "verified"

    def mark_verification_user(self, user):
        if self.verif_status == "verified":
            self.verified_by = user
            self.verified_at = timezone.now()
        elif self.verif_status != "verified":
            self.verified_by = None
            self.verified_at = None

    def _raise_duplicate_error(self, filters, message):
        if not self.spt_id or not self.pelaksana_id:
            return

        duplicate = self.__class__.objects.filter(**filters)
        if self.pk:
            duplicate = duplicate.exclude(pk=self.pk)
        if duplicate.exists():
            raise ValidationError({"spt": message})


class Penginapan(BaseSPJModel):
    nama_hotel = models.CharField(max_length=200)
    alamat_hotel = models.TextField(blank=True, default="")
    foto_hotel = models.ImageField(
        upload_to="spj/penginapan/hotel/",
        validators=[FOTO_VALIDATOR],
        blank=True,
        null=True,
    )
    latitude = models.DecimalField(
        max_digits=10,
        decimal_places=7,
        blank=True,
        null=True,
        validators=[MinValueValidator(Decimal("-90")), MaxValueValidator(Decimal("90"))],
        verbose_name="Latitude Hotel",
    )
    longitude = models.DecimalField(
        max_digits=10,
        decimal_places=7,
        blank=True,
        null=True,
        validators=[MinValueValidator(Decimal("-180")), MaxValueValidator(Decimal("180"))],
        verbose_name="Longitude Hotel",
    )
    tipe_kamar = models.CharField(max_length=100, blank=True, default="")
    nomor_kamar = models.CharField(max_length=50, blank=True, default="")
    tanggal_checkin = models.DateField(blank=True, null=True)
    tanggal_checkout = models.DateField(blank=True, null=True)
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
        constraints = [
            models.UniqueConstraint(
                fields=["spt", "pelaksana"],
                name="unique_spj_penginapan_spt_pelaksana",
            )
        ]

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
        self._raise_duplicate_error(
            {"spt": self.spt, "pelaksana": self.pelaksana},
            "SPJ Penginapan untuk SPT dan pelaksana ini sudah dibuat.",
        )
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

    def save(self, *args, **kwargs):
        if self.foto_hotel:
            try:
                self.foto_hotel = compress_image_file(self.foto_hotel)
            except ImageCompressionError as e:
                logger.warning(f"Image compression failed for Penginapan foto_hotel: {e}")
        super().save(*args, **kwargs)


class Pesawat(BaseSPJModel):
    jenis_spj = models.ForeignKey(
        JenisSPJ,
        on_delete=models.PROTECT,
        related_name="pesawat_items",
    )
    nama_maskapai = models.CharField(max_length=100, blank=True, default="")
    nomor_tiket = models.CharField(max_length=100, blank=True, default="")
    kode_booking = models.CharField(max_length=100, blank=True, default="")
    tanggal_penerbangan = models.DateField(blank=True, null=True)
    lokasi_bandara = models.ForeignKey(
        "spd.bandara",
        on_delete=models.PROTECT,
        related_name="spj_pesawat_lokasi_bandara",
    )
    tujuan_bandara = models.ForeignKey(
        "spd.bandara",
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
        constraints = [
            models.UniqueConstraint(
                fields=["spt", "pelaksana", "jenis_spj"],
                name="unique_spj_pesawat_spt_pelaksana_jenis",
            )
        ]

    @property
    def total_biaya(self):
        return self.harga_tiket or Decimal("0")

    def get_standar_maksimal(self):
        from spd.models import StandardPesawat

        tingkat = self.get_tingkat()
        if not tingkat or not self.lokasi_bandara_id or not self.tujuan_bandara_id:
            return None

        asal = getattr(self.lokasi_bandara, "provinsi", None)
        tujuan = getattr(self.tujuan_bandara, "provinsi", None)
        if not asal or not tujuan:
            return None

        standard = _latest_standard(
            StandardPesawat.objects.filter(
                kota_asal=asal,
                kota_tujuan=tujuan,
                tingkat=tingkat,
            )
        )
        return standard.biaya if standard else None

    def clean(self):
        super().clean()
        if self.spt_id and self.pelaksana_id and self.jenis_spj_id:
            self._raise_duplicate_error(
                {
                    "spt": self.spt,
                    "pelaksana": self.pelaksana,
                    "jenis_spj": self.jenis_spj,
                },
                "SPJ Pesawat dengan jenis ini untuk SPT dan pelaksana ini sudah dibuat.",
            )
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
        constraints = [
            models.UniqueConstraint(
                fields=["spt", "pelaksana"],
                name="unique_spj_uang_harian_spt_pelaksana",
            )
        ]

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
        self._raise_duplicate_error(
            {"spt": self.spt, "pelaksana": self.pelaksana},
            "SPJ Uang Harian untuk SPT dan pelaksana ini sudah dibuat.",
        )
        if self.get_standar_maksimal() is None:
            raise ValidationError({
                "uang_harian_per_hari": (
                    "Standar uang harian untuk SPT ini belum tersedia."
                )
            })

    def save(self, *args, **kwargs):
        self.uang_harian_per_hari = self.get_standar_maksimal() or Decimal("0")
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
    tanggal_berangkat = models.DateField(blank=True, null=True)
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
        constraints = [
            models.UniqueConstraint(
                fields=["spt", "pelaksana", "jenis_spj", "jenis_transportasi"],
                name="unique_spj_transport_spt_pelaksana_jenis_transport",
            )
        ]

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
        if (
            self.spt_id
            and self.pelaksana_id
            and self.jenis_spj_id
            and self.jenis_transportasi_id
        ):
            self._raise_duplicate_error(
                {
                    "spt": self.spt,
                    "pelaksana": self.pelaksana,
                    "jenis_spj": self.jenis_spj,
                    "jenis_transportasi": self.jenis_transportasi,
                },
                "SPJ Transport dengan jenis ini untuk SPT dan pelaksana ini sudah dibuat.",
            )
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
        constraints = [
            models.UniqueConstraint(
                fields=["spt", "pelaksana"],
                name="unique_spj_representasi_spt_pelaksana",
            )
        ]

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
        self._raise_duplicate_error(
            {"spt": self.spt, "pelaksana": self.pelaksana},
            "SPJ Uang Representasi untuk SPT dan pelaksana ini sudah dibuat.",
        )
        if self.get_standar_maksimal() is None:
            raise ValidationError({
                "biaya": (
                    "Pelaksana ini tidak memenuhi kriteria Standar Uang Representasi."
                )
            })

    def save(self, *args, **kwargs):
        self.biaya = self.get_standar_maksimal() or Decimal("0")
        self.full_clean()
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.pelaksana} - {self.biaya}"


class LaporanPerjalanan(BaseSPJModel):
    spt = models.OneToOneField(
        "perintah.Spt",
        on_delete=models.CASCADE,
        related_name="laporan_perjalanan",
    )
    pelaksana = models.ForeignKey(
        "perintah.Pelaksana",
        on_delete=models.PROTECT,
        related_name="laporan_perjalanan",
        help_text="Pelaksana yang menginput laporan. Cukup satu laporan untuk satu SPT.",
    )
    judul = models.CharField(max_length=250)
    dasar_pelaksanaan = models.TextField(blank=True, default="")
    maksud_perjalanan = models.TextField(blank=True, default="")
    instansi_dikunjungi = models.TextField(blank=True, default="")
    waktu_pelaksanaan = models.TextField(blank=True, default="")
    pembukaan = models.TextField(blank=True, default="")
    isi_pertemuan = models.TextField(blank=True, default="")
    hasil = models.TextField(blank=True, default="")
    penutup = models.TextField(
        blank=True,
        default="Demikian Laporan Perjalanan Dinas ini dibuat, sebagai bahan Laporan.",
    )
    foto_1 = models.ImageField(
        upload_to="spj/laporan/",
        validators=[FOTO_VALIDATOR],
        blank=True,
        null=True,
    )
    foto_2 = models.ImageField(upload_to="spj/laporan/", validators=[FOTO_VALIDATOR], blank=True, null=True)
    foto_3 = models.ImageField(upload_to="spj/laporan/", validators=[FOTO_VALIDATOR], blank=True, null=True)
    foto_4 = models.ImageField(upload_to="spj/laporan/", validators=[FOTO_VALIDATOR], blank=True, null=True)
    latitude = models.DecimalField(
        max_digits=10,
        decimal_places=7,
        blank=True,
        null=True,
        validators=[MinValueValidator(Decimal("-90")), MaxValueValidator(Decimal("90"))],
        verbose_name="Latitude Lokasi Foto",
    )
    longitude = models.DecimalField(
        max_digits=10,
        decimal_places=7,
        blank=True,
        null=True,
        validators=[MinValueValidator(Decimal("-180")), MaxValueValidator(Decimal("180"))],
        verbose_name="Longitude Lokasi Foto",
    )

    class Meta:
        ordering = ["-id"]
        verbose_name = "Laporan Perjalanan Dinas"
        verbose_name_plural = "Laporan Perjalanan Dinas"

    def __str__(self):
        return f"SPT #{self.spt_id} - {self.judul}"

    @staticmethod
    def _format_date(value):
        if not value:
            return "-"
        return date_format(value, "d F Y")

    def _build_title(self):
        tujuan = self.spt.tempat_tujuan_display or self.spt.tempat_tujuan or ""
        kota = self.spt.kota_tujuan_display or ""
        berita = self.spt.berita or ""
        return " - ".join(part for part in [tujuan, kota, berita] if part)

    def _build_dasar_pelaksanaan(self):
        from perintah.models import PemberiTugas

        spt = self.spt
        tahun = spt.tgl_berangkat.year if spt.tgl_berangkat else timezone.localdate().year
        pemberi = PemberiTugas.objects.filter(spt=spt).first()
        nomor_spt = getattr(pemberi, "nomor_spt", "") or "-"
        tanggal_spt = self._format_date(getattr(pemberi, "tanggal_spt", None))
        nomor_spd = getattr(pemberi, "nomor_spd", "") or "-"
        tanggal_spd = tanggal_spt

        items = [
            f"1. Dokumen Pelaksanaan Anggaran - DPA TA {tahun}",
            f"2. Surat Perintah Tugas Nomor: {nomor_spt} Tanggal {tanggal_spt}",
        ]

        for nomor, pelaksana in enumerate(spt.pelaksana.select_related("nama").all(), start=3):
            items.append(
                f"{nomor}. SPPD Nomor: {nomor_spd} Tanggal {tanggal_spd}, "
                f"An. {pelaksana.nama.nama}"
            )

        return "\n".join(items)

    def _build_waktu_pelaksanaan(self):
        lama = self.spt.lama_perjalanan
        berangkat = self._format_date(self.spt.tgl_berangkat)
        kembali = self._format_date(self.spt.tgl_kembali)
        return (
            f"Dilaksanakan selama {lama} hari pada tanggal {berangkat}"
            if berangkat == kembali
            else f"Dilaksanakan selama {lama} hari mulai tanggal {berangkat} sampai dengan {kembali}"
        )

    def populate_from_spt(self):
        if not self.spt_id:
            return

        self.judul = self._build_title()[:250]
        self.dasar_pelaksanaan = self._build_dasar_pelaksanaan()
        self.maksud_perjalanan = self.spt.berita or ""
        self.instansi_dikunjungi = " ".join(
            part for part in [
                self.spt.tempat_tujuan_display or self.spt.tempat_tujuan or "",
                self.spt.kota_tujuan_display or "",
            ] if part
        )
        self.waktu_pelaksanaan = self._build_waktu_pelaksanaan()

    def save(self, *args, **kwargs):
        self.populate_from_spt()
        self.hasil = "\n\n".join(
            part for part in [
                self.pembukaan,
                self.isi_pertemuan,
                self.penutup,
            ] if part
        )

        # Compress image fields
        for field_name in ['foto_1', 'foto_2', 'foto_3', 'foto_4']:
            image_field = getattr(self, field_name, None)
            if image_field:
                try:
                    compressed = compress_image_file(image_field)
                    setattr(self, field_name, compressed)
                except ImageCompressionError as e:
                    logger.warning(f"Image compression failed for LaporanPerjalanan {field_name}: {e}")

        super().save(*args, **kwargs)
