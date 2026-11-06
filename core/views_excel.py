"""
Generic views untuk Excel import/export
Bisa di-inherit di setiap app
"""
from django.http import HttpResponse, JsonResponse
from django.views import View
from django.views.generic import TemplateView
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import PermissionDenied
from django.utils.decorators import method_decorator
from django.views.decorators.http import require_http_methods
from core.utils.excel_handler import ExcelExporter, ExcelImporter


class ExcelPermissionMixin(LoginRequiredMixin):
    permission_action = "can_view"

    def get_permission_url_name(self):
        url_name = getattr(self.request.resolver_match, "url_name", "") or ""
        for suffix in ("_export", "_import"):
            if url_name.endswith(suffix):
                return f"{url_name[:-len(suffix)]}_list"
        return url_name

    def has_excel_permission(self):
        user = self.request.user
        if user.is_superuser:
            return True

        from menus.models import RolePermission, SubMenu
        from profiles.models import UserProfile

        url_name = self.get_permission_url_name()
        try:
            profile = UserProfile.objects.select_related("role").get(user=user)
            submenu = SubMenu.objects.get(url=url_name)
        except (UserProfile.DoesNotExist, SubMenu.DoesNotExist):
            return False

        permission = RolePermission.objects.filter(
            role=profile.role,
            submenu=submenu,
        ).first()
        return bool(
            permission
            and getattr(permission, self.permission_action, False)
        )

    def dispatch(self, request, *args, **kwargs):
        self.request = request
        if not getattr(request, 'user', None) or not request.user.is_authenticated:
            raise PermissionDenied
        if not self.has_excel_permission():
            raise PermissionDenied
        return super().dispatch(request, *args, **kwargs)


class ExcelExportView(ExcelPermissionMixin, View):
    """Generic view untuk download data sebagai Excel"""
    
    model = None
    filename_pattern = "{model}_{timestamp}.xlsx"
    columns = None  # Jika None, ambil dari model fields
    
    def get_filename(self):
        """Generate nama file"""
        from datetime import datetime
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        model_name = self.model._meta.model_name
        return self.filename_pattern.format(model=model_name, timestamp=timestamp)
    
    def get_queryset(self):
        """Override untuk custom filtering"""
        return self.model.objects.all()
    
    def get(self, request, *args, **kwargs):
        """Handle GET request - langsung download Excel dengan semua kolom"""
        return self.download_view(request)
    
    def form_view(self, request):
        """Tampilkan form untuk memilih opsi export"""
        fields = []
        for field in self.model._meta.get_fields():
            if not field.is_relation and not field.many_to_many:
                fields.append({
                    'name': field.name,
                    'verbose_name': field.verbose_name,
                    'selected': True  # Default semua selected
                })
        
        return render(request, 'components/excel/export.html', {
            'model_name': self.model._meta.verbose_name_plural,
            'fields': fields,
        })
    
    def download_view(self, request):
        """Download Excel dengan opsi yang dipilih"""
        queryset = self.get_queryset()
        
        # Filter berdasarkan search / q
        q = request.GET.get('q') or request.GET.get('search')
        if q:
            # Simple search, bisa di-override
            search_fields = []
            for field in self.model._meta.get_fields():
                if not field.is_relation and not field.many_to_many and field.__class__.__name__ in ['CharField', 'TextField']:
                    search_fields.append(f"{field.name}__icontains")
            if search_fields:
                from django.db.models import Q
                query = Q()
                for field in search_fields:
                    query |= Q(**{field: q})
                queryset = queryset.filter(query)
        
        # Pilih kolom
        columns = request.GET.getlist('columns')
        if not columns:
            columns = None  # Semua kolom
        
        exporter = ExcelExporter(
            model=self.model,
            queryset=queryset,
            columns=columns,
            title=self.model._meta.verbose_name_plural
        )
        
        excel_data = exporter.export()
        
        response = HttpResponse(
            excel_data,
            content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
        response['Content-Disposition'] = f'attachment; filename="{self.get_filename()}"'
        
        return response


class ExcelImportView(ExcelPermissionMixin, TemplateView):
    """Generic view untuk upload & import Excel dengan preview"""
    
    model = None
    template_name = 'components/excel/import.html'
    success_url = None
    columns = None  # Jika None, ambil dari model fields
    match_fields = None
    permission_action = "can_add"
    
    def _get_default_columns(self):
        """Get default columns dari model"""
        from core.utils.excel_handler import ExcelImporter
        importer = ExcelImporter(model=self.model, file_stream=b'')
        return importer._get_default_columns()
    
    def get_success_url(self):
        """Redirect URL setelah import sukses"""
        if self.success_url:
            return self.success_url
        return self.request.GET.get('next', '/')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['model'] = self.model
        context['model_name'] = self.model._meta.verbose_name_plural
        context['columns'] = self.columns or self._get_default_columns()
        context['import_url'] = self.request.get_full_path()
        return context
    
    def post(self, request, *args, **kwargs):
        """Handle POST - process uploaded file"""
        action = request.POST.get('action')
        
        if 'file' not in request.FILES:
            return JsonResponse({'error': 'File tidak ditemukan'}, status=400)
        
        file = request.FILES['file']
        
        try:
            importer = ExcelImporter(
                model=self.model,
                file_stream=file.read(),
                columns=self.columns,
                match_fields=self.match_fields,
                filename=file.name,
            )
            
            # Step 1: Preview
            if action == 'preview':
                data = importer.read_excel()
                importer.validate(data)

                if importer.read_errors or importer.empty_file_error:
                    return JsonResponse({
                        'status': 'error',
                        'errors': importer.errors,
                    }, status=400)
                
                return JsonResponse({
                    'status': 'preview',
                    'preview': importer.preview_data,
                    'has_errors': len(importer.errors) > 0,
                    'errors': importer.errors
                })
            
            # Step 2: Import
            elif action == 'import':
                result = importer.import_data()
                
                if result['success']:
                    message_parts = [f"{result['imported']} data ditambahkan"]
                    if result.get('updated'):
                        message_parts.append(f"{result['updated']} data diperbarui")
                    if result.get('skipped'):
                        message_parts.append(f"{result['skipped']} data dilewati")

                    success_message = "✅ Proses import selesai: " + ', '.join(message_parts)

                    messages.success(
                        request,
                        success_message
                    )
                    return JsonResponse({
                        'status': 'success',
                        'imported': result['imported'],
                        'updated': result['updated'],
                        'skipped': result.get('skipped', 0),
                        'redirect': self.get_success_url()
                    })
                else:
                    return JsonResponse({
                        'status': 'error',
                        'errors': result['errors'],
                        'preview': result['preview'],
                        'imported': result['imported'],
                        'updated': result.get('updated', 0),
                        'skipped': result.get('skipped', 0),
                    })
        
        except Exception as e:
            return JsonResponse({
                'status': 'error',
                'errors': [str(e)]
            })


class GenericExcelExportView(ExcelExportView):
    """Generic view untuk export berdasarkan app.model"""

    def has_excel_permission(self):
        user = self.request.user
        return bool(user and user.is_authenticated)

    def get_queryset(self):
        qs = super().get_queryset()
        user = self.request.user
        if not user.is_authenticated or user.is_superuser:
            return qs

        from profiles.utils import get_active_opd_id
        active_opd_id = get_active_opd_id(self.request)

        if active_opd_id:
            if hasattr(self.model, 'opd') or hasattr(self.model, 'opd_id'):
                qs = qs.filter(opd_id=active_opd_id)
            elif hasattr(self.model, 'pelaksana'):
                qs = qs.filter(pelaksana__nama__opd_id=active_opd_id).distinct()

        return qs

    def dispatch(self, request, app_label, model_name, *args, **kwargs):
        self.request = request
        if not request.user.is_authenticated:
            raise PermissionDenied
        # Set model dynamically
        from django.apps import apps
        self.model = apps.get_model(app_label, model_name)
        return super(ExcelPermissionMixin, self).dispatch(request, *args, **kwargs)


class GenericExcelImportView(ExcelImportView):
    """Generic view untuk import berdasarkan app.model"""
    
    def dispatch(self, request, app_label, model_name, *args, **kwargs):
        if not request.user.is_superuser:
            raise PermissionDenied
        # Set model dynamically
        from django.apps import apps
        self.model = apps.get_model(app_label, model_name)
        return super().dispatch(request, *args, **kwargs)


class ExcelMixin:
    """Mixin untuk menambah export/import ke CRUD view"""
    
    enable_excel = True
    excel_columns = None  # Custom columns untuk Excel
    
    def get_excel_columns(self):
        """Override untuk custom columns"""
        return self.excel_columns
    
    def get_export_queryset(self):
        """Override untuk custom filtering saat export"""
        return self.get_queryset()
    
    def get_context_data(self, **kwargs):
        """Add excel URLs ke context"""
        context = super().get_context_data(**kwargs)

        if not self.enable_excel:
            context['export_url'] = None
            context['import_url'] = None
            context['pdf_table_url'] = None
            return context

        context['export_url'] = self.get_export_url()
        context['import_url'] = self.get_import_url()
        context['pdf_table_url'] = self.get_pdf_table_url()
        return context
    
    def get_export_url(self):
        """Override untuk set custom export URL"""
        if hasattr(self, 'url_export') and self.url_export:
            from django.urls import reverse
            return reverse(self.url_export)
        # Fallback to generic URL
        from django.urls import reverse
        app_label = self.model._meta.app_label
        model_name = self.model._meta.model_name
        return reverse('core:generic_excel_export', kwargs={'app_label': app_label, 'model_name': model_name})
    
    def get_import_url(self):
        """Override untuk set custom import URL"""
        if hasattr(self, 'url_import') and self.url_import:
            from django.urls import reverse
            return reverse(self.url_import)
        # Fallback to generic URL
        from django.urls import reverse
        app_label = self.model._meta.app_label
        model_name = self.model._meta.model_name
        return reverse('core:generic_excel_import', kwargs={'app_label': app_label, 'model_name': model_name})

    def get_pdf_table_url(self):
        """URL ke halaman cetak tabel (konsisten kolom & data dengan Excel)"""
        from django.urls import reverse
        app_label = self.model._meta.app_label
        model_name = self.model._meta.model_name
        return reverse('core:generic_pdf_table', kwargs={'app_label': app_label, 'model_name': model_name})


class TableDataExcelExportView(View):
    """
    Ekspor langsung dari data tabel yang ditampilkan di halaman (DOM).
    Menerima POST dengan parameter title, headers (JSON), dan rows (JSON).
    Menghasilkan file Excel (.xlsx) dengan styling identitas visual Kabupaten Asahan.
    """
    def post(self, request, *args, **kwargs):
        if not getattr(request, 'user', None) or not request.user.is_authenticated:
            raise PermissionDenied

        import io
        import json
        import re
        from openpyxl import Workbook
        from openpyxl.styles import Alignment, Border, Font, PatternFill, Side

        title = request.POST.get('title') or "Data Tabel"
        headers_raw = request.POST.get('headers') or "[]"
        rows_raw = request.POST.get('rows') or "[]"

        try:
            headers = json.loads(headers_raw)
            rows = json.loads(rows_raw)
        except Exception:
            headers = []
            rows = []

        clean_title = re.sub(r'[*?:/\\\[\]]', '-', str(title))[:31].strip() or "Sheet1"
        safe_filename = re.sub(r'[^\w\s-]', '', str(title)).strip().replace(' ', '_') or "data_tabel"

        wb = Workbook()
        ws = wb.active
        ws.title = clean_title

        # Header styling: Hijau Zamrud (Emerald #065F46) dengan aksen garis emas (#D97706)
        header_fill = PatternFill(start_color="065F46", end_color="065F46", fill_type="solid")
        header_font = Font(name="Arial", size=10, bold=True, color="FFFFFF")
        header_alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
        header_border = Border(
            left=Side(style='thin', color="064E3B"),
            right=Side(style='thin', color="064E3B"),
            top=Side(style='thin', color="064E3B"),
            bottom=Side(style='medium', color="D97706")
        )

        ws.row_dimensions[1].height = 26
        for col_idx, col_name in enumerate(headers, 1):
            cell = ws.cell(row=1, column=col_idx)
            cell.value = str(col_name).strip()
            cell.fill = header_fill
            cell.font = header_font
            cell.alignment = header_alignment
            cell.border = header_border

        even_fill = PatternFill(start_color="F4FAF6", end_color="F4FAF6", fill_type="solid")
        odd_fill = PatternFill(start_color="FFFFFF", end_color="FFFFFF", fill_type="solid")
        data_font = Font(name="Arial", size=9, color="0F172A")
        cell_border = Border(
            left=Side(style='thin', color="E2E8F0"),
            right=Side(style='thin', color="E2E8F0"),
            top=Side(style='thin', color="E2E8F0"),
            bottom=Side(style='thin', color="E2E8F0")
        )
        align_left = Alignment(horizontal="left", vertical="center", wrap_text=True)
        align_center = Alignment(horizontal="center", vertical="center")

        for row_idx, row_data in enumerate(rows, 2):
            ws.row_dimensions[row_idx].height = 20
            row_fill = even_fill if row_idx % 2 == 0 else odd_fill

            for col_idx, cell_value in enumerate(row_data, 1):
                cell = ws.cell(row=row_idx, column=col_idx)
                cell.fill = row_fill
                cell.font = data_font
                cell.border = cell_border

                val_str = str(cell_value).strip() if cell_value is not None else ""
                # Kolom pertama (No) di-center
                if col_idx == 1 and val_str.isdigit() and len(val_str) <= 6:
                    cell.value = int(val_str)
                    cell.alignment = align_center
                else:
                    cell.value = val_str
                    cell.alignment = align_left

        # Auto-adjust column widths
        for col_idx in range(1, len(headers) + 1):
            col_letter = ws.cell(row=1, column=col_idx).column_letter
            max_len = len(str(headers[col_idx - 1])) if col_idx <= len(headers) else 10
            for row in range(2, min(ws.max_row + 1, 60)):
                v = ws.cell(row=row, column=col_idx).value
                if v:
                    max_len = max(max_len, len(str(v).split('\n')[0]))
            ws.column_dimensions[col_letter].width = min(max(max_len + 4, 10), 55)

        ws.freeze_panes = "A2"
        if ws.max_row > 1 and ws.max_column > 0:
            ws.auto_filter.ref = ws.dimensions

        output = io.BytesIO()
        wb.save(output)
        output.seek(0)

        response = HttpResponse(
            output.getvalue(),
            content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
        from datetime import datetime
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        response['Content-Disposition'] = f'attachment; filename="{safe_filename}_{timestamp}.xlsx"'
        return response
