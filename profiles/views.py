from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from django.contrib.auth.models import User
from django.utils.http import url_has_allowed_host_and_scheme
from django.urls import reverse
from django.views.decorators.http import require_GET, require_POST
from django.db import transaction
from django.http import HttpResponse, JsonResponse
from types import SimpleNamespace

from core.crud.base import BaseCRUDView
from profiles.utils import filter_queryset_by_active_opd, get_active_opd_id
from umum.models import Pegawai, Pemda
from .models import UserProfile, OPD, Role
from .forms import AccountSettingsForm, OPDForm, RoleForm, UserProfileForm, UserWithProfileForm
from .tables import OPDTable, RoleTable, UserProfileTable


# ========================
# LOGIN
# ========================
def _get_matching_pemda_for_pegawai(pegawai):
    if pegawai.opd_id:
        pemda = Pemda.objects.filter(
            nama_dinas_id=pegawai.opd_id,
            password_standar__gt="",
        ).first()
        if pemda:
            return pemda

    return Pemda.objects.filter(password_standar__gt="").first()


def _authenticate_pegawai_with_standard_password(username, password):
    pegawai = Pegawai.objects.select_related("opd").filter(
        nip=username,
    ).first()

    if not pegawai:
        return None

    pemda = _get_matching_pemda_for_pegawai(pegawai)
    if not pemda or password != pemda.password_standar:
        return None

    user, _ = User.objects.get_or_create(
        username=pegawai.nip,
        defaults={
            "first_name": pegawai.nama[:150],
            "is_active": True,
        },
    )

    if not user.is_active:
        user.is_active = True

    user.first_name = pegawai.nama[:150]
    user.set_password(password)
    user.save()

    role, _ = Role.objects.get_or_create(nama="Pengguna")
    profile, _ = UserProfile.objects.get_or_create(user=user)
    profile.opd = pegawai.opd
    profile.role = role
    profile.save()

    return user


def login_view(request):
    if request.user.is_authenticated:
        return redirect('dashboard')

    next_url = request.POST.get('next') or request.GET.get('next')

    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        tahun = request.POST.get('tahun')

        user = authenticate(request, username=username, password=password)

        if not user:
            user = _authenticate_pegawai_with_standard_password(
                username,
                password,
            )

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
            if next_url and url_has_allowed_host_and_scheme(
                next_url,
                allowed_hosts={request.get_host()},
                require_https=request.is_secure(),
            ):
                return redirect(next_url)
            return redirect('dashboard')

        messages.error(request, "Login gagal")

    return render(request, 'auth/login.html', {
        'next_url': next_url,
        'idle_timeout_minutes': 30,
    })


@require_POST
def logout_view(request):
    logout(request)

    if request.headers.get("HX-Request"):
        response = HttpResponse(status=204)
        response["HX-Redirect"] = "/profiles/masuk/"
        return response

    return redirect('masuk')


@require_GET
def timeout_logout_view(request):
    logout(request)

    target_url = f"{reverse('masuk')}?expired=1"

    if request.headers.get("HX-Request"):
        response = HttpResponse(status=204)
        response["HX-Redirect"] = target_url
        return response

    return redirect(target_url)


@require_GET
@login_required
def session_heartbeat(request):
    return HttpResponse(status=204)


# ========================
# CRUD OPD
# ========================
class OPDView(LoginRequiredMixin, BaseCRUDView):
    model = OPD
    form_class = OPDForm
    table_class = OPDTable

    title = "Daftar OPD"
    url_list = "opd_list"
    url_action = "opd_action"
    url_action_pk = "opd_action_pk"

    def get_queryset(self):
        queryset = super().get_queryset().order_by('nama')
        active_opd_id = get_active_opd_id(self.request)
        if active_opd_id:
            queryset = queryset.filter(pk=active_opd_id)
        return queryset


# ========================
# CRUD USER PROFILE
# ========================
class UserProfileView(LoginRequiredMixin, BaseCRUDView):
    model = UserProfile
    form_class = UserProfileForm
    table_class = UserProfileTable

    title = "Daftar User Profile"
    url_list = "userprofile_list"
    url_action = "userprofile_action"
    url_action_pk = "userprofile_action_pk"

    def get_queryset(self):
        return filter_queryset_by_active_opd(
            super().get_queryset().select_related('user', 'opd', 'role'),
            self.request,
            "opd_id",
        )

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['create_user_url'] = 'create_user_with_profile'
        return context


# ========================
# CRUD ROLE
# ========================
class RoleView(LoginRequiredMixin, BaseCRUDView):
    model = Role
    form_class = RoleForm
    table_class = RoleTable

    title = "Daftar Role"
    url_list = "role_list"
    url_action = "role_action"
    url_action_pk = "role_action_pk"

    def get_queryset(self):
        return super().get_queryset().order_by('nama')


@login_required
def create_user_with_profile(request):
    if not request.user.is_superuser:
        return render(request, "components/crud/403.html", status=403)

    if request.method == 'POST':
        form = UserWithProfileForm(request.POST)
        if form.is_valid():
            try:
                with transaction.atomic():
                    user_profile = form.save()
                    messages.success(request, f"User {user_profile.user.username} berhasil dibuat")
                    if request.headers.get("HX-Request"):
                        response = JsonResponse({"success": True})
                        response["HX-Trigger"] = "formSuccess,reloadTable"
                        return response
                    return redirect('userprofile_list')
            except Exception as e:
                form.add_error(None, f"Gagal membuat user: {str(e)}")
        # If form is not valid or exception occurred, fall through to render form

    else:
        form = UserWithProfileForm()

    context = {
        'form': form,
        'title': 'Tambah User Baru',
        'permission': SimpleNamespace(can_add=True, can_edit=True, can_delete=True, can_view=True),
    }

    if request.headers.get("HX-Request"):
        return render(request, 'components/crud/form.html', context)

    context['url_list'] = 'userprofile_list'
    return render(request, 'pages/page.html', context)


@login_required
def account_settings(request):
    account_form = AccountSettingsForm(user=request.user)
    password_form = PasswordChangeForm(request.user)

    if request.method == "POST":
        action = request.POST.get("action")
        if action == "profile":
            account_form = AccountSettingsForm(
                request.POST,
                request.FILES,
                user=request.user,
            )
            if account_form.is_valid():
                account_form.save()
                messages.success(request, "Profil berhasil diperbarui.")
                return redirect("account_settings")
        elif action == "password":
            password_form = PasswordChangeForm(request.user, request.POST)
            if password_form.is_valid():
                user = password_form.save()
                update_session_auth_hash(request, user)
                messages.success(request, "Password berhasil diganti.")
                return redirect("account_settings")

    for field in password_form.fields.values():
        field.widget.attrs.setdefault("class", "form-control")

    return render(request, "profiles/account_settings.html", {
        "account_form": account_form,
        "password_form": password_form,
        "pegawai": Pegawai.objects.filter(nip=request.user.username).first(),
    })
