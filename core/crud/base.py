from django.http import HttpResponse, JsonResponse
from django.views.generic import ListView
from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Q
from django_tables2 import RequestConfig
from types import SimpleNamespace


class BaseCRUDView(ListView):
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
    paginate_by = 10

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
        page = self.request.GET.get("page", 1)

        if per_page == "all":
            paginate_config = False
        else:
            try:
                paginate_config = {"per_page": int(per_page)}
            except ValueError:
                paginate_config = {"per_page": 10}

        RequestConfig(self.request, paginate=paginate_config).configure(table)

        context.update({
            "permission": self.get_permission(),
            "table": table,
            "title": self.title,
            "url_list": self.url_list,
            "url_action": self.url_action,
            "url_action_pk": self.url_action_pk,
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
            form.save()

            if request.headers.get("HX-Request"):
                # Return 204 No Content to prevent HTMX from swapping
                # The client will handle modal close and table reload via JavaScript
                from django.http import HttpResponse
                response = HttpResponse(status=204)
                response["HX-Trigger"] = "tableShouldReload"
                return response

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
                # Return 204 No Content to prevent HTMX from swapping
                # The client will handle modal close and table reload via JavaScript
                from django.http import HttpResponse
                response = HttpResponse(status=204)
                response["HX-Trigger"] = "tableShouldReload"
                return response

            return redirect(self.url_list)

        return render(request, "components/crud/delete.html", {
            "object": obj,
            "url_list": self.url_list,
            "title": "Hapus Data"
        })