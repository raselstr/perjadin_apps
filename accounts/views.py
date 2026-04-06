from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib import messages

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