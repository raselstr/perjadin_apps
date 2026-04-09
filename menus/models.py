from django.db import models
from profiles.models import Role


class Menu(models.Model):
    nama = models.CharField(max_length=100)
    icon = models.CharField(max_length=100, blank=True, null=True)
    urutan = models.IntegerField(default=0)

    def __str__(self):
        return self.nama

    class Meta:
        ordering = ['urutan']


class SubMenu(models.Model):
    menu = models.ForeignKey(Menu, on_delete=models.CASCADE, related_name='submenus')
    nama = models.CharField(max_length=100)
    url = models.CharField(max_length=255)
    urutan = models.IntegerField(default=0)

    def __str__(self):
        return self.nama

    class Meta:
        ordering = ['urutan']


class RolePermission(models.Model):
    role = models.ForeignKey(Role, on_delete=models.CASCADE)
    submenu = models.ForeignKey(SubMenu, on_delete=models.CASCADE)

    can_view = models.BooleanField(default=True)
    can_add = models.BooleanField(default=False)
    can_edit = models.BooleanField(default=False)
    can_delete = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.role} - {self.submenu}"

    class Meta:
        unique_together = ('role', 'submenu')