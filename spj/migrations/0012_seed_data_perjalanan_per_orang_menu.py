from django.db import migrations


def seed_data_perjalanan_menu(apps, schema_editor):
    Menu = apps.get_model("menus", "Menu")
    SubMenu = apps.get_model("menus", "SubMenu")
    Role = apps.get_model("profiles", "Role")
    RolePermission = apps.get_model("menus", "RolePermission")

    menu, _ = Menu.objects.get_or_create(
        nama="SPJ",
        defaults={
            "icon": "ti ti-receipt",
            "urutan": 40,
        },
    )

    submenu, created = SubMenu.objects.get_or_create(
        url="data_perjalanan_per_orang",
        defaults={
            "menu": menu,
            "nama": "Data Perjalanan Per Orang",
            "urutan": 9,
        },
    )

    if not created:
        changed = False
        if submenu.menu_id != menu.id:
            submenu.menu = menu
            changed = True
        if submenu.nama != "Data Perjalanan Per Orang":
            submenu.nama = "Data Perjalanan Per Orang"
            changed = True
        if submenu.urutan != 9:
            submenu.urutan = 9
            changed = True
        if changed:
            submenu.save()

    for role in Role.objects.all():
        permission, _ = RolePermission.objects.get_or_create(
            role=role,
            submenu=submenu,
        )
        permission.can_view = True
        permission.can_add = False
        permission.can_edit = False
        permission.can_delete = False
        permission.save()


def unseed_data_perjalanan_menu(apps, schema_editor):
    SubMenu = apps.get_model("menus", "SubMenu")
    SubMenu.objects.filter(url="data_perjalanan_per_orang").delete()


class Migration(migrations.Migration):

    dependencies = [
        ("spj", "0011_multiple_penginapan_uangharian_tarif"),
    ]

    operations = [
        migrations.RunPython(
            seed_data_perjalanan_menu,
            unseed_data_perjalanan_menu,
        ),
    ]
