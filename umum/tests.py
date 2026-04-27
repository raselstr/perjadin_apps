import io

from django.test import TestCase
from openpyxl import Workbook

from core.utils.excel_handler import ExcelImporter
from .models import Pangkat


class PangkatImportTests(TestCase):
    def _build_excel_file(self, rows):
        workbook = Workbook()
        worksheet = workbook.active

        for row in rows:
            worksheet.append(row)

        output = io.BytesIO()
        workbook.save(output)
        return output.getvalue()

    def test_import_allows_blank_ruang(self):
        excel_data = self._build_excel_file([
            ['pangkat', 'golongan', 'ruang'],
            ['Pemula', 'V', None],
        ])

        importer = ExcelImporter(
            model=Pangkat,
            file_stream=excel_data,
            columns=['pangkat', 'golongan', 'ruang'],
            match_fields=[('pangkat', 'golongan', 'ruang')],
        )

        result = importer.import_data()

        self.assertTrue(result['success'])
        self.assertEqual(result['imported'], 1)

        pangkat = Pangkat.objects.get(pangkat='Pemula', golongan='V')
        self.assertEqual(pangkat.ruang, '')

    def test_reimport_blank_ruang_row_is_skipped(self):
        Pangkat.objects.create(pangkat='Pemula', golongan='V', ruang='')

        excel_data = self._build_excel_file([
            ['pangkat', 'golongan', 'ruang'],
            ['Pemula', 'V', None],
        ])

        importer = ExcelImporter(
            model=Pangkat,
            file_stream=excel_data,
            columns=['pangkat', 'golongan', 'ruang'],
            match_fields=[('pangkat', 'golongan', 'ruang')],
        )

        result = importer.import_data()

        self.assertTrue(result['success'])
        self.assertEqual(result['imported'], 0)
        self.assertEqual(result['skipped'], 1)
        self.assertEqual(
            Pangkat.objects.filter(pangkat='Pemula', golongan='V', ruang='').count(),
            1,
        )
