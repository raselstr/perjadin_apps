from django.urls import path
from .views_excel import GenericExcelExportView, GenericExcelImportView, TableDataExcelExportView
from .views_pdf import GenericPdfTableView

app_name = 'core'

urlpatterns = [
    # Export tabel langsung dari tampilan halaman
    path('export/table-to-excel/', TableDataExcelExportView.as_view(), name='table_to_excel'),
    # Generic Excel export/import
    path('excel/<str:app_label>/<str:model_name>/export/', GenericExcelExportView.as_view(), name='generic_excel_export'),
    path('excel/<str:app_label>/<str:model_name>/import/', GenericExcelImportView.as_view(), name='generic_excel_import'),
    # Generic PDF table print
    path('pdf/<str:app_label>/<str:model_name>/table/', GenericPdfTableView.as_view(), name='generic_pdf_table'),
]