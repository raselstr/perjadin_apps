from datetime import timedelta

from django.core.exceptions import NON_FIELD_ERRORS, ValidationError
from django.db import models
from django.db.models import Q


class Spt(models.Model):
    KENDARAAN_CHOICES = [
        ('transport_umum', 'Transport Umum'),
        ('kendaraan_dinas', 'Kenderaan Dinas'),
    ]

    HARI_CHOICES = [
        (i, f"{i} hari") for i in range(1, 31)
    ]

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
    kota_tujuan_tambahan = models.ManyToManyField(
        "spd.Lokasi",
        related_name="spt_kota_tujuan_tambahan",
        blank=True,
    )
    tempat_tujuan = models.TextField(
        blank=True,
        null=True
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
        ordering = ["-id"]
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

    @property
    def kota_tujuan_display(self):
        from .document_utils import format_spt_kota_tujuan

        return format_spt_kota_tujuan(self)

    @property
    def tempat_tujuan_display(self):
        from .document_utils import format_spt_tempat_tujuan

        return format_spt_tempat_tujuan(self)

    @property
    def tujuan_perjalanan_display(self):
        from .document_utils import format_spt_tujuan_perjalanan

        return format_spt_tujuan_perjalanan(self)

    def __str__(self):
        return f"{self.kota_tujuan_display} - {self.tempat_tujuan_display}"

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

class PemberiTugas(models.Model):
    spt = models.ForeignKey(
        Spt,
        on_delete=models.CASCADE,
        related_name="pemberi_tugas",
    )
    penandatangan = models.ForeignKey(
        "umum.Penandatangan",
        on_delete=models.PROTECT,
        related_name="pemberi_tugas",
    )
    nomor_urut = models.CharField(
        max_length=50,
        blank=True,
        default="",
        verbose_name="Nomor Urut",
        help_text="Nomor urut untuk generate nomor SPT/SPD otomatis",
    )
    nomor_spt = models.CharField(
        max_length=150,
        blank=True,
        null=True,
        default=""
    )
    nomor_spd = models.CharField(
        max_length=150,
        blank=True,
        null=True,
        default=""
    )
    tanggal_spt = models.DateField(
        blank=True,
        null=True
    )
    nama = models.CharField(max_length=200)
    nip = models.CharField(max_length=30, blank=True, default="")
    pangkat = models.CharField(max_length=30, blank=True, default="")
    tugas = models.CharField(max_length=200)
    jenis_jabatan = models.CharField(max_length=100)
    opd = models.CharField(max_length=200)

    class Meta:
        ordering = ["spt", "penandatangan"]
        verbose_name = "Pemberi Tugas"
        verbose_name_plural = "Pemberi Tugas"
        constraints = [
            models.UniqueConstraint(
                fields=["spt", "penandatangan"],
                name="unique_pemberi_tugas_spt_penandatangan",
            ),
             # nomor_spt unik jika tidak null/kosong
            models.UniqueConstraint(
                fields=["nomor_spt"],
                condition=Q(nomor_spt__isnull=False) & ~Q(nomor_spt=""),
                name="unique_nomor_spt_not_blank",
            ),

            # nomor_spd unik jika tidak null/kosong
            models.UniqueConstraint(
                fields=["nomor_spd"],
                condition=Q(nomor_spd__isnull=False) & ~Q(nomor_spd=""),
                name="unique_nomor_spd_not_blank",
            ),
        ]

    def sync_from_penandatangan(self):
        if self.penandatangan:
            self.nama = self.penandatangan.nama
            self.nip = self.penandatangan.nip or ""
            self.pangkat = (
                self.penandatangan.pangkat.pangkat
                if self.penandatangan.pangkat else ""
            )
            self.tugas = self.penandatangan.tugas
            self.jenis_jabatan = (
                self.penandatangan.jenis_jabatan.nama
                if self.penandatangan.jenis_jabatan else ""
            )
            self.opd = (
                self.penandatangan.opd.nama
                if self.penandatangan.opd else ""
            )

    def clean(self):
        self.sync_from_penandatangan()

        self.nomor_spt = self._normalize_optional_number(self.nomor_spt)
        self.nomor_spd = self._normalize_optional_number(self.nomor_spd)

        if not self.spt_id:
            return

        duplicates = PemberiTugas.objects.exclude(pk=self.pk).filter(
            spt_id=self.spt_id,
            penandatangan_id=self.penandatangan_id,
        )

        errors = {}

        if self.penandatangan_id and duplicates.exists():
            errors["spt"] = (
                "SPT dengan pemberi tugas yang sama sudah terdaftar."
            )
            errors["penandatangan"] = (
                "Pemberi tugas untuk SPT tersebut sudah terdaftar."
            )
            errors[NON_FIELD_ERRORS] = [
                "Kombinasi SPT dan pemberi tugas tidak boleh ganda."
            ]

        self._validate_unique_document_number(
            "nomor_spt",
            "Nomor SPT sudah digunakan. Isi nomor SPT yang berbeda.",
            errors,
        )
        self._validate_unique_document_number(
            "nomor_spd",
            "Nomor SPD sudah digunakan. Isi nomor SPD yang berbeda.",
            errors,
        )

        if (
            self.tanggal_spt
            and self.spt.tgl_berangkat
            and self.tanggal_spt > self.spt.tgl_berangkat
        ):
            errors["tanggal_spt"] = (
                "Tanggal SPT tidak boleh lebih besar dari "
                "tanggal berangkat pada SPT."
            )

        if errors:
            raise ValidationError(errors)

    @staticmethod
    def _normalize_optional_number(value):
        value = (value or "").strip()
        return value

    def _validate_unique_document_number(self, field_name, message, errors):
        value = getattr(self, field_name)
        if not value:
            return

        if (
            PemberiTugas.objects.exclude(pk=self.pk)
            .filter(**{field_name: value})
            .exists()
        ):
            errors[field_name] = message

    def save(self, *args, **kwargs):
        self.sync_from_penandatangan()
        self.full_clean()
        super().save(*args, **kwargs)

    @property
    def can_print_spt(self):
        from .document_utils import can_print_spt_document

        if not self.spt_id:
            return False

        return can_print_spt_document(
            self.spt.pelaksana.select_related("nama", "nama__eselon").all(),
            self.tugas,
            opd_id=getattr(self.penandatangan, "opd_id", None),
        )

    @property
    def can_print_spd(self):
        return self.tugas not in ("Bupati", "Wakil Bupati")

    def __str__(self):
        return str(self.penandatangan)
    

    @property
    def can_print_spd_belakang(self):
        return self.tugas not in ("Bupati", "Wakil Bupati")

    def __str__(self):
        return str(self.penandatangan)

class TtdSptSpd(models.Model):
    pemberi_tugas = models.OneToOneField(
        PemberiTugas, 
        on_delete=models.PROTECT, 
        null=True, 
        unique=True,
        error_messages={
            'unique': "Nama Dinas sudah digunakan. Pilih nama dinas lain."
        },
        related_name='ttdsptspd'
        )
    hardcopy = models.FileField(upload_to='hardcopy/', null=True, blank=True)

    class Meta:
        ordering = ['pemberi_tugas']
        verbose_name = 'Tanda Tangan SPT/SPD'
        verbose_name_plural = 'Tanda Tangan SPT/SPD'

    def __str__(self):
        return str(self.pemberi_tugas)
    


