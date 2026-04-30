import io

from django.test import TestCase
from openpyxl import Workbook

from core.utils.excel_handler import ExcelImporter
from profiles.models import OPD

from .forms import PegawaiForm, PenandatanganForm
from .models import Eselon, JenisJabatan, Pangkat, Pegawai, Penandatangan, StatusASN, Tingkat


def build_excel_file(rows):
    workbook = Workbook()
    worksheet = workbook.active

    for row in rows:
        worksheet.append(row)

    output = io.BytesIO()
    workbook.save(output)
    return output.getvalue()


class PangkatImportTests(TestCase):
    def _build_excel_file(self, rows):
        return build_excel_file(rows)

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


class PegawaiFormTests(TestCase):
    def test_optional_relations_can_be_left_blank(self):
        form = PegawaiForm(data={
            'nip': '198001012006041001',
            'nama': 'Budi',
            'pangkat': '',
            'jabatan': 'Analis',
            'eselon': '',
            'jenis_jabatan': '',
            'status': '',
            'tgl_lahir': '',
            'opd': '',
            'tingkat': '',
        })

        self.assertTrue(form.is_valid(), form.errors)


class PenandatanganFormTests(TestCase):
    def test_duplicate_penandatangan_shows_validation_error(self):
        opd = OPD.objects.create(nama="BPKAD")
        pangkat = Pangkat.objects.create(
            pangkat="Pembina",
            golongan="IV",
            ruang="a",
        )
        jenis_jabatan = JenisJabatan.objects.create(nama="Definitif")

        Penandatangan.objects.create(
            nama="Ahmad",
            nip="197001011995031001",
            pangkat=pangkat,
            tugas="Kepala",
            jenis_jabatan=jenis_jabatan,
            opd=opd,
        )

        form = PenandatanganForm(data={
            "nama": "Ahmad",
            "nip": "197001011995031001",
            "pangkat": pangkat.pk,
            "tugas": "Kepala",
            "jenis_jabatan": jenis_jabatan.pk,
            "opd": opd.pk,
        })

        self.assertFalse(form.is_valid())
        self.assertIn("__all__", form.errors)
        self.assertIn(
            "Penandatangan dengan NIP, nama, tugas, jenis jabatan, dan OPD yang sama sudah ada.",
            form.errors["__all__"][0],
        )


class PegawaiImportTests(TestCase):
    def test_import_updates_existing_pegawai_by_nip(self):
        pangkat = Pangkat.objects.create(pangkat='Pengatur', golongan='III', ruang='a')
        eselon = Eselon.objects.create(eselon='III', keterangan='Administrator')
        jenis_jabatan = JenisJabatan.objects.create(nama='Fungsional')
        status = StatusASN.objects.create(nama='PNS')
        opd = OPD.objects.create(nama='Sekretariat')
        tingkat = Tingkat.objects.create(tingkat='A')

        pegawai = Pegawai.objects.create(
            nip='198001012006041001',
            nama='Budi',
            pangkat=pangkat,
            jabatan='Jabatan Lama',
            eselon=eselon,
            jenis_jabatan=jenis_jabatan,
            status=status,
            opd=opd,
            tingkat=tingkat,
        )

        excel_data = build_excel_file([
            ['nip', 'nama', 'pangkat', 'jabatan', 'eselon', 'jenis_jabatan', 'status', 'tgl_lahir', 'opd', 'tingkat'],
            ['198001012006041001', 'Budi', 'Pengatur', 'Jabatan Baru', 'III', 'Fungsional', 'PNS', None, 'Sekretariat', 'A'],
        ])

        importer = ExcelImporter(
            model=Pegawai,
            file_stream=excel_data,
            columns=['nip', 'nama', 'pangkat', 'jabatan', 'eselon', 'jenis_jabatan', 'status', 'tgl_lahir', 'opd', 'tingkat'],
            match_fields=[('nip',)],
        )

        result = importer.import_data()

        self.assertTrue(result['success'], result['errors'])
        self.assertEqual(result['updated'], 1)
        self.assertEqual(result['imported'], 0)

        pegawai.refresh_from_db()
        self.assertEqual(pegawai.jabatan, 'Jabatan Baru')
        self.assertEqual(pegawai.eselon, eselon)
        self.assertEqual(pegawai.tingkat, tingkat)
