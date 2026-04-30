from datetime import date

from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse

from profiles.models import OPD
from spd.models import JenisKegiatan, Lokasi
from umum.models import JenisJabatan, Pangkat, Pegawai, Pemda, Penandatangan

from .forms import PemberiTugasForm
from .models import PemberiTugas, Spt


class PerintahBaseTestCase(TestCase):
    def setUp(self):
        self.opd = OPD.objects.create(nama="BKAD")
        self.pangkat = Pangkat.objects.create(
            pangkat="Pembina",
            golongan="IV",
            ruang="a",
        )
        self.jenis_jabatan = JenisJabatan.objects.create(
            nama="Definitif",
        )
        self.kegiatan = JenisKegiatan.objects.create(nama="Koordinasi")
        self.lokasi = Lokasi.objects.create(lokasi="Medan", kota="Medan")

        self.penandatangan = Penandatangan.objects.create(
            nama="Ahmad Pimpinan",
            nip="197901012005011001",
            pangkat=self.pangkat,
            tugas="Kepala Badan",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
        )
        self.penandatangan_lain = Penandatangan.objects.create(
            nama="Siti Pimpinan",
            nip="198002022006042002",
            pangkat=self.pangkat,
            tugas="Sekretaris",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
        )
        self.pegawai = Pegawai.objects.create(
            nip="198501012010011001",
            nama="Budi Pelaksana",
            pangkat=self.pangkat,
            jabatan="Analis Keuangan",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
        )
        self.spt = Spt.objects.create(
            dasar="Surat perintah test",
            berita="Koordinasi ke provinsi",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Gubernur",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 4, 30),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        self.spt.pelaksana.create(nama=self.pegawai)


class PemberiTugasFormTests(PerintahBaseTestCase):
    def test_save_copies_snapshot_from_penandatangan(self):
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt,
            penandatangan=self.penandatangan,
            nomor_spt="090/ST/2026",
            tanggal_spt=date(2026, 4, 30),
        )

        self.assertEqual(pemberi_tugas.nama, self.penandatangan.nama)
        self.assertEqual(pemberi_tugas.nip, self.penandatangan.nip)
        self.assertEqual(pemberi_tugas.tugas, self.penandatangan.tugas)
        self.assertEqual(
            pemberi_tugas.jenis_jabatan,
            self.jenis_jabatan.nama,
        )
        self.assertEqual(pemberi_tugas.opd, self.opd.nama)

    def test_form_rejects_duplicate_spt(self):
        PemberiTugas.objects.create(
            spt=self.spt,
            penandatangan=self.penandatangan,
            nomor_spt="090/ST/2026",
            tanggal_spt=date(2026, 4, 30),
        )

        form = PemberiTugasForm(data={
            "spt": self.spt.pk,
            "penandatangan": self.penandatangan_lain.pk,
            "nomor_spt": "091/ST/2026",
            "tanggal_spt": "2026-04-30",
        })

        self.assertFalse(form.is_valid())
        self.assertIn(
            "Setiap SPT hanya boleh memiliki satu data pemberi tugas.",
            form.non_field_errors(),
        )
        self.assertIn("spt", form.errors)

    def test_form_rejects_duplicate_spt_and_penandatangan_pair(self):
        PemberiTugas.objects.create(
            spt=self.spt,
            penandatangan=self.penandatangan,
            nomor_spt="090/ST/2026",
            tanggal_spt=date(2026, 4, 30),
        )

        form = PemberiTugasForm(data={
            "spt": self.spt.pk,
            "penandatangan": self.penandatangan.pk,
            "nomor_spt": "090/ST/2026",
            "tanggal_spt": "2026-04-30",
        })

        self.assertFalse(form.is_valid())
        self.assertIn(
            "Kombinasi SPT dan penandatangan tidak boleh ganda.",
            form.non_field_errors(),
        )
        self.assertIn("penandatangan", form.errors)


class PemberiTugasPrintViewTests(PerintahBaseTestCase):
    def setUp(self):
        super().setUp()
        self.superuser = User.objects.create_superuser(
            username="admin",
            email="admin@example.com",
            password="admin12345",
        )
        self.pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt,
            penandatangan=self.penandatangan,
            nomor_spt="090/ST/2026",
            tanggal_spt=date(2026, 4, 30),
        )
        Pemda.objects.create(
            nama_pemda="Pemerintah Kabupaten Asahan",
            nama_dinas="Badan Keuangan Daerah",
            alamat="Jl. Jenderal Sudirman No. 1",
            jenis_kop="3",
        )

    def test_print_spt_view_requires_login(self):
        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[self.pemberi_tugas.pk])
        )

        self.assertEqual(response.status_code, 302)

    def test_print_spd_view_renders_document_data(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[self.pemberi_tugas.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "SURAT PERJALANAN DINAS")
        self.assertContains(response, self.pemberi_tugas.nomor_spt)
        self.assertContains(response, self.pegawai.nama)
