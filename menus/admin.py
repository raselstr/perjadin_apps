from django.contrib import admin
from .models import Menu, SubMenu, RolePermission


class SubMenuInline(admin.TabularInline):
    model = SubMenu
    extra = 1


@admin.register(Menu)
class MenuAdmin(admin.ModelAdmin):
    list_display = ('nama', 'urutan')
    inlines = [SubMenuInline]


@admin.register(RolePermission)
class RolePermissionAdmin(admin.ModelAdmin):
    list_display = ('role', 'submenu', 'can_view', 'can_add', 'can_edit', 'can_delete')
    list_filter = ('role',)


admin.site.register(SubMenu)