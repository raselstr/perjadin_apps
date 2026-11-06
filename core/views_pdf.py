"""
Generic view untuk mencetak/PDF data tabel.
Menghasilkan halaman HTML bersih berisi tabel data + judul,
konsisten (kolom & data sama) dengan export Excel.
"""
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied
from django.shortcuts import render
from django.views import View


class GenericPdfTableView(LoginRequiredMixin, View):
    """
    Generic view: render HTML tabel data siap cetak / save-as-PDF.
    Kolom & data sama persis dengan GenericExcelExportView.
    """

    def dispatch(self, request, app_label, model_name, *args, **kwargs):
        if not request.user.is_authenticated:
            raise PermissionDenied

        from django.apps import apps
        self.model = apps.get_model(app_label, model_name)
        self.app_label = app_label
        self.model_name = model_name
        return super(View, self).dispatch(request, *args, **kwargs)

    # ------------------------------------------------------------------ #
    #  Queryset — identik dengan GenericExcelExportView                   #
    # ------------------------------------------------------------------ #
    def get_queryset(self):
        qs = self.model.objects.all()
        user = self.request.user

        if user.is_authenticated and not user.is_superuser:
            from profiles.utils import get_active_opd_id
            active_opd_id = get_active_opd_id(self.request)

            if active_opd_id:
                if hasattr(self.model, 'opd') or hasattr(self.model, 'opd_id'):
                    qs = qs.filter(opd_id=active_opd_id)
                elif hasattr(self.model, 'pelaksana'):
                    qs = qs.filter(pelaksana__nama__opd_id=active_opd_id)

        return qs

    # ------------------------------------------------------------------ #
    #  Kolom — identik dengan ExcelExporter._get_default_columns()        #
    # ------------------------------------------------------------------ #
    def get_columns(self):
        columns = []
        for field in self.model._meta.get_fields():
            if field.one_to_many or field.many_to_many:
                continue
            if getattr(field, 'primary_key', False):
                continue
            if getattr(field, 'auto_now', False) or getattr(field, 'auto_now_add', False):
                continue

            if field.many_to_one:
                field_name = f"{field.name}_id"
                label = f"{getattr(field, 'verbose_name', field.name).title()} (ID)"
            else:
                field_name = field.name
                label = getattr(field, 'verbose_name', field.name).title()

            columns.append((field_name, label))
        return columns

    # ------------------------------------------------------------------ #
    #  Render nilai per sel — identik dengan ExcelExporter.export()       #
    # ------------------------------------------------------------------ #
    def _render_value(self, obj, field_name):
        from decimal import Decimal
        from datetime import date, datetime
        from core.utils.excel_handler import ExcelExporter  # hanya untuk money_keywords

        money_keywords = {"biaya", "tarif", "harga", "total", "uang", "jumlah", "subtotal"}

        # FK → tampilkan label (bukan id)
        if field_name.endswith("_id") and hasattr(obj, field_name[:-3]):
            rel_obj = getattr(obj, field_name[:-3], None)
            return str(rel_obj) if rel_obj is not None else "-"

        value = getattr(obj, field_name, None)

        if value is None:
            return "-"
        if isinstance(value, datetime):
            return value.strftime('%d/%m/%Y %H:%M')
        if isinstance(value, date):
            return value.strftime('%d/%m/%Y')
        if isinstance(value, Decimal):
            # Format ribuan dengan pemisah titik gaya Indonesia
            return f"{value:,.0f}".replace(",", ".")
        if isinstance(value, (int, float)) and any(kw in field_name.lower() for kw in money_keywords):
            return f"{int(value):,}".replace(",", ".")
        return str(value)

    # ------------------------------------------------------------------ #
    #  GET handler                                                         #
    # ------------------------------------------------------------------ #
    def get(self, request, *args, **kwargs):
        qs = self.get_queryset()
        columns = self.get_columns()
        title = self.model._meta.verbose_name_plural.title()

        # Susun data: list of list (per baris)
        rows = []
        for obj in qs:
            row = [self._render_value(obj, field_name) for field_name, _ in columns]
            rows.append(row)

        headers = [label for _, label in columns]

        context = {
            "title": title,
            "headers": headers,
            "rows": rows,
            "total": len(rows),
        }
        return render(request, "components/pdf/table_data.html", context)
