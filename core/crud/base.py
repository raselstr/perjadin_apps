import json

from django.contrib import messages
from django.db import models
from django.http import HttpResponse, JsonResponse
from django.views.generic import ListView
from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Q
from django_tables2 import RequestConfig
from types import SimpleNamespace
from core.views_excel import ExcelMixin
from core.utils.formatting import is_money_identifier, parse_localized_decimal


class BaseCRUDView(ExcelMixin, ListView):
    model = None
    form_class = None
    table_class = None
    template_name = "pages/page.html"
    template_list = "components/crud/list.html"
    template_form = "components/crud/form.html"

    title = ""

    url_list = None
    url_action = None
    url_action_pk = None
    url_import = None
    url_export = None
    paginate_by = None

    # =========================
    # 🔥 PERMISSION
    # =========================
    def get_permission(self):
        from menus.models import RolePermission, SubMenu
        from profiles.models import UserProfile

        user = self.request.user

        if not user.is_authenticated:
            return None

        if user.is_superuser:
            return SimpleNamespace(
                can_view=True,
                can_add=True,
                can_edit=True,
                can_delete=True
            )

        try:
            profile = UserProfile.objects.get(user=user)
        except UserProfile.DoesNotExist:
            return None

        try:
            submenu = SubMenu.objects.get(url=self.url_list)
        except SubMenu.DoesNotExist:
            return None

        return RolePermission.objects.filter(
            role=profile.role,
            submenu=submenu
        ).first()

    # 🔥 helper biar konsisten (HTMX vs normal)
    def _forbidden(self, request):
        if request.headers.get("HX-Request"):
            response = render(request, "components/crud/403.html", status=403)
            response["HX-Retarget"] = "#modal-body"
            response["HX-Reswap"] = "innerHTML"
            return response
        return render(request, "components/crud/403.html", status=403)

    def _get_success_notification(self, action):
        action_labels = {
            "add": "ditambahkan",
            "update": "diperbarui",
            "delete": "dihapus",
        }
        model_name = self.model._meta.verbose_name

        return {
            "title": "Berhasil",
            "message": f"Data {model_name} berhasil {action_labels[action]}.",
            "level": "success",
            "action": action,
        }

    def _add_success_message(self, request, action):
        notification = self._get_success_notification(action)
        messages.success(request, notification["message"])

    def _build_htmx_success_response(self, action):
        response = HttpResponse(status=204)
        response["HX-Trigger"] = json.dumps({
            "crudSuccess": self._get_success_notification(action),
        })
        return response

    # =========================
    def get_queryset(self):
        qs = self.model.objects.all().order_by('id')
        search = self.request.GET.get("search")

        if not search:
            return qs

        field_names = {field.name for field in self.model._meta.get_fields()}
        filters = Q()

        if 'nama' in field_names:
            filters |= Q(nama__icontains=search)
        if 'nip' in field_names:
            filters |= Q(nip__icontains=search)
        if 'jabatan' in field_names:
            filters |= Q(jabatan__icontains=search)
        if 'jenis_jabatan' in field_names:
            filters |= Q(jenis_jabatan__nama__icontains=search)
        if 'tugas' in field_names:
            filters |= Q(tugas__icontains=search)
        if 'url' in field_names:
            filters |= Q(url__icontains=search)
        if 'menu' in field_names:
            filters |= Q(menu__nama__icontains=search)
        if 'icon' in field_names:
            filters |= Q(icon__icontains=search)
        if 'lokasi' in field_names:
            filters |= Q(lokasi__icontains=search)
        if 'kota' in field_names:
            filters |= Q(kota__icontains=search)
        if 'jenis_spd' in field_names:
            filters |= Q(jenis_spd__nama__icontains=search)
        if 'jenis_kegiatan' in field_names:
            filters |= Q(jenis_kegiatan__nama__icontains=search)
        if 'jenis_transportasi' in field_names:
            filters |= Q(jenis_transportasi__nama__icontains=search)
        money_field_types = (
            models.DecimalField,
            models.FloatField,
            models.IntegerField,
            models.BigIntegerField,
            models.PositiveBigIntegerField,
            models.PositiveIntegerField,
            models.PositiveSmallIntegerField,
            models.SmallIntegerField,
        )
        money_field_names = [
            field.name
            for field in self.model._meta.fields
            if isinstance(field, money_field_types) and is_money_identifier(field.name)
        ]

        if money_field_names:
            try:
                money_value = parse_localized_decimal(search)
                for field_name in money_field_names:
                    filters |= Q(**{field_name: money_value})
            except (TypeError, ValueError):
                pass
        

        if filters:
            qs = qs.filter(filters)

        return qs

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        qs = self.get_queryset()  # Don't convert to list - use QuerySet for pagination

        table = self.table_class(qs, request=self.request)
        table.extra_context = {
            'url_list': self.url_list,
        }

        per_page = self.request.GET.get("per_page", 10)

        if per_page == "all":
            paginate_config = False
        else:
            try:
                paginate_config = {
                    "per_page": int(per_page),
                    "silent": True,
                }
            except ValueError:
                paginate_config = {
                    "per_page": 10,
                    "silent": True,
                }

        RequestConfig(self.request, paginate=paginate_config).configure(table)

        context.update({
            "permission": self.get_permission(),
            "table": table,
            "title": self.title,
            "url_list": self.url_list,
            "url_action": self.url_action,
            "url_action_pk": self.url_action_pk,
            "url_import": self.url_import,
            "url_export": self.url_export,
            "initial_url": self.url_list,
        })

        return context

    def get_template_names(self):
        if self.request.headers.get("HX-Request"):
            return [self.template_list]
        return [self.template_name]

    def dispatch(self, request, *args, **kwargs):
        pk = kwargs.get("pk")

        if pk and "delete" in request.path:
            return self.delete_view(request, pk)

        if pk and "form" in request.path:
            return self.form_view(request, pk)

        if "form" in request.path:
            return self.form_view(request)

        return super().dispatch(request, *args, **kwargs)

    def list_view(self, request):
        qs = self.get_queryset()
        table = self.table_class(qs, request=request)

        return render(request, self.template_list, {
            "table": table,
            "url_list": self.url_list,
        })

    # =========================
    # CREATE / UPDATE
    # =========================
    def form_view(self, request, pk=None):
        perm = self.get_permission()

        # 🔥 PERMISSION CHECK
        if pk:
            if not perm or not perm.can_edit:
                return self._forbidden(request)
        else:
            if not perm or not perm.can_add:
                return self._forbidden(request)

        instance = None
        if pk:
            instance = get_object_or_404(self.model, pk=pk)

        form = self.form_class(request.POST or None, instance=instance)

        if request.method == "POST" and form.is_valid():
            action = "update" if instance else "add"
            form.save()

            if request.headers.get("HX-Request"):
                return self._build_htmx_success_response(action)

            self._add_success_message(request, action)
            return redirect(self.url_list)

        return render(request, self.template_form, {
            "form": form,
            "title": self.title,
            "permission": perm
        })

    # =========================
    # DELETE
    # =========================
    def delete_view(self, request, pk):
        perm = self.get_permission()

        if not perm or not perm.can_delete:
            return self._forbidden(request)

        obj = get_object_or_404(self.model, pk=pk)

        if request.method == "POST":
            obj.delete()

            if request.headers.get("HX-Request"):
                return self._build_htmx_success_response("delete")

            self._add_success_message(request, "delete")
            return redirect(self.url_list)

        return render(request, "components/crud/delete.html", {
            "object": obj,
            "url_list": self.url_list,
            "title": "Hapus Data"
        })
