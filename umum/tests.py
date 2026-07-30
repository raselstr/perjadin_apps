import io

from django.contrib.auth.models import User
from django.test import RequestFactory, TestCase
from openpyxl import Workbook

from core.utils.excel_handler import ExcelImporter
from profiles.models import OPD, Role, UserProfile

from .forms import KopSuratForm, PegawaiForm, PenandatanganForm
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
    def setUp(self):
        self.factory = RequestFactory()

    def _build_request(self, user):
        request = self.factory.post("/umum/pegawai/form/")
        request.user = user
        request.session = {}
        return request

    def _assert_admin_role_can_create_pegawai_for_any_opd(self, role_name):
        active_opd = OPD.objects.create(nama=f"BPKAD {role_name}")
        target_opd = OPD.objects.create(nama=f"Bapperida {role_name}")
        role = Role.objects.create(nama=role_name)
        user = User.objects.create_user(username=f"admin-{role_name.lower()}")
        UserProfile.objects.filter(user=user).update(
            role=role,
            opd=active_opd,
        )
        user.refresh_from_db()

        form = PegawaiForm(
            data={
                'nip': '198001012006041002',
                'nama': 'Siti',
                'pangkat': '',
                'jabatan': 'Analis',
                'eselon': '',
                'jenis_jabatan': '',
                'status': '',
                'tgl_lahir': '',
                'opd': target_opd.pk,
                'tingkat': '',
            },
            request=self._build_request(user),
        )

        self.assertEqual(
            list(
                form.fields["opd"]
                .queryset.order_by("pk")
                .values_list("pk", flat=True)
            ),
            list(OPD.objects.order_by("pk").values_list("pk", flat=True)),
        )
        self.assertTrue(form.is_valid(), form.errors)
        self.assertEqual(form.cleaned_data["opd"], target_opd)

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

    def test_administrator_user_can_create_pegawai_for_any_opd(self):
        self._assert_admin_role_can_create_pegawai_for_any_opd("Administrator")

    def test_administrasi_user_can_create_pegawai_for_any_opd(self):
        self._assert_admin_role_can_create_pegawai_for_any_opd("Administrasi")

    def test_superuser_can_create_pegawai_for_any_opd(self):
        target_opd = OPD.objects.create(nama="Bapperida")
        user = User.objects.create_superuser(
            username="super-admin",
            password="secret",
        )

        form = PegawaiForm(
            data={
                'nip': '198001012006041003',
                'nama': 'Rina',
                'pangkat': '',
                'jabatan': 'Analis',
                'eselon': '',
                'jenis_jabatan': '',
                'status': '',
                'tgl_lahir': '',
                'opd': target_opd.pk,
                'tingkat': '',
            },
            request=self._build_request(user),
        )

        self.assertEqual(
            list(
                form.fields["opd"]
                .queryset.order_by("pk")
                .values_list("pk", flat=True)
            ),
            list(OPD.objects.order_by("pk").values_list("pk", flat=True)),
        )
        self.assertTrue(form.is_valid(), form.errors)
        self.assertEqual(form.cleaned_data["opd"], target_opd)

    def test_regular_user_cannot_create_pegawai_for_other_opd(self):
        active_opd = OPD.objects.create(nama="BPKAD")
        target_opd = OPD.objects.create(nama="Bapperida")
        role = Role.objects.create(nama="Operator")
        user = User.objects.create_user(username="operator-opd")
        UserProfile.objects.filter(user=user).update(
            role=role,
            opd=active_opd,
        )
        user.refresh_from_db()

        form = PegawaiForm(
            data={
                'nip': '198001012006041004',
                'nama': 'Joko',
                'pangkat': '',
                'jabatan': 'Analis',
                'eselon': '',
                'jenis_jabatan': '',
                'status': '',
                'tgl_lahir': '',
                'opd': target_opd.pk,
                'tingkat': '',
            },
            request=self._build_request(user),
        )

        self.assertEqual(
            list(form.fields["opd"].queryset.values_list("pk", flat=True)),
            [active_opd.pk],
        )
        self.assertFalse(form.is_valid())
        self.assertIn("opd", form.errors)


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


class KopSuratFormTests(TestCase):
    def test_print_scale_field_is_available_for_content_only(self):
        form = KopSuratForm()

        self.assertIn("print_scale_percent", form.fields)
        self.assertIn(
            "KOP tidak ikut berubah",
            form.fields["print_scale_percent"].help_text,
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
