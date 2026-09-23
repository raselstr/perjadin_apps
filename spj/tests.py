from datetime import date
from decimal import Decimal
from types import SimpleNamespace

from django.contrib.auth.models import User
from django.template.loader import render_to_string
from django.test import SimpleTestCase, TestCase
from django.test.client import RequestFactory
from django.urls import reverse

from perintah.models import Pelaksana, PemberiTugas, Spt
from profiles.models import OPD
from spd.models import DasarPeraturan, JenisKegiatan, Lokasi, StandardPenginapan, StandardUangHarian
from umum.models import JenisJabatan, Pegawai, Penandatangan, Tingkat, Tugas

from .access import (
    filter_spj_queryset_for_user,
    is_spj_approver_user,
    is_spj_admin_user,
    is_spj_pengguna_user,
)
from .models import Penginapan, UangHarian
from .views import DataPerjalananPerOrangView, SPJReportView


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
        self.assertEqual(
            uang_harian.get_rincian_hari_spj()["display"],
            "2 hari x 100%",
        )

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
        self.assertEqual(
            penginapan.get_rincian_hari_spj()["display"],
            "2 hari x 30%",
        )

    def test_one_spt_can_have_mixed_tariff_rows(self):
        uang_harian_100 = UangHarian.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_uang_harian="100",
            jumlah_hari_spj=1,
        )
        uang_harian_30 = UangHarian.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_uang_harian="30",
            jumlah_hari_spj=1,
        )
        uang_harian_0 = UangHarian.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_uang_harian="0",
            jumlah_hari_spj=1,
        )

        self.assertEqual(UangHarian.objects.count(), 3)
        self.assertEqual(uang_harian_100.total_biaya, Decimal("500000"))
        self.assertEqual(uang_harian_30.total_biaya, Decimal("150000.00"))
        self.assertEqual(uang_harian_0.total_biaya, Decimal("0"))

        penginapan_100 = Penginapan.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_penginapan="100",
            nama_hotel="Hotel Contoh",
            lama_menginap=1,
            harga_per_malam=Decimal("500000"),
        )
        penginapan_30 = Penginapan.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_penginapan="30",
            lama_menginap=1,
            harga_per_malam=Decimal("0"),
        )
        penginapan_0 = Penginapan.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_penginapan="0",
            lama_menginap=1,
            harga_per_malam=Decimal("0"),
        )

        self.assertEqual(Penginapan.objects.count(), 3)
        self.assertEqual(penginapan_100.total_biaya, Decimal("500000"))
        self.assertEqual(penginapan_30.total_biaya, Decimal("180000.00"))
        self.assertEqual(penginapan_0.total_biaya, Decimal("0"))

    def test_rekap_spj_sums_all_mixed_tariff_rows(self):
        for tarif in ("100", "30", "0"):
            UangHarian.objects.create(
                spt=self.spt,
                pelaksana=self.pelaksana,
                jenis_tarif_uang_harian=tarif,
                jumlah_hari_spj=1,
            )
        Penginapan.objects.create(
            spt=self.spt,
            pelaksana=self.pelaksana,
            jenis_tarif_penginapan="100",
            nama_hotel="Hotel Contoh",
            lama_menginap=1,
            harga_per_malam=Decimal("500000"),
        )
        for tarif in ("30", "0"):
            Penginapan.objects.create(
                spt=self.spt,
                pelaksana=self.pelaksana,
                jenis_tarif_penginapan=tarif,
                lama_menginap=1,
                harga_per_malam=Decimal("0"),
            )

        request = RequestFactory().get("/spj/report/")
        request.user = SimpleNamespace(is_superuser=True, is_authenticated=True)
        rows, _, _, _ = SPJReportView()._build_rows(request)

        self.assertEqual(rows[0]["uang_harian_total"], Decimal("650000.00"))
        self.assertEqual(rows[0]["hotel_total"], Decimal("680000.00"))
        self.assertEqual(rows[0]["total"], Decimal("1330000.00"))
        self.assertEqual(
            rows[0]["uang_harian_rincian"],
            "1 hari x 100%; 1 hari x 30%; 1 hari x 0%",
        )


class DataPerjalananPerOrangViewTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_superuser(
            username="admin",
            email="admin@example.com",
            password="secret12345",
        )
        self.opd = OPD.objects.create(nama="BKAD")
        self.tingkat = Tingkat.objects.create(tingkat="C")
        self.jenis_jabatan = JenisJabatan.objects.create(nama="Definitif")
        self.tugas = Tugas.objects.create(nama="Kepala OPD")
        self.kegiatan = JenisKegiatan.objects.create(nama="Koordinasi")
        self.lokasi = Lokasi.objects.create(lokasi="Medan", kota="Medan")
        self.pegawai = Pegawai.objects.create(
            nip="198901012011011001",
            nama="Rina Pelaksana",
            jabatan="Analis Anggaran",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
            tingkat=self.tingkat,
        )
        self.penandatangan = Penandatangan.objects.create(
            nama="Pejabat Penanda",
            nip="197001012000011001",
            tugas=self.tugas,
            jabatan="Kepala Badan",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
        )

    def _create_pelaksana(self, day, nomor_spt="", nomor_spd=""):
        spt = Spt.objects.create(
            dasar="Dasar",
            berita=f"Rapat hari {day}",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Gubernur",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 6, day),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        pelaksana = Pelaksana.objects.create(spt=spt, nama=self.pegawai)
        if nomor_spt or nomor_spd:
            PemberiTugas.objects.create(
                spt=spt,
                penandatangan=self.penandatangan,
                nomor_spt=nomor_spt,
                nomor_spd=nomor_spd,
                tanggal_spt=date(2026, 6, day - 1),
            )
        return pelaksana

    def test_build_rows_counts_spt_and_spd_per_person(self):
        self._create_pelaksana(10, "001/SPT/2026", "001/SPD/2026")
        self._create_pelaksana(12, "002/SPT/2026", "")

        request = RequestFactory().get("/spj/laporan/data-perjalanan-per-orang/")
        request.user = self.user
        rows, grouped_rows, person_stats, _, _, _ = (
            DataPerjalananPerOrangView()._build_rows(request)
        )

        self.assertEqual(len(rows), 2)
        self.assertEqual(len(grouped_rows), 1)
        self.assertEqual(grouped_rows[0]["rowspan"], 2)
        self.assertEqual(person_stats[self.pegawai.id]["spt_count"], 2)
        self.assertEqual(person_stats[self.pegawai.id]["spd_count"], 1)
        self.assertTrue(rows[0].has_nomor_spt)
        self.assertTrue(rows[0].has_nomor_spd)
        self.assertEqual(rows[0].nomor_spt_display, "001/SPT/2026")
        self.assertEqual(rows[0].nomor_spd_display, "001/SPD/2026")
        self.assertTrue(rows[1].has_nomor_spt)
        self.assertFalse(rows[1].has_nomor_spd)
        self.assertEqual(rows[1].nomor_spt_display, "002/SPT/2026")
        self.assertEqual(rows[1].nomor_spd_display, "-")

    def test_page_renders_finished_and_unfinished_status(self):
        self._create_pelaksana(10, "001/SPT/2026", "001/SPD/2026")
        self._create_pelaksana(12, "002/SPT/2026", "")

        self.client.force_login(self.user)
        response = self.client.get(reverse("data_perjalanan_per_orang"))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Data Perjalanan Per Orang")
        self.assertContains(response, "Selesai")
        self.assertContains(response, "Belum Selesai")
        self.assertContains(response, "SPT 2 kali")
        self.assertContains(response, "SPD 1 kali")
        self.assertContains(response, 'rowspan="2"')
        self.assertContains(response, "001/SPT/2026")
        self.assertContains(response, "001/SPD/2026")
        self.assertContains(response, "002/SPT/2026")
