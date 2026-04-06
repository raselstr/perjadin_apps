from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login
from django.contrib import messages
from django.db import transaction
from django.contrib.auth.models import User
from .models import UserProfile
from .forms import UserWithProfileForm

def login_view(request):
    # Jika user sudah login, langsung arahkan ke dashboard
    if request.user.is_authenticated:
        return redirect('dashboard')

    if request.method == 'POST':
        username_login = request.POST.get('username')
        password_login = request.POST.get('password')
        tahun_pilihan = request.POST.get('tahun')

        user = authenticate(request, username=username_login, password=password_login)

        if user is not None:
            login(request, user)
            
            # --- LOGIKA SESSION ---
            
            # 1. Simpan Tahun Anggaran ke Session
            request.session['tahun_anggaran'] = tahun_pilihan
            
            # 2. Simpan OPD ke Session
            if user.is_superuser:
                # Jika superuser, OPD diset ke None (Akses Global)
                request.session['session_opd_id'] = None
                request.session['session_opd_nama'] = "Administrator Pusat"
            else:
                # Ambil data OPD dari Profile/UserProfile user
                # Asumsi: user memiliki OneToOne ke model Profile yang memiliki field 'opd'
                try:
                    user_profile = user.userprofile  # Sesuaikan dengan related_name Anda
                    opd = user_profile.opd
                    if opd:
                        request.session['session_opd_id'] = opd.id
                        request.session['session_opd_nama'] = opd.nama
                    else:
                        request.session['session_opd_id'] = None
                except AttributeError:
                    request.session['session_opd_id'] = None
            
            # Tambahkan pesan sukses
            messages.success(request, f"Selamat datang, {user.first_name or user.username}!")
            return redirect('dashboard')
        else:
            # Jika gagal, kirim error (akan ditangkap oleh form.errors di template)
            messages.error(request, "Username atau password salah.")
            return render(request, 'auth/login.html', {'error_message': True})

    return render(request, 'auth/login.html')


# ========================
# LIST
# ========================
def user_list(request):
    data = User.objects.all().select_related('userprofile')

    if request.htmx:
        return render(request, 'auth/partials/user_list.html', {'data': data})

    return render(request, 'auth/user_list.html', {'data': data})


# ========================
# CREATE
# ========================
@transaction.atomic
def user_create(request):
    if request.method == 'POST':
        form = UserWithProfileForm(request.POST)

        if form.is_valid():
            user = User.objects.create_user(
                username=form.cleaned_data['username'],
                password=form.cleaned_data['password'],
                first_name=form.cleaned_data['first_name'],
                last_name=form.cleaned_data['last_name'],
            )

            profile = form.save(commit=False)
            profile.user = user
            profile.save()

            messages.success(request, "User berhasil ditambahkan")
            return redirect('user_list')
    else:
        form = UserWithProfileForm()

    return render(request, 'auth/user_form.html', {'form': form})


# ========================
# UPDATE
# ========================
@transaction.atomic
def user_update(request, id):
    user = get_object_or_404(User, id=id)
    profile, created = UserProfile.objects.get_or_create(user=user)

    if request.method == 'POST':
        form = UserWithProfileForm(request.POST, instance=profile, user_instance=user)

        if form.is_valid():
            user.username = form.cleaned_data['username']
            user.first_name = form.cleaned_data['first_name']
            user.last_name = form.cleaned_data['last_name']

            if form.cleaned_data['password']:
                user.set_password(form.cleaned_data['password'])

            user.save()

            profile = form.save(commit=False)
            profile.user = user
            profile.save()

            messages.success(request, "User berhasil diupdate")
            return redirect('user_list')
    else:
        form = UserWithProfileForm(instance=profile, user_instance=user)

    return render(request, 'auth/user_form.html', {'form': form})


# ========================
# DELETE
# ========================
def user_delete(request, id):
    user = get_object_or_404(User, id=id)
    user.delete()
    messages.success(request, "User berhasil dihapus")
    return redirect('user_list')
