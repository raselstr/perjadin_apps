"""
CONTOH IMPLEMENTASI EXCEL IMPORT/EXPORT

Di umum/urls.py atau app manapun:
"""

from django.urls import path
from core.views_excel import ExcelExportView, ExcelImportView
from umum.models import Pegawai
from . import views


class PegawaiExportView(ExcelExportView):
    """Download Pegawai data sebagai Excel"""
    model = Pegawai
    
    def get_queryset(self):
        # Bisa di-filter sesuai kebutuhan
        return Pegawai.objects.all()


class PegawaiImportView(ExcelImportView):
    """Upload & import Pegawai data dari Excel"""
    model = Pegawai
    success_url = '/umum/pegawai/'  # Redirect setelah berhasil


urlpatterns = [
    # ... existing urls
    path('pegawai/', views.PegawaiListView.as_view(), name='pegawai-list'),
    path('pegawai/export/', PegawaiExportView.as_view(), name='pegawai-export'),
    path('pegawai/import/', PegawaiImportView.as_view(), name='pegawai-import'),
]


"""
CONTOH: Update PegawaiListView dengan ExcelMixin
"""

from core.views_excel import ExcelMixin

class PegawaiListView(ExcelMixin, ListView):
    model = Pegawai
    template_name = 'pages/page.html'
    # ... existing attributes
    
    # Optional: custom columns untuk Excel export
    excel_columns = [
        ('nip', 'NIP'),
        ('nama', 'Nama Pegawai'),
        ('email', 'Email'),
        ('created_at', 'Dibuat'),
    ]


"""
CONTOH: Di template, tambahkan buttons di list view:
"""

# Di templates/umum/pegawai/list.html atau anywhere you show the table:
{% include "components/excel/buttons.html" with export_url=export_url import_url=import_url model_name="Pegawai" %}


"""
INSTALASI DEPENDENCY:
"""
# Di requirements.txt atau shell:
pip install openpyxl


"""
FITUR:
✅ Export data ke Excel dengan styling
✅ Import dari Excel dengan preview & validasi
✅ Automatic validation menggunakan Django model validation
✅ Error reporting detail per row
✅ Generic views yang bisa di-reuse di semua app
✅ Bootstrap modal UI untuk upload
✅ Async preview sebelum import
✅ Kolom customizable
✅ Auto-adjust column widths
✅ Skip empty rows automatically
"""
