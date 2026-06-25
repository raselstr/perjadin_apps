from django.db import migrations


def seed_kwitansi_menu(apps, schema_editor):
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
        url="kwitansi_list",
        defaults={
            "menu": menu,
            "nama": "Kwitansi",
            "urutan": 8,
        },
    )
    if not created:
        changed = False
        if submenu.menu_id != menu.id:
            submenu.menu = menu
            changed = True
        if submenu.nama != "Kwitansi":
            submenu.nama = "Kwitansi"
            changed = True
        if submenu.urutan != 8:
            submenu.urutan = 8
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


def unseed_kwitansi_menu(apps, schema_editor):
    SubMenu = apps.get_model("menus", "SubMenu")
    SubMenu.objects.filter(url="kwitansi_list").delete()


class Migration(migrations.Migration):

    dependencies = [
        ("spj", "0008_alter_laporanperjalanan_foto_1"),
    ]

    operations = [
        migrations.RunPython(seed_kwitansi_menu, unseed_kwitansi_menu),
    ]
