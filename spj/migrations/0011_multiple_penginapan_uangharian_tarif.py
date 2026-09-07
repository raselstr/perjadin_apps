from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("spj", "0010_penginapan_tarif_uangharian_hari_spj"),
    ]

    operations = [
        migrations.AlterField(
            model_name="penginapan",
            name="jenis_tarif_penginapan",
            field=models.CharField(
                choices=[
                    ("100", "100% dari biaya riil"),
                    ("30", "30% dari standar"),
                    ("0", "0% (tidak dibayar)"),
                ],
                default="100",
                max_length=3,
                verbose_name="Pilihan Tarif Penginapan",
            ),
        ),
        migrations.RemoveConstraint(
            model_name="penginapan",
            name="unique_spj_penginapan_spt_pelaksana",
        ),
        migrations.RemoveConstraint(
            model_name="uangharian",
            name="unique_spj_uang_harian_spt_pelaksana",
        ),
        migrations.AddField(
            model_name="uangharian",
            name="jenis_tarif_uang_harian",
            field=models.CharField(
                choices=[
                    ("100", "100% dari standar"),
                    ("30", "30% dari standar"),
                    ("0", "0% (tidak dibayar)"),
                ],
                default="100",
                max_length=3,
                verbose_name="Pilihan Tarif Uang Harian",
            ),
        ),
    ]
