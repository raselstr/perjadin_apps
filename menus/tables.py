from core.tables import BaseTable, action_column
from .models import Menu, SubMenu


class MenuTable(BaseTable):
    aksi = action_column("menu_action_pk", "menu_delete")

    class Meta(BaseTable.Meta):
        model = Menu
        fields = ('no', 'nama', 'icon', 'urutan', 'aksi')


class SubMenuTable(BaseTable):
    aksi = action_column("submenu_action_pk", "submenu_delete")

    class Meta(BaseTable.Meta):
        model = SubMenu
        fields = ('no', 'menu', 'nama', 'url', 'urutan', 'aksi')
