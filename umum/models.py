from django.db import models

class Pangkat(models.Model):
    pangkat = models.CharField(max_length=100)
    golongan = models.CharField(max_length=10)
    ruang = models.CharField(max_length=10)

    class Meta:
        ordering = ['golongan', 'ruang']

    def __str__(self):
        return f"{self.pangkat} ({self.golongan}/{self.ruang})"


class JenisJabatan(models.Model):
    nama = models.CharField(max_length=150)

    def __str__(self):
        return self.nama


class StatusASN(models.Model):
    nama = models.CharField(max_length=100)

    def __str__(self):
        return self.nama

class Pegawai(models.Model):
    nip = models.CharField(max_length=30, unique=True)
    nama = models.CharField(max_length=200)

    pangkat = models.ForeignKey(
        Pangkat,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='pegawai'
    )

    jabatan = models.CharField(max_length=200)

    jenis_jabatan = models.ForeignKey(
        JenisJabatan,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
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
    
    class Meta:
        ordering = ['id']

    def __str__(self):
        return f"{self.nama} ({self.nip})"
    


class Penandatangan(models.Model):
    nama = models.CharField(max_length=200)
    nip = models.CharField(max_length=30, null=True, blank=True)

    pangkat = models.ForeignKey(
        Pangkat,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='penandatangan'
    )

    tugas = models.CharField(max_length=200)

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

    def __str__(self):
        return f"{self.nama} - {self.tugas} - {self.opd}"