import json

from django.contrib import messages
from django.db import models, transaction
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
    template_form = "components/crud/form_general.html"

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

    def _collect_form_errors(self, form, formset=None):
        errors = []

        if form.non_field_errors():
            errors.extend(str(error) for error in form.non_field_errors())

        for field in form:
            for error in field.errors:
                errors.append(f"{field.label}: {error}")

        if formset is not None:
            if formset.non_form_errors():
                errors.extend(str(error) for error in formset.non_form_errors())

            for index, child_form in enumerate(formset.forms, start=1):
                if child_form.non_field_errors():
                    errors.extend(
                        f"Pelaksana {index}: {error}"
                        for error in child_form.non_field_errors()
                    )

                for field in child_form.visible_fields():
                    for error in field.errors:
                        errors.append(
                            f"Pelaksana {index} - {field.label}: {error}"
                        )

        return errors

    def _build_htmx_error_response(self, request, context, form, formset=None):
        response = render(request, self.template_form, context)
        errors = self._collect_form_errors(form, formset)

        response["HX-Trigger"] = json.dumps({
            "crudError": {
                "title": "Validasi gagal",
                "message": (
                    errors[0]
                    if errors else "Periksa kembali data yang diinput."
                ),
                "level": "error",
            },
        })
        return response

    # =========================
    def get_base_queryset(self):
        return self.model.objects.all().order_by('id')

    def get_object_queryset(self):
        return self.get_base_queryset()

    def get_form_kwargs(self, request, instance=None):
        kwargs = {
            "data": request.POST or None,
            "files": request.FILES or None,
            "instance": instance,
        }

        if getattr(self.form_class, "accepts_request", False):
            kwargs["request"] = request

        return kwargs

    def get_formset_kwargs(self, request, instance=None):
        kwargs = {
            "data": request.POST or None,
            "files": request.FILES or None,
            "instance": instance,
        }

        if getattr(self.formset_class.form, "accepts_request", False):
            kwargs["form_kwargs"] = {"request": request}

        return kwargs

    def get_queryset(self):
        qs = self.get_base_queryset()
        raw_search = self.request.GET.get("search")

        if not raw_search:
            return qs

        search = raw_search.strip()
        if not search:
            return qs

        model_fields = {
            field.name: field
            for field in self.model._meta.get_fields()
            if getattr(field, "name", None)
        }
        field_names = set(model_fields.keys())
        filters = Q()

        # 1. Direct text fields on model (CharField, TextField)
        for field in self.model._meta.fields:
            if isinstance(field, (models.CharField, models.TextField)):
                filters |= Q(**{f"{field.name}__icontains": search})

        # 2. Key related lookups for foreign keys and relationships
        related_lookups = {
            'opd': ['opd__nama__icontains'],
            'role': ['role__nama__icontains'],
            'user': [
                'user__username__icontains',
                'user__first_name__icontains',
                'user__last_name__icontains',
                'user__email__icontains',
            ],
            'pangkat': ['pangkat__pangkat__icontains', 'pangkat__golongan__icontains'],
            'eselon': ['eselon__eselon__icontains'],
            'jenis_jabatan': ['jenis_jabatan__nama__icontains'],
            'status': ['status__nama__icontains'],
            'tingkat': ['tingkat__tingkat__icontains'],
            'tingkat_spd': ['tingkat_spd__tingkat__icontains'],
            'tugas': ['tugas__nama__icontains'],
            'penandatangan': ['penandatangan__nama__icontains', 'penandatangan__nip__icontains'],
            'pemda': ['pemda__nama_pemda__icontains', 'pemda__nama_kabupaten__icontains'],
            'nama_dinas': ['nama_dinas__nama__icontains'],
            'kota_tujuan': ['kota_tujuan__lokasi__icontains', 'kota_tujuan__kota__icontains'],
            'kota_asal': ['kota_asal__lokasi__icontains', 'kota_asal__kota__icontains'],
            'lokasi': ['lokasi__lokasi__icontains', 'lokasi__kota__icontains'],
            'tujuan': ['tujuan__lokasi__icontains', 'tujuan__kota__icontains'],
            'lokasi_berangkat': ['lokasi_berangkat__lokasi__icontains'],
            'lokasi_bandara': ['lokasi_bandara__nama__icontains', 'lokasi_bandara__kota__icontains'],
            'tujuan_bandara': ['tujuan_bandara__nama__icontains', 'tujuan_bandara__kota__icontains'],
            'provinsi': ['provinsi__provinsi__icontains'],
            'jenis_kegiatan': ['jenis_kegiatan__nama__icontains'],
            'jenis_spd': ['jenis_spd__nama__icontains'],
            'jenis_transportasi': ['jenis_transportasi__nama__icontains'],
            'dasar_peraturan': [
                'dasar_peraturan__nama_peraturan__icontains',
                'dasar_peraturan__nomor_peraturan__icontains',
            ],
            'menu': ['menu__nama__icontains'],
            'spt': [
                'spt__tempat_tujuan__icontains',
                'spt__berita__icontains',
                'spt__dasar__icontains',
                'spt__kota_tujuan__lokasi__icontains',
                'spt__jenis_kegiatan__nama__icontains',
                'spt__pemberi_tugas__nomor_spt__icontains',
                'spt__pemberi_tugas__nomor_spd__icontains',
                'spt__pemberi_tugas__nama__icontains',
            ],
            'pelaksana': [
                'pelaksana__nama__nama__icontains',
                'pelaksana__nama__nip__icontains',
            ],
            'pemberi_tugas': [
                'pemberi_tugas__nomor_spt__icontains',
                'pemberi_tugas__nomor_spd__icontains',
                'pemberi_tugas__nama__icontains',
                'pemberi_tugas__nip__icontains',
            ],
        }

        def is_relation(field_name):
            field = model_fields.get(field_name)
            return getattr(field, "is_relation", False)

        for rel_name, lookups in related_lookups.items():
            if rel_name in field_names and is_relation(rel_name):
                for lookup in lookups:
                    try:
                        filters |= Q(**{lookup: search})
                    except Exception:
                        pass

        # 3. Model-specific reverse/special lookups
        model_name = getattr(self.model, '__name__', '')
        if model_name == "Spt":
            filters |= (
                Q(pelaksana__nama__nama__icontains=search) |
                Q(pelaksana__nama__nip__icontains=search) |
                Q(pemberi_tugas__nomor_spt__icontains=search) |
                Q(pemberi_tugas__nomor_spd__icontains=search) |
                Q(kota_tujuan__lokasi__icontains=search) |
                Q(jenis_kegiatan__nama__icontains=search)
            )

        # 4. Money/numeric fields
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
            qs = qs.filter(filters).distinct()

        return qs

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        qs = self.get_queryset()  # Don't convert to list - use QuerySet for pagination

        table = self.table_class(qs, request=self.request)
        table.extra_context = {
            'url_list': self.url_list,
        }

        per_page = self.request.GET.get("per_page", 10)
        normalized_per_page = 25 if per_page == "all" else per_page

        try:
            paginate_config = {
                "per_page": int(normalized_per_page),
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

        perm = self.get_permission()
        if not perm or not perm.can_view:
            return self._forbidden(request)

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
            instance = get_object_or_404(
                self.get_object_queryset(),
                pk=pk,
            )

        form = self.form_class(
            **self.get_form_kwargs(request, instance=instance)
        )

        if request.method == "POST" and form.is_valid():
            action = "update" if instance else "add"
            form.save()

            if request.headers.get("HX-Request"):
                return self._build_htmx_success_response(action)

            self._add_success_message(request, action)
            return redirect(self.url_list)

        context = {
            "form": form,
            "title": self.title,
            "permission": perm,
            "is_multipart_form": form.is_multipart(),
        }

        if request.method == "POST" and request.headers.get("HX-Request"):
            return self._build_htmx_error_response(
                request,
                context,
                form,
            )

        return render(request, self.template_form, context)

    # =========================
    # DELETE
    # =========================
    def delete_view(self, request, pk):
        perm = self.get_permission()

        if not perm or not perm.can_delete:
            return self._forbidden(request)

        obj = get_object_or_404(
            self.get_object_queryset(),
            pk=pk,
        )

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

class BaseMasterDetailCRUDView(BaseCRUDView):
    """
    Base CRUD untuk Parent + Child (Master Detail)

    Contoh:
    - SPT + Pelaksana
    - SPD + Rincian
    - Invoice + Items
    - Surat + Lampiran
    """

    # khusus override template form saja
    template_form = "components/crud/form_master_detail.html"

    # wajib diisi di child view
    formset_class = None

    def form_view(self, request, pk=None):
        perm = self.get_permission()

        # =========================
        # Permission Check
        # =========================
        if pk:
            if not perm or not perm.can_edit:
                return self._forbidden(request)
        else:
            if not perm or not perm.can_add:
                return self._forbidden(request)

        # =========================
        # Ambil instance parent
        # =========================
        instance = None
        if pk:
            instance = get_object_or_404(
                self.get_object_queryset(),
                pk=pk
            )

        # safety check
        if not self.formset_class:
            raise ValueError(
                "formset_class harus diisi pada BaseMasterDetailCRUDView"
            )

        # =========================
        # Parent Form
        # =========================
        form = self.form_class(
            **self.get_form_kwargs(request, instance=instance)
        )

        # =========================
        # Child Formset
        # =========================
        formset = self.formset_class(
            **self.get_formset_kwargs(request, instance=instance)
        )

        # =========================
        # SAVE
        # =========================
        if request.method == "POST":
            if form.is_valid() and formset.is_valid():
                with transaction.atomic():
                    # simpan parent dulu
                    parent = form.save()

                    # kaitkan child ke parent
                    formset.instance = parent
                    formset.save()

                action = "update" if instance else "add"

                # HTMX response
                if request.headers.get("HX-Request"):
                    return self._build_htmx_success_response(action)

                # normal response
                self._add_success_message(request, action)
                return redirect(self.url_list)

        # =========================
        # Render Form
        # =========================
        context = {
            "form": form,
            "formset": formset,
            "title": self.title,
            "permission": perm,
            "url_list": self.url_list,
            "is_multipart_form": (
                form.is_multipart() or formset.is_multipart()
            ),
        }

        if request.method == "POST" and request.headers.get("HX-Request"):
            return self._build_htmx_error_response(
                request,
                context,
                form,
                formset=formset,
            )

        return render(request, self.template_form, context)
