import logging

from django.contrib.auth.models import User
from django.core.files.uploadedfile import UploadedFile
from django.db import models

from core.utils.image_compression import compress_image_file, ImageCompressionError

logger = logging.getLogger(__name__)

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
        if self.foto and isinstance(self.foto, UploadedFile):
            try:
                self.foto = compress_image_file(self.foto)
            except ImageCompressionError as e:
                logger.warning(f"Image compression failed for user profile: {e}")
        super().save(*args, **kwargs)
