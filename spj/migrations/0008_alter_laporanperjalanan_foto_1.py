from django.db import migrations, models

import django.core.validators


class Migration(migrations.Migration):

    dependencies = [
        ("spj", "0007_transport_tanggal_berangkat"),
    ]

    operations = [
        migrations.AlterField(
            model_name="laporanperjalanan",
            name="foto_1",
            field=models.ImageField(
                blank=True,
                null=True,
                upload_to="spj/laporan/",
                validators=[
                    django.core.validators.FileExtensionValidator(
                        allowed_extensions=["jpg", "jpeg", "png", "webp"],
                        message="Foto hanya boleh berupa JPG, PNG, atau WEBP.",
                    )
                ],
            ),
        ),
    ]
