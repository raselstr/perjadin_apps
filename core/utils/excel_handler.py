"""
Excel utilities untuk import/export data
Digunakan di semua app untuk konsistensi
"""
import io
from datetime import datetime
from openpyxl import Workbook, load_workbook
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from django.db import models
from django.core.exceptions import ValidationError


class ExcelExporter:
    """Export data Django model ke Excel file"""
    
    def __init__(self, model, queryset=None, columns=None, title=None):
        """
        Args:
            model: Django model class
            queryset: QuerySet untuk di-export (default: semua data)
            columns: List field names [(field_name, display_name), ...]
                    Jika None, ambil dari model fields
            title: Judul sheet (default: model name)
        """
        self.model = model
        self.queryset = queryset or model.objects.all()
        self.title = title or model._meta.verbose_name_plural
        self.columns = columns or self._get_default_columns()
    
    def _get_default_columns(self):
        """Get semua field dari model kecuali ManyToMany relations"""
        columns = []
        for field in self.model._meta.get_fields():
            # Skip many-to-many dan one-to-many relations
            if field.one_to_many or field.many_to_many:
                continue
            # Include semua field lainnya, termasuk foreign keys
            label = getattr(field, 'verbose_name', field.name).title()
            columns.append((field.name, label))
        return columns
    
    def export(self):
        """Export ke Excel dan return file bytes"""
        wb = Workbook()
        ws = wb.active
        ws.title = self.title[:31]  # Sheet name max 31 chars
        
        # Header styling
        header_fill = PatternFill(start_color="366092", end_color="366092", fill_type="solid")
        header_font = Font(bold=True, color="FFFFFF")
        header_alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)
        border = Border(
            left=Side(style='thin'),
            right=Side(style='thin'),
            top=Side(style='thin'),
            bottom=Side(style='thin')
        )
        
        # Write headers
        for col_idx, (field_name, display_name) in enumerate(self.columns, 1):
            cell = ws.cell(row=1, column=col_idx)
            cell.value = display_name
            cell.fill = header_fill
            cell.font = header_font
            cell.alignment = header_alignment
            cell.border = border
        
        # Write data
        data_alignment = Alignment(horizontal="left", vertical="center", wrap_text=True)
        
        for row_idx, obj in enumerate(self.queryset, 2):
            for col_idx, (field_name, _) in enumerate(self.columns, 1):
                value = getattr(obj, field_name)
                
                # Format datetime
                if isinstance(value, datetime):
                    value = value.strftime('%d/%m/%Y %H:%M')
                elif isinstance(value, models.Model):
                    value = str(value)
                
                cell = ws.cell(row=row_idx, column=col_idx)
                cell.value = value
                cell.alignment = data_alignment
                cell.border = border
        
        # Auto-adjust column widths
        for col_idx, (_, display_name) in enumerate(self.columns, 1):
            max_length = max(len(str(display_name)), 20)
            ws.column_dimensions[ws.cell(row=1, column=col_idx).column_letter].width = min(max_length + 2, 50)
        
        # Return as bytes
        output = io.BytesIO()
        wb.save(output)
        output.seek(0)
        return output.getvalue()


class ExcelImporter:
    """Import & validasi data dari Excel file"""
    
    def __init__(self, model, file_stream, columns=None, skip_empty_rows=True):
        """
        Args:
            model: Django model untuk import
            file_stream: File object atau bytes
            columns: List field names untuk mapping dengan Excel columns
            skip_empty_rows: Skip baris kosong (default: True)
        """
        self.model = model
        self.file_stream = file_stream
        self.columns = columns or self._get_default_columns()
        self.skip_empty_rows = skip_empty_rows
        self.errors = []
        self.preview_data = []
    
    def _get_default_columns(self):
        """Get field names dari model"""
        fields = []
        for field in self.model._meta.get_fields():
            if not (field.many_to_one or field.one_to_many or field.many_to_many):
                if field.name != 'id':
                    fields.append(field.name)
        return fields
    
    def read_excel(self):
        """Parse Excel file dan return data"""
        try:
            if isinstance(self.file_stream, bytes):
                book = load_workbook(io.BytesIO(self.file_stream))
            else:
                book = load_workbook(self.file_stream)
            
            ws = book.active
            data = []
            
            for row_idx, row in enumerate(ws.iter_rows(min_row=2, values_only=True), 2):
                # Skip empty rows
                if self.skip_empty_rows and all(cell is None for cell in row):
                    continue
                
                row_data = {}
                for col_idx, field_name in enumerate(self.columns):
                    if col_idx < len(row):
                        row_data[field_name] = row[col_idx]
                    else:
                        row_data[field_name] = None
                
                data.append({
                    'row': row_idx,
                    'data': row_data
                })
            
            return data
        
        except Exception as e:
            self.errors.append(f"Error reading Excel: {str(e)}")
            return []
    
    def validate(self, data=None):
        """Validasi data sebelum import"""
        if data is None:
            data = self.read_excel()
        
        self.preview_data = []
        self.errors = []
        
        for item in data:
            row_num = item['row']
            row_data = item['data']
            errors = []
            
            try:
                # Create instance (tanpa save)
                instance = self.model(**row_data)
                instance.full_clean()  # Django validation
                
                self.preview_data.append({
                    'row': row_num,
                    'data': row_data,
                    'status': 'valid',
                    'errors': []
                })
            
            except ValidationError as e:
                error_msg = '; '.join([f"{k}: {', '.join(v)}" for k, v in e.message_dict.items()])
                self.preview_data.append({
                    'row': row_num,
                    'data': row_data,
                    'status': 'error',
                    'errors': [error_msg]
                })
                self.errors.append(f"Row {row_num}: {error_msg}")
            
            except Exception as e:
                self.preview_data.append({
                    'row': row_num,
                    'data': row_data,
                    'status': 'error',
                    'errors': [str(e)]
                })
                self.errors.append(f"Row {row_num}: {str(e)}")
        
        return len(self.errors) == 0
    
    def import_data(self, data=None):
        """Import data ke database (hanya yang valid)"""
        if data is None:
            data = self.read_excel()
        
        if not self.validate(data):
            return {
                'success': False,
                'imported': 0,
                'errors': self.errors,
                'preview': self.preview_data
            }
        
        imported = 0
        try:
            for item in self.preview_data:
                if item['status'] == 'valid':
                    self.model.objects.create(**item['data'])
                    imported += 1
            
            return {
                'success': True,
                'imported': imported,
                'errors': [],
                'preview': self.preview_data
            }
        
        except Exception as e:
            return {
                'success': False,
                'imported': imported,
                'errors': [str(e)],
                'preview': self.preview_data
            }
