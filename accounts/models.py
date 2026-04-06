from django.contrib.auth.models import User
from django.db import models

class OPD(models.Model):
    nama = models.CharField(max_length=255)

    def __str__(self):
        return self.nama


class Role(models.Model):
    nama = models.CharField(max_length=100)

    def __str__(self):
        return self.nama


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    opd = models.ForeignKey(OPD, on_delete=models.SET_NULL, null=True, blank=True)
    role = models.ForeignKey(Role, on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return self.nama