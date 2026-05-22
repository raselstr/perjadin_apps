from django.db import migrations


def seed_spj_defaults(apps, schema_editor):
    JenisSPJ = apps.get_model("spj", "JenisSPJ")
    Menu = apps.get_model("menus", "Menu")
    SubMenu = apps.get_model("menus", "SubMenu")
    Role = apps.get_model("profiles", "Role")
    RolePermission = apps.get_model("menus", "RolePermission")

    for jenis in ("Berangkat", "Kembali"):
        JenisSPJ.objects.get_or_create(jenis_spj=jenis)

    menu, _ = Menu.objects.get_or_create(
        nama="SPJ",
        defaults={
            "icon": "ti ti-receipt",
            "urutan": 40,
        },
    )

    submenus = [
        ("Jenis SPJ", "jenis_spj_list", 1),
        ("Penginapan", "penginapan_list", 2),
        ("Pesawat", "pesawat_list", 3),
        ("Uang Harian", "uang_harian_list", 4),
        ("Transport", "transport_list", 5),
        ("Uang Representasi", "uang_representasi_list", 6),
        ("Laporan SPJ", "spj_report", 7),
    ]

    submenu_objects = []
    for nama, url, urutan in submenus:
        submenu, _ = SubMenu.objects.get_or_create(
            url=url,
            defaults={
                "menu": menu,
                "nama": nama,
                "urutan": urutan,
            },
        )
        submenu_objects.append(submenu)

    Role.objects.get_or_create(nama="Pengguna")
    roles = list(Role.objects.all())

    for role in roles:
        for submenu in submenu_objects:
            permission, _ = RolePermission.objects.get_or_create(
                role=role,
                submenu=submenu,
            )
            permission.can_view = True
            permission.can_add = True
            permission.can_edit = True
            permission.can_delete = submenu.url != "spj_report"
            permission.save()


def unseed_spj_defaults(apps, schema_editor):
    JenisSPJ = apps.get_model("spj", "JenisSPJ")
    JenisSPJ.objects.filter(jenis_spj__in=["Berangkat", "Kembali"]).delete()


class Migration(migrations.Migration):

    dependencies = [
        ("menus", "0001_initial"),
        ("profiles", "0001_initial"),
        ("spj", "0001_initial"),
    ]

    operations = [
        migrations.RunPython(seed_spj_defaults, unseed_spj_defaults),
    ]
