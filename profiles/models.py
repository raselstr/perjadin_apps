from django.contrib.auth.models import User
from django.db import models

from core.utils.image_compression import compress_if_image, is_uploaded_image

class OPD(models.Model):
    nama = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.nama


class Role(models.Model):
    nama = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.nama


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    opd = models.ForeignKey(OPD, on_delete=models.SET_NULL, null=True, blank=True)
    role = models.ForeignKey(Role, on_delete=models.SET_NULL, null=True, blank=True)
    foto = models.ImageField(upload_to="profiles/users/", null=True, blank=True)

    def __str__(self):
        return self.user.username

    def save(self, *args, **kwargs):
        if is_uploaded_image(self.foto):
            self.foto = compress_if_image(self.foto)
        super().save(*args, **kwargs)
