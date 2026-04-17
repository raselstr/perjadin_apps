from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from django.contrib.auth.models import User
from django.db import transaction
from django.http import JsonResponse
from types import SimpleNamespace

from core.crud.base import BaseCRUDView
from .models import UserProfile, OPD, Role
from .forms import OPDForm, RoleForm, UserProfileForm, UserWithProfileForm
from .tables import OPDTable, RoleTable, UserProfileTable


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
        return super().get_queryset().order_by('nama')


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
        return super().get_queryset().select_related('user', 'opd', 'role')

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


def create_user_with_profile(request):
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