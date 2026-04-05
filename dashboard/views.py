from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from menus.utils import get_user_menus, get_user_submenus
from django.http import HttpResponse

def home_redirect(request):
    if request.user.is_authenticated:
        return redirect('/dashboard/')
    return redirect('/login/')

@login_required
def halaman_contoh(request):
    return HttpResponse("""
        <h4>Halaman HTMX</h4>
        <p>Ini dimuat tanpa reload 🚀</p>
    """)

@login_required
def dashboard_view(request):
    user = request.user

    menus = get_user_menus(user)

    menu_data = []
    for menu in menus:
        submenus = get_user_submenus(user, menu)
        menu_data.append({
            'menu': menu,
            'submenus': submenus
        })

    context = {
        "menu_data": menu_data,
        "user": user,
    }

    return render(request, "dashboard/index.html", context)