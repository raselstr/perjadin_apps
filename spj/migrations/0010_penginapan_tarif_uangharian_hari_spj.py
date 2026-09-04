from decimal import Decimal

import django.core.validators
from django.db import migrations, models


def fill_existing_uang_harian_days(apps, schema_editor):
    UangHarian = apps.get_model("spj", "UangHarian")
    for item in UangHarian.objects.select_related("spt"):
        lama_perjalanan = getattr(item.spt, "lama_perjalanan", None) or 1
        item.jumlah_hari_spj = lama_perjalanan
        item.total_uang_harian = (
            (item.uang_harian_per_hari or Decimal("0")) * lama_perjalanan
        )
        item.save(update_fields=["jumlah_hari_spj", "total_uang_harian"])


class Migration(migrations.Migration):

    dependencies = [
        ("spj", "0009_seed_kwitansi_menu"),
    ]

    operations = [
        migrations.AddField(
            model_name="penginapan",
            name="jenis_tarif_penginapan",
            field=models.CharField(
                choices=[
                    ("100", "100% dari biaya riil"),
                    ("30", "30% dari standar"),
                ],
                default="100",
                max_length=3,
                verbose_name="Pilihan Tarif Penginapan",
            ),
        ),
        migrations.AlterField(
            model_name="penginapan",
            name="nama_hotel",
            field=models.CharField(blank=True, default="", max_length=200),
        ),
        migrations.AlterField(
            model_name="penginapan",
            name="harga_per_malam",
            field=models.DecimalField(
                decimal_places=2,
                max_digits=14,
                validators=[
                    django.core.validators.MinValueValidator(Decimal("0"))
                ],
                verbose_name="Tarif per Hari/Malam",
            ),
        ),
        migrations.AlterField(
            model_name="penginapan",
            name="lama_menginap",
            field=models.PositiveIntegerField(
                validators=[django.core.validators.MinValueValidator(1)],
                verbose_name="Jumlah Hari/Malam SPJ",
            ),
        ),
        migrations.AddField(
            model_name="uangharian",
            name="jumlah_hari_spj",
            field=models.PositiveIntegerField(
                default=1,
                validators=[django.core.validators.MinValueValidator(1)],
                verbose_name="Jumlah Hari SPJ",
            ),
        ),
        migrations.RunPython(
            fill_existing_uang_harian_days,
            migrations.RunPython.noop,
        ),
    ]
