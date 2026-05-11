import inspect
import io
from decimal import Decimal

from django.core.exceptions import FieldDoesNotExist
from django.test import SimpleTestCase, TestCase
from openpyxl import Workbook

from core.utils.excel_handler import ExcelExporter, ExcelImporter
from core.views_excel import ExcelImportView
from profiles.models import OPD
from spd import views as spd_views
from spd.models import (
    DasarPeraturan,
    JenisKegiatan,
    JenisSPD,
    JenisTransportasi,
    Lokasi,
    StandardPenginapan,
    StandardPesawat,
    StandardRepresentasi,
    StandardTransportasi,
    StandardUangHarian,
)
from umum import views as umum_views
from umum.models import Eselon, JenisJabatan, Pangkat, Penandatangan, Pegawai, StatusASN, Tingkat


def build_excel_file(rows):
    workbook = Workbook()
    worksheet = workbook.active

    for row in rows:
        worksheet.append(row)

    output = io.BytesIO()
    workbook.save(output)
    return output.getvalue()


class ExcelImportViewConfigurationTests(SimpleTestCase):
    def test_all_configured_import_columns_match_model_fields(self):
        for view_module in (umum_views, spd_views):
            for _, view_class in inspect.getmembers(view_module, inspect.isclass):
                if not issubclass(view_class, ExcelImportView):
                    continue

                if view_class is ExcelImportView or not getattr(view_class, "model", None):
                    continue

                for column_name in getattr(view_class, "columns", ()) or ():
                    field_name = column_name[:-3] if column_name.endswith("_id") else column_name

                    try:
                        view_class.model._meta.get_field(field_name)
                    except FieldDoesNotExist as exc:
                        self.fail(
                            f"{view_class.__name__}.{column_name} tidak cocok dengan field "
                            f"{view_class.model.__name__}: {exc}"
                        )


class ExcelImporterTests(TestCase):
    def test_csv_import_succeeds(self):
        importer = ExcelImporter(
            model=Pangkat,
            file_stream=b"pangkat,golongan,ruang\nPemula,V,\n",
            columns=["pangkat", "golongan", "ruang"],
            match_fields=[("pangkat", "golongan", "ruang")],
            filename="pangkat.csv",
        )

        result = importer.import_data()

        self.assertTrue(result["success"], result["errors"])
        self.assertEqual(result["imported"], 1)
        self.assertEqual(Pangkat.objects.get().ruang, "")

    def test_xls_upload_returns_clear_error(self):
        importer = ExcelImporter(
            model=Pangkat,
            file_stream=b"not-an-xls-file",
            columns=["pangkat", "golongan", "ruang"],
            match_fields=[("pangkat", "golongan", "ruang")],
            filename="pangkat.xls",
        )

        result = importer.import_data()

        self.assertFalse(result["success"])
        self.assertIn(".xls", result["errors"][0])

    def test_related_fields_can_be_resolved_by_display_value(self):
        dasar_peraturan = DasarPeraturan.objects.create(nama_peraturan="PMK 1")
        jenis_spd = JenisSPD.objects.create(nama="Luar Daerah")
        lokasi = Lokasi.objects.create(lokasi="Jakarta", jenis_spd=jenis_spd)
        tingkat = Tingkat.objects.create(tingkat="A")

        excel_data = build_excel_file([
            ["dasar_peraturan", "lokasi", "tingkat", "satuan", "biaya"],
            ["PMK 1", "Jakarta", "A", "OH", 1000],
        ])

        importer = ExcelImporter(
            model=StandardPenginapan,
            file_stream=excel_data,
            columns=["dasar_peraturan", "lokasi", "tingkat", "satuan", "biaya"],
            filename="standard-penginapan.xlsx",
        )

        result = importer.import_data()

        self.assertTrue(result["success"], result["errors"])
        self.assertEqual(result["imported"], 1)

        standard_penginapan = StandardPenginapan.objects.get()
        self.assertEqual(standard_penginapan.dasar_peraturan, dasar_peraturan)
        self.assertEqual(standard_penginapan.lokasi, lokasi)
        self.assertEqual(standard_penginapan.tingkat, tingkat)

    def test_unique_constraints_are_used_to_detect_existing_rows(self):
        dasar_peraturan = DasarPeraturan.objects.create(nama_peraturan="PMK 1")
        jenis_spd = JenisSPD.objects.create(nama="Luar Daerah")
        lokasi = Lokasi.objects.create(lokasi="Jakarta", jenis_spd=jenis_spd)
        tingkat = Tingkat.objects.create(tingkat="A")

        StandardPenginapan.objects.create(
            dasar_peraturan=dasar_peraturan,
            lokasi=lokasi,
            tingkat=tingkat,
            satuan="OH",
            biaya=Decimal("1000.00"),
        )

        excel_data = build_excel_file([
            ["dasar_peraturan", "lokasi", "tingkat", "satuan", "biaya"],
            ["PMK 1", "Jakarta", "A", "OH", 1500],
        ])

        importer = ExcelImporter(
            model=StandardPenginapan,
            file_stream=excel_data,
            columns=["dasar_peraturan", "lokasi", "tingkat", "satuan", "biaya"],
            filename="standard-penginapan.xlsx",
        )

        result = importer.import_data()

        self.assertTrue(result["success"], result["errors"])
        self.assertEqual(result["updated"], 1)
        self.assertEqual(result["imported"], 0)

        updated_record = StandardPenginapan.objects.get()
        self.assertEqual(updated_record.biaya, Decimal("1500.00"))

    def test_default_export_columns_skip_audit_fields(self):
        exporter = ExcelExporter(model=StandardPenginapan)

        self.assertEqual(
            [column_name for column_name, _ in exporter.columns],
            ["dasar_peraturan_id", "lokasi_id", "tingkat_id", "satuan", "biaya"],
        )


class ExcelImportCoverageTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.opd = OPD.objects.create(nama="BPKAD")
        cls.base_pangkat = Pangkat.objects.create(
            pangkat="Pembina",
            golongan="IV",
            ruang="a",
        )
        cls.base_eselon = Eselon.objects.create(
            eselon="III",
            keterangan="Administrator",
        )
        cls.base_jenis_jabatan = JenisJabatan.objects.create(
            nama="Struktural",
            keterangan="Jabatan struktural",
            fungsi="Manajerial",
        )
        cls.base_status_asn = StatusASN.objects.create(nama="PNS")
        cls.base_tingkat = Tingkat.objects.create(
            tingkat="A",
            ket="Pimpinan",
            pesawat="Bisnis",
            kapal="VIP",
            keretaapian="Eksekutif",
            lainnya="Sesuai kebutuhan",
        )
        cls.base_dasar_peraturan = DasarPeraturan.objects.create(
            nama_peraturan="PMK 1",
            nomor_peraturan="1/2026",
            keterangan="Dasar utama",
        )
        cls.base_jenis_spd = JenisSPD.objects.create(nama="Luar Daerah")
        cls.base_jenis_kegiatan = JenisKegiatan.objects.create(nama="Rapat")
        cls.base_jenis_transportasi = JenisTransportasi.objects.create(nama="Taksi")
        cls.base_lokasi_jakarta = Lokasi.objects.create(
            lokasi="Jakarta",
            kota="Jakarta",
            jenis_spd=cls.base_jenis_spd,
        )
        cls.base_lokasi_medan = Lokasi.objects.create(
            lokasi="Medan",
            kota="Medan",
            jenis_spd=cls.base_jenis_spd,
        )
        cls.base_lokasi_kisaran = Lokasi.objects.create(
            lokasi="Kisaran",
            kota="Kisaran",
            jenis_spd=cls.base_jenis_spd,
        )

    def _build_importer_for_view(self, view_class, row):
        columns = list(view_class.columns)
        excel_data = build_excel_file([columns, row])

        return ExcelImporter(
            model=view_class.model,
            file_stream=excel_data,
            columns=columns,
            match_fields=getattr(view_class, "match_fields", None),
            filename=f"{view_class.__name__}.xlsx",
        )

    def test_all_import_views_accept_valid_sample_file(self):
        scenarios = {
            umum_views.PangkatImportView: ["Penata", "III", "c"],
            umum_views.JenisJabatanImportView: ["Fungsional", "Jabatan ahli", "Teknis"],
            umum_views.EselonImportView: ["II", "Pimpinan Tinggi Pratama"],
            umum_views.StatusASNImportView: ["PPPK"],
            umum_views.TingkatImportView: ["B", "Pelaksana", "Ekonomi", "Kelas 1", "Bisnis", "Sesuai kebutuhan"],
            umum_views.PegawaiImportView: [
                "198001012006041001",
                "Budi",
                "Pembina",
                "Kepala Bidang",
                "III",
                "Struktural",
                "PNS",
                "01/01/1980",
                "BPKAD",
                "A",
            ],
            umum_views.PenandatanganImportView: [
                "Ahmad",
                "197001011995031001",
                "Pembina",
                "Kepala",
                "Struktural",
                "BPKAD",
            ],
            spd_views.DasarPeraturanImportView: ["PMK 2", "2/2026", "01/05/2026", "Dasar tambahan"],
            spd_views.JenisSPDImportView: ["Dalam Daerah"],
            spd_views.JenisKegiatanImportView: ["Sosialisasi"],
            spd_views.LokasiImportView: ["Bandung", "Bandung", "Luar Daerah"],
            spd_views.StandardPenginapanImportView: ["PMK 1", "Jakarta", "A", "OH", 1000000],
            spd_views.StandardPesawatImportView: ["PMK 1", "Kisaran", "Medan", "A", 2500000],
            spd_views.StandardUangHarianImportView: ["PMK 1", "Jakarta", "Rapat", "OH", 500000],
            spd_views.JenisTransportasiImportView: ["Sewa"],
            spd_views.StandardTransportasiImportView: ["PMK 1", "Taksi", "Medan", "Sekali jalan", 350000],
            spd_views.StandardRepresentasiImportView: ["PMK 1", "Struktural", "Luar Daerah", 750000],
        }

        expected_counts = {
            umum_views.PangkatImportView: Pangkat,
            umum_views.JenisJabatanImportView: JenisJabatan,
            umum_views.EselonImportView: Eselon,
            umum_views.StatusASNImportView: StatusASN,
            umum_views.TingkatImportView: Tingkat,
            umum_views.PegawaiImportView: Pegawai,
            umum_views.PenandatanganImportView: Penandatangan,
            spd_views.DasarPeraturanImportView: DasarPeraturan,
            spd_views.JenisSPDImportView: JenisSPD,
            spd_views.JenisKegiatanImportView: JenisKegiatan,
            spd_views.LokasiImportView: Lokasi,
            spd_views.StandardPenginapanImportView: StandardPenginapan,
            spd_views.StandardPesawatImportView: StandardPesawat,
            spd_views.StandardUangHarianImportView: StandardUangHarian,
            spd_views.JenisTransportasiImportView: JenisTransportasi,
            spd_views.StandardTransportasiImportView: StandardTransportasi,
            spd_views.StandardRepresentasiImportView: StandardRepresentasi,
        }

        for view_class, row in scenarios.items():
            with self.subTest(view=view_class.__name__):
                before_count = expected_counts[view_class].objects.count()
                importer = self._build_importer_for_view(view_class, row)
                result = importer.import_data()

                self.assertTrue(result["success"], result["errors"])
                self.assertEqual(result["imported"], 1)
                self.assertEqual(result["updated"], 0)
                self.assertEqual(result["skipped"], 0)
                self.assertEqual(expected_counts[view_class].objects.count(), before_count + 1)

    def test_standard_master_imports_can_update_existing_rows(self):
        update_scenarios = [
            (
                spd_views.StandardPenginapanImportView,
                ["PMK 1", "Jakarta", "A", "OH", 1000000],
                ["PMK 1", "Jakarta", "A", "OH", 1250000],
                StandardPenginapan,
            ),
            (
                spd_views.StandardPesawatImportView,
                ["PMK 1", "Kisaran", "Medan", "A", 2500000],
                ["PMK 1", "Kisaran", "Medan", "A", 2750000],
                StandardPesawat,
            ),
            (
                spd_views.StandardUangHarianImportView,
                ["PMK 1", "Jakarta", "Rapat", "OH", 500000],
                ["PMK 1", "Jakarta", "Rapat", "OH", 650000],
                StandardUangHarian,
            ),
            (
                spd_views.StandardTransportasiImportView,
                ["PMK 1", "Taksi", "Medan", "Sekali jalan", 350000],
                ["PMK 1", "Taksi", "Medan", "Sekali jalan", 450000],
                StandardTransportasi,
            ),
            (
                spd_views.StandardRepresentasiImportView,
                ["PMK 1", "Struktural", "Luar Daerah", 750000],
                ["PMK 1", "Struktural", "Luar Daerah", 900000],
                StandardRepresentasi,
            ),
        ]

        for view_class, initial_row, updated_row, model_class in update_scenarios:
            with self.subTest(view=view_class.__name__):
                first_result = self._build_importer_for_view(view_class, initial_row).import_data()
                second_result = self._build_importer_for_view(view_class, updated_row).import_data()

                self.assertTrue(first_result["success"], first_result["errors"])
                self.assertTrue(second_result["success"], second_result["errors"])
                self.assertEqual(second_result["updated"], 1)
                self.assertEqual(second_result["imported"], 0)
                self.assertEqual(model_class.objects.count(), 1)

                latest_record = model_class.objects.get()
                self.assertEqual(latest_record.biaya, Decimal(str(updated_row[-1])))

                model_class.objects.all().delete()
