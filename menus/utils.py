from .models import Menu, RolePermission

def get_user_menus(user):
    # 🔥 SUPERUSER BYPASS
    if user.is_superuser:
        return Menu.objects.all()

    if not hasattr(user, 'userprofile'):
        return Menu.objects.none()

    role = user.userprofile.role

    permissions = RolePermission.objects.filter(
        role=role,
        can_view=True
    ).select_related('submenu__menu')

    menu_ids = permissions.values_list('submenu__menu_id', flat=True)

    return Menu.objects.filter(id__in=menu_ids).distinct()

def get_user_submenus(user, menu):
    # 🔥 SUPERUSER BYPASS
    if user.is_superuser:
        return menu.submenus.all()

    role = user.userprofile.role

    permissions = RolePermission.objects.filter(
        role=role,
        submenu__menu=menu,
        can_view=True
    ).select_related('submenu')

    return [p.submenu for p in permissions]