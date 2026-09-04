from datetime import date
from decimal import Decimal
from types import SimpleNamespace

from django.template.loader import render_to_string
from django.test import SimpleTestCase, TestCase

from perintah.models import Pelaksana, Spt
from profiles.models import OPD
from spd.models import DasarPeraturan, JenisKegiatan, Lokasi, StandardPenginapan, StandardUangHarian
from umum.models import JenisJabatan, Pegawai, Tingkat

from .access import (
    filter_spj_queryset_for_user,
    is_spj_approver_user,
    is_spj_admin_user,
    is_spj_pengguna_user,
)
from .models import Penginapan, UangHarian


class RecordingQuerySet:
    def __init__(self):
        self.filter_kwargs = None
        self.none_called = False

    def filter(self, **kwargs):
        self.filter_kwargs = kwargs
        return self

    def none(self):
        self.none_called = True
        return self


class SPJUploadTemplateTests(SimpleTestCase):
    def test_photo_handler_skips_non_image_files(self):
        template = render_to_string("includes/scripts.html", request=None)

        self.assertIn("shouldHandleInput(input)", template)
        self.assertIn("file.type && file.type.startsWith('image/')", template)
        self.assertNotIn("accept.includes('image')", template)


class SPJAccessTests(SimpleTestCase):
    @staticmethod
    def _role_user(role_name, is_superuser=False):
        return SimpleNamespace(
            is_superuser=is_superuser,
            is_authenticated=True,
            userprofile=SimpleNamespace(
                role=SimpleNamespace(nama=role_name),
            ),
        )

    def test_superuser_is_admin_even_without_role_scope(self):
        user = SimpleNamespace(is_superuser=True, is_authenticated=True)

        self.assertTrue(is_spj_admin_user(user))
        self.assertFalse(is_spj_pengguna_user(user))
        self.assertTrue(is_spj_approver_user(user))

    def test_only_bendahara_role_can_approve_spj(self):
        self.assertTrue(is_spj_approver_user(self._role_user("Bendahara")))
        self.assertTrue(is_spj_approver_user(self._role_user(" bendahara ")))
        self.assertFalse(is_spj_approver_user(self._role_user("Verifikator")))
        self.assertFalse(is_spj_approver_user(self._role_user("Pengguna")))

    def test_non_superuser_filters_by_active_opd(self):
        request = SimpleNamespace(
            user=SimpleNamespace(is_superuser=False, is_authenticated=True),
            session={"session_opd_id": 7},
        )
        queryset = RecordingQuerySet()

        result = filter_spj_queryset_for_user(
            queryset,
            request,
            "pelaksana__nama__nip",
        )

        self.assertIs(result, queryset)
        self.assertEqual(queryset.filter_kwargs, {"pelaksana__nama__opd_id": 7})

        pelaksana_queryset = RecordingQuerySet()
        filter_spj_queryset_for_user(pelaksana_queryset, request, "nama__nip")
        self.assertEqual(pelaksana_queryset.filter_kwargs, {"nama__opd_id": 7})

    def test_non_superuser_without_active_opd_gets_empty_queryset(self):
        request = SimpleNamespace(
            user=SimpleNamespace(is_superuser=False, is_authenticated=True),
            session={},
        )
        queryset = RecordingQuerySet()

        result = filter_spj_queryset_for_user(queryset, request, "nama__nip")

        self.assertIs(result, queryset)
        self.assertTrue(queryset.none_called)

    def test_pengguna_filters_by_logged_in_username_nip(self):
        request = SimpleNamespace(
            user=self._role_user("Pengguna"),
            session={"session_opd_id": 7},
        )
        request.user.username = "198001012005011001"
        queryset = RecordingQuerySet()

        result = filter_spj_queryset_for_user(
            queryset,
            request,
            "pelaksana__nama__nip",
        )

        self.assertIs(result, queryset)
        self.assertEqual(
            queryset.filter_kwargs,
            {"pelaksana__nama__nip": "198001012005011001"},
        )


class SPJCalculationModelTests(TestCase):
    def setUp(self):
        self.opd = OPD.objects.create(nama="Badan Keuangan Daerah")
        self.tingkat = Tingkat.objects.create(tingkat="D")
        self.jenis_jabatan = JenisJabatan.objects.create(nama="Definitif")
        self.kegiatan = JenisKegiatan.objects.create(nama="Koordinasi")
        self.lokasi = Lokasi.objects.create(lokasi="Medan", kota="Medan")
        self.dasar_peraturan = DasarPeraturan.objects.create(
            nama_peraturan="Perbup Standar Biaya",
            tanggal_peraturan=date(2026, 1, 1),
        )
        self.pegawai = Pegawai.objects.create(
            nip="199501172025212059",
            nama="Pelaksana SPJ",
            jabatan="Operator",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
            tingkat=self.tingkat,
        )
        self.spt = Spt.objects.create(
            dasar="Dasar",
            berita="Berita",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Regional",
            lama_perjalanan=3,
            tgl_berangkat=date(2026, 5, 10),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        self.pelaksana = Pelaksana.objects.create(
            spt=self.spt,
            nama=self.pegawai,
        )
        StandardUangHarian.objects.create(
            lokasi=self.lokasi,
            jenis_kegiatan=self.kegiatan,
            satuan="OH",
            biaya=Decimal("500000"),
            dasar_peraturan=self.dasar_peraturan,
        )
        StandardPenginapan.objects.create(
            lokasi=self.lokasi,
            tingkat=self.tingkat,
            satuan="Malam",
            biaya=Decimal("600000"),
            dasar_peraturan=self.dasar_peraturan,
        )

    def test_uang_harian_total_uses_jumlah_hari_spj(self):
        uang_harian = UangHarian.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jumlah_hari_spj=2,
        )

        self.assertEqual(uang_harian.uang_harian_per_hari, Decimal("500000"))
        self.assertEqual(uang_harian.total_biaya, Decimal("1000000"))

    def test_penginapan_30_percent_uses_standard_times_days(self):
        penginapan = Penginapan.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_penginapan="30",
            lama_menginap=2,
            harga_per_malam=Decimal("0"),
        )

        self.assertEqual(penginapan.harga_per_malam, Decimal("180000.00"))
        self.assertEqual(penginapan.total_biaya, Decimal("360000.00"))
        self.assertEqual(penginapan.nama_hotel, "")
