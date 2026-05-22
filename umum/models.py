from django.core.exceptions import NON_FIELD_ERRORS, ValidationError
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.db.models import Q

class Pangkat(models.Model):
    pangkat = models.CharField(max_length=100)
    golongan = models.CharField(max_length=10)
    ruang = models.CharField(
        max_length=10,
        blank=True,
        default=""
    )

    class Meta:
        ordering = ['golongan', 'ruang']
        constraints = [
            models.UniqueConstraint(
                fields=['pangkat', 'golongan', 'ruang'],
                name='unique_pangkat_golongan_ruang'
            )
        ]

    def __str__(self):
        if self.ruang:
            return f"{self.pangkat} / {self.golongan}.{self.ruang}"
        return f"{self.pangkat} / {self.golongan}"

class Eselon(models.Model):
    eselon = models.CharField(max_length=100, unique=True)
    keterangan = models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return self.eselon


class JenisJabatan(models.Model):
    nama = models.CharField(max_length=150, unique=True)
    keterangan= models.CharField(max_length=200, null=True, blank=True)
    fungsi= models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return self.nama


class StatusASN(models.Model):
    nama = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.nama

class Tingkat(models.Model):
    tingkat = models.CharField(max_length=100, unique=True)
    ket = models.CharField(max_length=200, null=True, blank=True)
    pesawat = models.CharField(max_length=100, null=True, blank=True)
    kapal = models.CharField(max_length=100, null=True, blank=True)
    keretaapian = models.CharField(max_length=200, null=True, blank=True)
    lainnya = models.CharField(max_length=200, null=True, blank=True)
    
    def __str__(self):
        return f"{self.tingkat}"

class Pegawai(models.Model):
    
    nip = models.CharField(max_length=30)
    nama = models.CharField(max_length=200)

    pangkat = models.ForeignKey(
        Pangkat,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='pegawai'
    )

    jabatan = models.CharField(max_length=200)
    eselon=models.ForeignKey(
        Eselon,
        on_delete=models.SET_NULL,
        null=True,
        default="",
        related_name='pegawai'
    )

    jenis_jabatan = models.ForeignKey(
        JenisJabatan,
        on_delete=models.SET_NULL,
        null=True,
        default="",
        related_name='pegawai'
    )

    status = models.ForeignKey(
        StatusASN,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='pegawai'
    )

    tgl_lahir = models.DateField(null=True, blank=True)

    opd = models.ForeignKey(
        'profiles.OPD',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='pegawai'
    )

    tingkat = models.ForeignKey(
        Tingkat,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='pegawai'
    )


    class Meta:
        ordering = ['id']
        constraints = [
            models.UniqueConstraint(
                fields=['nip', 'eselon', 'jenis_jabatan'],
                name='unique_pegawai_nip_eselon_jenis_jabatan'
            )
        ]

    def __str__(self):
        return f"{self.nama} ({self.jabatan})"
    


class Penandatangan(models.Model):
    TUGAS_CHOICES = [
        ('Bupati', 'Bupati'),
        ('Wakil Bupati', 'Wakil Bupati'),
        ('Sekretaris Daerah', 'Sekretaris Daerah'),
        ('Kepala', 'Kepala'),
        ('Kepala Bidang', 'Kepala Bidang'),
        ('PPK', 'Pejabat Pembuat Komitmen'),
    ]
    nama = models.CharField(max_length=200)
    nip = models.CharField(max_length=30, null=True, blank=True)

    pangkat = models.ForeignKey(
        Pangkat,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='penandatangan'
    )

    tugas = models.CharField(max_length=200, choices=TUGAS_CHOICES, null=True, default="")

    jenis_jabatan = models.ForeignKey(
        JenisJabatan,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='penandatangan'
    )

    opd = models.ForeignKey(
        'profiles.OPD',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='penandatangan'
    )
    
    class Meta:
        ordering = ['id']
        constraints = [
            models.UniqueConstraint(
                fields=['nama', 'tugas','jenis_jabatan', 'opd'],
                name='uniq_penandatangan_nama_tugas_jenis_jabatan_opd',
                violation_error_message=(
                    "Penandatangan dengan Nama, tugas, "
                    "jenis jabatan, dan OPD yang sama sudah ada."
                )
            ),   
        ]

    def clean(self):
        super().clean()

        duplicates = Penandatangan.objects.exclude(pk=self.pk).filter(
            nama=self.nama,
            tugas=self.tugas,
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
        )

        if not duplicates.exists():
            return

        message = (
            "Penandatangan dengan NIP, nama, tugas, "
            "jenis jabatan, dan OPD yang sama sudah ada."
        )

        raise ValidationError({
            "nip": message,
            "nama": message,
            "tugas": message,
            "jenis_jabatan": message,
            "opd": message,
            NON_FIELD_ERRORS: [message],
        })

    def __str__(self):
        return f"{self.nama} - {self.tugas} - {self.opd}"

class Pemda(models.Model):
    nama_pemda = models.CharField(max_length=200)
    nama_dinas = models.OneToOneField(
        'profiles.OPD', 
        on_delete=models.PROTECT, 
        null=True, 
        unique=True,
        error_messages={
            'unique': "Nama Dinas sudah digunakan. Pilih nama dinas lain."
        },
        related_name='pemda'
        )
    nama_kabupaten = models.CharField(max_length=200, null=True, blank=True)
    ibukota = models.CharField(max_length=100, null=True, blank=True)
    alamat = models.CharField(max_length=300, null=True, blank=True)
    telepon = models.CharField(max_length=50, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    website = models.URLField(null=True, blank=True)
    password_standar = models.CharField(
        max_length=128,
        blank=True,
        default="",
        help_text="Password standar untuk login pegawai dengan NIP.",
    )
    logo = models.ImageField(upload_to='pemda_logos/', null=True, blank=True)

    class Meta:
        ordering = ['nama_pemda']
        verbose_name = 'Pemda'
        verbose_name_plural = 'Pemda'

    def __str__(self):
        return self.nama_pemda


class KopSurat(models.Model):
    FONT_FAMILY_CHOICES = [
        ("Arial, sans-serif", "Arial"),
        ('"Times New Roman", Times, serif', "Times New Roman"),
        ("Calibri, Arial, sans-serif", "Calibri"),
        ("Cambria, Georgia, serif", "Cambria"),
        ('Garamond, "Times New Roman", serif', "Garamond"),
        ("Tahoma, Geneva, sans-serif", "Tahoma"),
        ("Verdana, Geneva, sans-serif", "Verdana"),
    ]

    ALIGNMENT_CHOICES = [
        ("left", "Kiri"),
        ("center", "Tengah"),
        ("right", "Kanan"),
    ]

    pemda = models.OneToOneField(
        Pemda,
        on_delete=models.CASCADE,
        related_name="kop_surat",
    )
    font_family = models.CharField(
        max_length=120,
        choices=FONT_FAMILY_CHOICES,
        default="Arial, sans-serif",
        verbose_name="Jenis Font",
    )
    region_font_size_pt = models.PositiveSmallIntegerField(
        default=14,
        validators=[MinValueValidator(8), MaxValueValidator(32)],
        verbose_name="Ukuran Font Nama Pemda (pt)",
    )
    office_font_size_pt = models.PositiveSmallIntegerField(
        default=18,
        validators=[MinValueValidator(8), MaxValueValidator(36)],
        verbose_name="Ukuran Font Nama Dinas/Jabatan (pt)",
    )
    address_font_size_pt = models.PositiveSmallIntegerField(
        default=10,
        validators=[MinValueValidator(8), MaxValueValidator(20)],
        verbose_name="Ukuran Font Alamat (pt)",
    )
    contact_font_size_pt = models.PositiveSmallIntegerField(
        default=10,
        validators=[MinValueValidator(8), MaxValueValidator(20)],
        verbose_name="Ukuran Font Kontak (pt)",
    )
    logo_width_px = models.PositiveSmallIntegerField(
        default=90,
        validators=[MinValueValidator(0), MaxValueValidator(180)],
        verbose_name="Lebar Logo (px)",
    )
    logo_height_px = models.PositiveSmallIntegerField(
        default=90,
        validators=[MinValueValidator(0), MaxValueValidator(180)],
        verbose_name="Tinggi Logo (px)",
    )
    print_scale_percent = models.PositiveSmallIntegerField(
        default=96,
        validators=[MinValueValidator(75), MaxValueValidator(120)],
        verbose_name="Skala Cetak Default (%)",
    )

    # Margin settings for paper edge distance
    margin_top_mm = models.PositiveSmallIntegerField(
        default=18,
        validators=[MinValueValidator(1), MaxValueValidator(50)],
        verbose_name="Margin Atas (mm)",
    )
    margin_bottom_mm = models.PositiveSmallIntegerField(
        default=20,
        validators=[MinValueValidator(1), MaxValueValidator(50)],
        verbose_name="Margin Bawah (mm)",
    )
    margin_left_mm = models.PositiveSmallIntegerField(
        default=18,
        validators=[MinValueValidator(1), MaxValueValidator(50)],
        verbose_name="Margin Kiri (mm)",
    )
    margin_right_mm = models.PositiveSmallIntegerField(
        default=18,
        validators=[MinValueValidator(1), MaxValueValidator(50)],
        verbose_name="Margin Kanan (mm)",
    )

    # Default number format for SPT and SPD
    default_spt_number_format = models.CharField(
        max_length=100,
        blank=True,
        default="800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}",
        verbose_name="Format Default Nomor SPT",
        help_text="Gunakan {nomor_urut}, {bulan}, {tahun} sebagai placeholder",
    )
    default_spd_number_format = models.CharField(
        max_length=100,
        blank=True,
        default="800.1.11.1/{nomor_urut}/SPD/{bulan}/{tahun}",
        verbose_name="Format Default Nomor SPD",
        help_text="Gunakan {nomor_urut}, {bulan}, {tahun} sebagai placeholder",
    )

    class Meta:
        ordering = ["pemda__nama_pemda"]
        verbose_name = "Kop Surat"
        verbose_name_plural = "Kop Surat"

    @property
    def font_family_css(self):
        return self.font_family or "Arial, sans-serif"

    @property
    def print_scale_decimal(self):
        scale = (self.print_scale_percent or 100) / 100
        return f"{scale:.2f}".rstrip("0").rstrip(".")

    @property
    def margin_css(self):
        return (
            f"{self.margin_top_mm}mm "
            f"{self.margin_right_mm}mm "
            f"{self.margin_bottom_mm}mm "
            f"{self.margin_left_mm}mm"
        )

    def __str__(self):
        return f"Kop Surat - {self.pemda}"
