from django.core.exceptions import NON_FIELD_ERRORS, ValidationError
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
            return f"{self.pangkat} ({self.golongan}/{self.ruang})"
        return f"{self.pangkat} ({self.golongan})"

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
        ).exists()

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
    logo = models.ImageField(upload_to='pemda_logos/', null=True, blank=True)

    class Meta:
        ordering = ['nama_pemda']
        verbose_name = 'Pemda'
        verbose_name_plural = 'Pemda'

    def __str__(self):
        return self.nama_pemda
