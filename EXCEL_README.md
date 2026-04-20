# 📊 Excel Import/Export System

Sistem umum untuk **upload** dan **download** Excel di semua apps.

## Fitur

✅ **Export ke Excel**
- Download data tabel sebagai file Excel
- Kolom bisa custom atau auto dari model/table
- Styling otomatis (header, border, kolom width)
- Datetime formatting

✅ **Import dari Excel**
- Upload Excel file dengan preview sebelum import
- Validasi otomatis menggunakan Django model validation
- Error reporting detail per row
- Support kolom custom mapping
- Skip empty rows automatically

✅ **Reusable Components**
- Generic views untuk semua model
- Mixin untuk menambah ke existing views
- Bootstrap modal UI
- Async preview dengan error handling

---

## Setup

### 1. Install dependency

```bash
pip install -r requirements.txt
# atau manual:
pip install openpyxl==3.11.0
```

### 2. Include template folder (sudah di template settings)

Template berada di:
- `templates/components/excel/import.html` - Modal import
- `templates/components/excel/buttons.html` - Export/Import buttons

---

## Penggunaan

### A. DOWNLOAD/EXPORT Excel

#### Cara 1: Gunakan ExcelExportView directly

```python
# di umum/urls.py
from django.urls import path
from core.views_excel import ExcelExportView
from umum.models import Pegawai

class PegawaiExportView(ExcelExportView):
    model = Pegawai
    # Optional: custom columns
    # columns = [('nip', 'NIP'), ('nama', 'Nama'), ...]

urlpatterns = [
    path('pegawai/export/', PegawaiExportView.as_view(), name='pegawai-export'),
]
```

#### Cara 2: Pakai ExcelMixin + add button

```python
# di umum/views.py
from core.views_excel import ExcelMixin

class PegawaiListView(ExcelMixin, ListView):
    model = Pegawai
    template_name = 'pages/page.html'
    
    # Optional: custom columns untuk Excel
    excel_columns = [
        ('nip', 'NIP'),
        ('nama', 'Nama Pegawai'),
        ('email', 'Email'),
    ]
```

Di template:

```html
{% include "components/excel/buttons.html" 
   with export_url=export_url 
   import_url=import_url 
   model_name="Pegawai" 
%}
```

---

### B. UPLOAD/IMPORT Excel

#### Step 1: Buat ImportView

```python
# di umum/urls.py
from core.views_excel import ExcelImportView

class PegawaiImportView(ExcelImportView):
    model = Pegawai
    success_url = '/umum/pegawai/'  # Redirect setelah berhasil
    
    # Optional: custom columns mapping
    # columns = ['nip', 'nama', 'email', ...]

urlpatterns = [
    path('pegawai/import/', PegawaiImportView.as_view(), name='pegawai-import'),
]
```

#### Step 2: Add button ke template

```html
{% include "components/excel/buttons.html" 
   with import_url=import_url 
   model_name="Pegawai" 
%}
```

#### Step 3: User workflow

1. Click **Upload Excel** button
2. Select file Excel (.xlsx, .xls, .csv)
3. Click **Preview** - lihat data & validasi
4. Jika ada error, user bisa fix file dan upload lagi
5. Jika valid, click **Import Sekarang**
6. Success → redirect ke list view

---

## Reserved Template Variables

Di views yang pakai `ExcelMixin`, berikut variables tersedia di template context:

```python
context['export_url']   # URL untuk download Excel
context['import_url']   # URL untuk upload modal
```

---

## Customization

### A. Custom Columns untuk Export

**Option 1: Hardcode di view**

```python
class PegawaiExportView(ExcelExportView):
    model = Pegawai
    columns = [
        ('nip', 'NIP'),
        ('nama', 'Nama Pegawai'),
        ('email', 'Email'),
        ('created_at', 'Tanggal Dibuat'),
    ]
```

**Option 2: Auto dari django-tables2**

```python
from core.utils import get_table_columns
from umum.tables import PegawaiTable

class PegawaiExportView(ExcelExportView):
    model = Pegawai
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.columns = get_table_columns(PegawaiTable)
```

### B. Custom Filtering saat Export

```python
class PegawaiExportView(ExcelExportView):
    model = Pegawai
    
    def get_queryset(self):
        # Hanya export active pegawai
        return Pegawai.objects.filter(is_active=True)
```

### C. Custom Validasi saat Import

```python
from core.utils import ExcelImporter

class CustomImporter(ExcelImporter):
    def validate(self, data=None):
        # Call parent
        super().validate(data)
        
        # Add custom validation
        for item in self.preview_data:
            nip = item['data'].get('nip')
            # Check if NIP already exists
            if Pegawai.objects.filter(nip=nip).exists():
                item['errors'].append(f'NIP {nip} sudah ada')
                item['status'] = 'error'
```

---

## Excel Format

### Expected Columns (sesuai dengan model fields)

File Excel harus punya header di row 1 dengan nama field, e.g.:

```
| NIP      | Nama Pegawai    | Email              | ... |
|----------|-----------------|-------------------|-----|
| 123456   | Budi            | budi@example.com   | ... |
| 789012   | Eka             | eka@example.com    | ... |
```

### Validation

Setiap row akan di-validate menggunakan Django model `full_clean()` method.

Error akan di-report per row, e.g.:
- `NIP: This field is required`
- `Email: Enter a valid email address`

---

## API Reference

### ExcelExporter

```python
from core.utils import ExcelExporter

exporter = ExcelExporter(
    model=Pegawai,
    queryset=Pegawai.objects.filter(is_active=True),
    columns=[('nip', 'NIP'), ('nama', 'Nama')],
    title='Data Pegawai'
)

# Get Excel bytes
excel_bytes = exporter.export()

# Save to file
with open('pegawai.xlsx', 'wb') as f:
    f.write(excel_bytes)
```

### ExcelImporter

```python
from core.utils import ExcelImporter

importer = ExcelImporter(
    model=Pegawai,
    file_stream=open('pegawai.xlsx', 'rb'),  # atau bytes
    columns=['nip', 'nama', 'email']
)

# Preview + Validate
importer.validate()
print(importer.preview_data)  # List of rows dengan status
print(importer.errors)  # List of error messages

# Import data
result = importer.import_data()
print(result['success'])      # Boolean
print(result['imported'])     # Jumlah data imported
print(result['errors'])       # List of errors jika ada
```

---

## Error Handling

### Common Errors

1. **"File tidak ditemukan"**
   - Pastikan file dipilih sebelum preview/import

2. **"Error reading Excel: ..."**
   - File Excel corrupt atau format tidak benar
   - Try dengan file Excel baru

3. **"Row X: field_name: This field is required"**
   - Kolom required tidak ada datanya
   - Isi semua required fields

4. **"NIP already exists"**
   - Data sudah ada di database
   - Check spreadsheet untuk duplicate NIP

### Preview Error Messages

Setiap error akan ditampilkan per row di preview modal, sehingga user bisa:
1. Lihat row mana yang error
2. Lihat field mana yang error
3. Download ulang file, fix, dan re-upload

---

## Best Practices

✅ **DO:**
- Provide sample Excel file untuk users
- Clear error messages
- Preview sebelum import
- Keep columns consistent dengan django-tables2 display
- Test import dengan sample data dulu

❌ **DON'T:**
- Change model fields tanpa update Excel mapping
- Trust user input tanpa validation
- Skip preview step untuk critical data
- Export passwords atau sensitive fields

---

## Troubleshooting

### Modal tidak muncul

1. Check di console browser (F12) untuk errors
2. Pastikan Bootstrap 5+ sudah loaded
3. Pastikan `{% include %}` template path benar

### Export file empty

1. Check model punya data
2. Check columns mapping benar
3. Debug di view: `print(exporter.queryset.count())`

### Import gagal tanpa error message

1. Check file format (.xlsx atau .csv)
2. Check column headers sesuai dengan field names
3. Check Django model validations di model.full_clean()

---

## TODO Features

- [ ] Batch import multiple files
- [ ] Scheduled export (email Excel report)
- [ ] Template Excel download (blank file to fill)
- [ ] Column reordering di import preview
- [ ] Map Excel columns to model fields (wizard)

---

Pertanyaan? Check `EXCEL_USAGE_EXAMPLE.py` untuk contoh code.
