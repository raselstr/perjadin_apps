# Generated manually on 2026-05-19

from django.db import migrations, models
from django.db.models import Q


class Migration(migrations.Migration):

    dependencies = [
        ("perintah", "0011_remove_pemberitugas_unique_pemberi_tugas_spt_penandatangan_nomor_spt_nomor_spd_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="pemberitugas",
            name="nomor_spt",
            field=models.CharField(
                blank=True,
                default="",
                max_length=150,
                null=True,
            ),
        ),
        migrations.AlterField(
            model_name="pemberitugas",
            name="nomor_spd",
            field=models.CharField(
                blank=True,
                default="",
                max_length=150,
                null=True,
            ),
        ),
        migrations.AddConstraint(
            model_name="pemberitugas",
            constraint=models.UniqueConstraint(
                fields=("nomor_spt",),
                condition=Q(nomor_spt__isnull=False) & ~Q(nomor_spt=""),
                name="unique_nomor_spt_not_blank",
            ),
        ),
        migrations.AddConstraint(
            model_name="pemberitugas",
            constraint=models.UniqueConstraint(
                fields=("nomor_spd",),
                condition=Q(nomor_spd__isnull=False) & ~Q(nomor_spd=""),
                name="unique_nomor_spd_not_blank",
            ),
        ),
    ]
