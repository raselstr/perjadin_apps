from django.db import models

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
        constraints = [
            models.UniqueConstraint(
                fields=['nama', 'jenis_jabatan'],
                name='uniq_penandatangan_nama_jenis_jabatan',
            ),
        ]

    def __str__(self):
        return f"{self.nama} - {self.tugas} - {self.opd}"
