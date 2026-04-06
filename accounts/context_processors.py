from menus.models import RolePermission, Menu

def menu_context(request):
    # Jika belum login → tidak tampilkan menu
    if not request.user.is_authenticated:
        return {}

    user = request.user

    # ==============================
    # SUPERUSER (LIHAT SEMUA MENU)
    # ==============================
    if user.is_superuser:
        menus = Menu.objects.prefetch_related('submenus').all()

        menu_data = []
        for menu in menus:
            menu_data.append({
                'menu': menu,
                'submenus': menu.submenus.all()
            })

        return {
            'menu_data': menu_data
        }

    # ==============================
    # USER BIASA (BERDASARKAN ROLE)
    # ==============================
    try:
        role = user.userprofile.role
    except:
        return {}

    # Ambil permission sesuai role
    permissions = RolePermission.objects.filter(
        role=role,
        can_view=True
    ).select_related('submenu__menu').order_by(
        'submenu__menu__urutan',
        'submenu__urutan'
    )

    menu_dict = {}

    for perm in permissions:
        menu = perm.submenu.menu

        # Jika menu belum ada → buat
        if menu.id not in menu_dict:
            menu_dict[menu.id] = {
                'menu': menu,
                'submenus': []
            }

        menu_dict[menu.id]['submenus'].append(perm.submenu)

    # Convert ke list
    menu_data = list(menu_dict.values())

    return {
        'menu_data': menu_data
    }