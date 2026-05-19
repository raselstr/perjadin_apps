# Generated manually on 2026-05-19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("perintah", "0012_alter_pemberitugas_document_numbers_unique"),
        ("spd", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="spt",
            name="kota_tujuan_tambahan",
            field=models.ManyToManyField(
                blank=True,
                related_name="spt_kota_tujuan_tambahan",
                to="spd.lokasi",
            ),
        ),
    ]
