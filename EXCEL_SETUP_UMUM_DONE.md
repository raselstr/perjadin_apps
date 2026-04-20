# ✅ Excel System Ready untuk UMUM App!

## Apa yang sudah dibuat:

### 1️⃣ Views (`umum/views.py`)
✅ `PegawaiExportView` - Download Pegawai→Excel  
✅ `PegawaiImportView` - Upload Excel→Pegawai with preview & validation  
✅ `PangkatExportView` / `PangkatImportView`  
✅ `JenisJabatanExportView` / `JenisJabatanImportView`  
✅ `StatusASNExportView` / `StatusASNImportView`  
✅ `PenandatanganExportView` / `PenandatanganImportView`  

### 2️⃣ URLs (`umum/urls.py`)
✅ `/umum/pegawai/export/` - Download as Excel  
✅ `/umum/pegawai/import/` - Upload Excel modal  
✅ Similar URLs untuk semua model (Pangkat, JenisJabatan, StatusASN, Penandatangan)

### 3️⃣ Templates
✅ `templates/umum/components/pegawai_excel_buttons.html` - Example buttons

---

## 🚀 Cara Gunakan

### **A. DOWNLOAD Pegawai ke Excel**

Buka di browser:
```
http://127.0.0.1:8000/umum/pegawai/export/
```

Atau click link:
```html
<a href="{% url 'pegawai_export' %}" class="btn btn-primary">
  📥 Download Excel
</a>
```

✅ Auto-download file: `pegawai_20260419_120000.xlsx`

---

### **B. UPLOAD Excel ke Pegawai**

#### Step 1: Click button untuk buka modal
```html
<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#excelImportModal">
  📤 Upload Excel
</button>
```

#### Step 2: Select file Excel & click **Preview**
- Lihat data preview
- Lihat error messages per row (jika ada)
- Validasi menggunakan Django model validation

#### Step 3: Click **Import Sekarang** (jika valid)
- Import ke database
- Redirect ke `/umum/pegawai/`
- Success message ✅

---

## 📋 Excel Format

### Expected file format:

File Excel harus punya header di row 1:

```
| NIP      | Nama Pegawai    | Email              | No HP     | Jenis Jabatan | Pangkat  | Status ASN |
|----------|-----------------|--------------------|-----------|-----------   |----------|------------|
| 123456   | Budi Santoso    | budi@example.com   | 08123456  | Naker     | II/c     | PNS        |
| 789012   | Eka Putri       | eka@example.com    | 08987654  | Admin     | III/a    | PPPK       |
```

### Columns mapping:
- `NIP` → nip
- `Nama Pegawai` → nama  
- `Email` → email
- `No HP` → no_hp
- `Jenis Jabatan` → jenis_jabatan
- `Pangkat` → pangkat
- `Status ASN` → status

---

## ⚙️ Konfigurasi Per Model

Setiap model punya rincian column mapping di `umum/views.py`:

### **PegawaiExportView**
```python
columns = [
    ('nip', 'NIP'),
    ('nama', 'Nama Pegawai'),
    ('email', 'Email'),
    # ... dll
]
```

### **PegawaiImportView**
```python
columns = ['nip', 'nama', 'email', 'no_hp', 'jenis_jabatan', 'pangkat', 'status']
```

---

## 🔧 Advanced: Integrate ke Pegawai List View

### Option 1: Langsung add buttons ke page layout

Di mana pun template menampilkan table Pegawai, tambahkan sebelum table:

```html
{% block excel_buttons %}
  <div class="mb-3 d-flex gap-2">
    <a href="{% url 'pegawai_export' %}" class="btn btn-sm btn-outline-primary">
      📥 Download Excel
    </a>
    <button type="button" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#excelImportModal">
      📤 Upload Excel
    </button>
  </div>
  {% include "components/excel/import.html" with model_name="Pegawai" %}
{% endblock %}
```

### Option 2: Include snippet template

```html
{% include "umum/components/pegawai_excel_buttons.html" %}
```

---

## 📊 Features

✅ Export ke Excel dengan:
- Professional styling (header color, borders)
- Auto-adjust column widths
- Datetime formatting
- Filtered/sorted data

✅ Import dari Excel dengan:
- Preview sebelum import
- Validasi automatic menggunakan Django model validation
- Error reporting detail per row
- Skip empty rows
- Async preview

✅ Generic system:
- Reusable untuk semua model
- Type-safe dengan Django ORM
- Error handling comprehensive

---

## 🆘 Troubleshooting

### **Download Excel kosong?**
- Check apakah model punya data: `Pegawai.objects.count()`
- Check queryset di view bukan `.none()`

### **"File format error" saat upload?**
- Pastikan file format: .xlsx atau .csv
- Header harus sesuai exact field names
- Jangan ada merged cells di header

### **Error: "Field required"?**
- Check model field `blank=False`
- Pastikan semua required fields ada di Excel file

### **Import ada error tapi tidak bisa import?**
- Preview akan menunjukkan exact field error per row
- Fix data di Excel → re-upload

---

## 🎯 Roadmap

Untuk app lain (menus, profiles, dashboard, core):

1. **Create ExportView & ImportView classes** di `app/views.py`
2. **Add URLs** di `app/urls.py`  
3. **Add buttons** ke template list view
4. **Test**!

Template:
```python
class ModelExportView(ExcelExportView):
    model = YourModel
    columns = [('field1', 'Header 1'), ('field2', 'Header 2')]

class ModelImportView(ExcelImportView):
    model = YourModel
    success_url = '/path/to/list/'
    columns = ['field1', 'field2']
```

---

## 📝 Catatan

- All files sudah created + integrated ke umum app
- Ready to use tanpa setup tambahan
- Dependency (`openpyxl`) sudah di `requirements.txt`
- Generic components bisa di-reuse untuk app lain

**Next: Test download & upload untuk memastikan semuanya working!**

Test URLs:
- Download: http://127.0.0.1:8000/umum/pegawai/export/
- Upload: http://127.0.0.1:8000/umum/pegawai/import/
