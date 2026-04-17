from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from .models import Role, Menu, SubMenu, RolePermission
from django.views.decorators.http import require_POST
from django.http import JsonResponse


@login_required
def permission_view(request):
    roles = Role.objects.all()
    menus = Menu.objects.prefetch_related('submenus').all()

    if request.method == "POST":
        submenus = SubMenu.objects.all()

        for role in roles:
            for submenu in submenus:

                key = f"{role.id}_{submenu.id}"

                RolePermission.objects.update_or_create(
                    role=role,
                    submenu=submenu,
                    defaults={
                        "can_view": request.POST.get(f"view_{key}") == "on",
                        "can_add": request.POST.get(f"add_{key}") == "on",
                        "can_edit": request.POST.get(f"edit_{key}") == "on",
                        "can_delete": request.POST.get(f"delete_{key}") == "on",
                    }
                )

        return redirect("permission_page")

    # ambil permission existing
    permissions = RolePermission.objects.all()

    perm_dict = {}

    for p in permissions:
        if p.role_id not in perm_dict:
            perm_dict[p.role_id] = {}
        perm_dict[p.role_id][p.submenu_id] = p

    context = {
        "roles": roles,
        "menus": menus,   # <-- INI YANG FIX (bukan submenus global)
        "perm_dict": perm_dict,
    }

    return render(request, "menus/permission.html", context)


@require_POST
def update_permission(request):
    role_id = request.POST.get("role_id")
    submenu_id = request.POST.get("submenu_id")

    role = Role.objects.get(id=role_id)
    submenu = SubMenu.objects.get(id=submenu_id)

    perm, _ = RolePermission.objects.get_or_create(
        role=role,
        submenu=submenu
    )

    perm.can_view = request.POST.get("can_view") == "true"
    perm.can_add = request.POST.get("can_add") == "true"
    perm.can_edit = request.POST.get("can_edit") == "true"
    perm.can_delete = request.POST.get("can_delete") == "true"
    perm.save()

    return JsonResponse({"status": "ok"})