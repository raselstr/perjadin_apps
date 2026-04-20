"""
Generic views untuk Excel import/export
Bisa di-inherit di setiap app
"""
from django.http import HttpResponse, JsonResponse
from django.views import View
from django.views.generic import TemplateView
from django.shortcuts import render, redirect
from django.contrib import messages
from django.utils.decorators import method_decorator
from django.views.decorators.http import require_http_methods
from core.utils.excel_handler import ExcelExporter, ExcelImporter


class ExcelExportView(View):
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
        """Handle GET request - download Excel"""
        queryset = self.get_queryset()
        
        exporter = ExcelExporter(
            model=self.model,
            queryset=queryset,
            columns=self.columns,
            title=self.model._meta.verbose_name_plural
        )
        
        excel_data = exporter.export()
        
        response = HttpResponse(
            excel_data,
            content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )
        response['Content-Disposition'] = f'attachment; filename="{self.get_filename()}"'
        
        return response


class ExcelImportView(TemplateView):
    """Generic view untuk upload & import Excel dengan preview"""
    
    model = None
    template_name = 'components/excel/import.html'
    success_url = None
    columns = None  # Jika None, ambil dari model fields
    
    def get_success_url(self):
        """Redirect URL setelah import sukses"""
        if self.success_url:
            return self.success_url
        return self.request.GET.get('next', '/')
    
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['model'] = self.model
        context['model_name'] = self.model._meta.verbose_name_plural
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
                columns=self.columns
            )
            
            # Step 1: Preview
            if action == 'preview':
                data = importer.read_excel()
                importer.validate(data)
                
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
                    messages.success(
                        request,
                        f"✅ Berhasil import {result['imported']} data"
                    )
                    return JsonResponse({
                        'status': 'success',
                        'imported': result['imported'],
                        'redirect': self.get_success_url()
                    })
                else:
                    return JsonResponse({
                        'status': 'error',
                        'errors': result['errors'],
                        'preview': result['preview'],
                        'imported': result['imported']
                    })
        
        except Exception as e:
            return JsonResponse({
                'status': 'error',
                'errors': [str(e)]
            })


class ExcelMixin:
    """Mixin untuk menambah export/import ke CRUD view"""
    
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
        context['export_url'] = self.get_export_url()
        context['import_url'] = self.get_import_url()
        return context
    
    def get_export_url(self):
        """Override untuk set custom export URL"""
        return f"{self.url_list}export/"
    
    def get_import_url(self):
        """Override untuk set custom import URL"""
        return f"{self.url_list}import/"
