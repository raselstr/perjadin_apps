from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login

from django.contrib import messages
from django.contrib.auth.models import User
from django.db import transaction

from .models import UserProfile, OPD, Role


# ========================
# LOGIN
# ========================
def login_view(request):
    if request.user.is_authenticated:
        return redirect('dashboard')

    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        tahun = request.POST.get('tahun')

        user = authenticate(request, username=username, password=password)

        if user:
            login(request, user)

            request.session['tahun_anggaran'] = tahun

            if user.is_superuser:
                request.session['session_opd_id'] = None
                request.session['session_opd_nama'] = "Administrator Pusat"
            else:
                try:
                    opd = user.userprofile.opd
                    request.session['session_opd_id'] = opd.id if opd else None
                    request.session['session_opd_nama'] = opd.nama if opd else "-"
                except:
                    request.session['session_opd_id'] = None

            messages.success(request, f"Selamat datang {user.username}")
            return redirect('dashboard')

        messages.error(request, "Login gagal")

    return render(request, 'auth/login.html')