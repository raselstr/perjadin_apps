from datetime import date

from django.contrib.auth.models import User
from django.contrib.sessions.middleware import SessionMiddleware
from django.test import RequestFactory, TestCase
from django.urls import reverse

from profiles.models import OPD, UserProfile
from spd.models import JenisKegiatan, Lokasi
from umum.models import Eselon, JenisJabatan, Pangkat, Pegawai, Pemda, Penandatangan

from .document_utils import (
    build_spt_signature_title_parts,
    generate_default_document_number,
)
from .forms import PemberiTugasForm
from .models import PemberiTugas, Spt


def attach_session(request):
    middleware = SessionMiddleware(lambda req: None)
    middleware.process_request(request)
    request.session.save()
    return request


class PerintahBaseTestCase(TestCase):
    def setUp(self):
        self.factory = RequestFactory()
        self.opd_bk = OPD.objects.create(nama="Badan Keuangan Daerah")
        self.opd_setda = OPD.objects.create(nama="Sekretariat Daerah")

        self.pangkat_ivc = Pangkat.objects.create(
            pangkat="Pembina Utama Muda",
            golongan="IV",
            ruang="c",
        )
        self.pangkat_iva = Pangkat.objects.create(
            pangkat="Pembina",
            golongan="IV",
            ruang="a",
        )
        self.pangkat_iiic = Pangkat.objects.create(
            pangkat="Penata",
            golongan="III",
            ruang="c",
        )

        self.eselon_ii = Eselon.objects.create(
            eselon="II",
            keterangan="Pimpinan Tinggi Pratama",
        )
        self.eselon_iii = Eselon.objects.create(
            eselon="III",
            keterangan="Administrator",
        )

        self.jenis_jabatan = JenisJabatan.objects.create(
            nama="Definitif",
        )
        self.kegiatan = JenisKegiatan.objects.create(nama="Koordinasi")
        self.lokasi = Lokasi.objects.create(lokasi="Medan", kota="Medan")

        self.bupati = Penandatangan.objects.create(
            nama="Bupati Asahan",
            nip="197001011995031001",
            pangkat=self.pangkat_ivc,
            tugas="Bupati",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_setda,
        )
        self.kepala_bk = Penandatangan.objects.create(
            nama="Kepala BKAD",
            nip="197201011996021001",
            pangkat=self.pangkat_iva,
            tugas="Kepala",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
        )
        self.ppk_bk = Penandatangan.objects.create(
            nama="PPK BKAD",
            nip="197301011997031001",
            pangkat=self.pangkat_iva,
            tugas="PPK",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
        )
        self.kepala_setda = Penandatangan.objects.create(
            nama="Kepala Setda",
            nip="197401011998041001",
            pangkat=self.pangkat_iva,
            tugas="Kepala",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_setda,
        )

        self.pegawai_eselon_ii = Pegawai.objects.create(
            nip="198001012005011001",
            nama="Pelaksana Eselon II",
            pangkat=self.pangkat_ivc,
            jabatan="Kepala Bidang",
            eselon=self.eselon_ii,
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
            tgl_lahir=date(1980, 1, 1),
        )
        self.pegawai_eselon_iii = Pegawai.objects.create(
            nip="198202022006021002",
            nama="Pelaksana Eselon III",
            pangkat=self.pangkat_iva,
            jabatan="Kepala Sub Bagian",
            eselon=self.eselon_iii,
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
            tgl_lahir=date(1982, 2, 2),
        )
        self.pegawai_non_eselon = Pegawai.objects.create(
            nip="198503032007031003",
            nama="Pelaksana Non Eselon",
            pangkat=self.pangkat_iiic,
            jabatan="Analis Keuangan",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
            tgl_lahir=date(1985, 3, 3),
        )
        self.pegawai_setda = Pegawai.objects.create(
            nip="198704042008041004",
            nama="Pelaksana Setda",
            pangkat=self.pangkat_iiic,
            jabatan="Analis Pemerintahan",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_setda,
            tgl_lahir=date(1987, 4, 4),
        )

        self.spt_bupati = Spt.objects.create(
            dasar="Dasar surat tugas bupati",
            berita="Koordinasi tingkat pimpinan",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Gubernur Sumatera Utara",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 4, 30),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        self.spt_bupati.pelaksana.create(nama=self.pegawai_eselon_ii)
        self.spt_bupati.pelaksana.create(nama=self.pegawai_eselon_iii)

        self.spt_spd = Spt.objects.create(
            dasar="Dasar perjalanan dinas kepala",
            berita="Rapat koordinasi anggaran",
            kota_tujuan=self.lokasi,
            tempat_tujuan="BPKAD Provinsi",
            lama_perjalanan=3,
            tgl_berangkat=date(2026, 5, 1),
            jenis_kegiatan=self.kegiatan,
            kendaraan="kendaraan_dinas",
        )
        self.spt_spd.pelaksana.create(nama=self.pegawai_eselon_ii)
        self.spt_spd.pelaksana.create(nama=self.pegawai_eselon_iii)
        self.spt_spd.pelaksana.create(nama=self.pegawai_non_eselon)

        self.spt_without_eselon_ii = Spt.objects.create(
            dasar="Dasar tanpa eselon dua",
            berita="Koordinasi staf",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Inspektorat Provinsi",
            lama_perjalanan=1,
            tgl_berangkat=date(2026, 5, 2),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        self.spt_without_eselon_ii.pelaksana.create(
            nama=self.pegawai_eselon_iii
        )
        self.spt_without_eselon_ii.pelaksana.create(
            nama=self.pegawai_non_eselon
        )

        self.spt_setda = Spt.objects.create(
            dasar="Dasar Setda",
            berita="Koordinasi Setda",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Regional",
            lama_perjalanan=1,
            tgl_berangkat=date(2026, 5, 3),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        self.spt_setda.pelaksana.create(nama=self.pegawai_setda)

        Pemda.objects.create(
            nama_pemda="Pemerintah Kabupaten Asahan",
            nama_dinas=self.opd_bk,
            alamat="Jl. Ahmad Yani No. 1 Kisaran",
            telepon="0623-123456",
            email="bkad@asahankab.go.id",
            website="https://bkad.asahankab.go.id",
            ibukota="Kisaran",
        )
        Pemda.objects.create(
            nama_pemda="Pemerintah Kabupaten Asahan",
            nama_dinas=self.opd_setda,
            alamat="Jl. Jenderal Sudirman No. 5 Kisaran",
            telepon="0623-654321",
            email="setda@asahankab.go.id",
            website="https://setda.asahankab.go.id",
            ibukota="Kisaran",
        )


class PemberiTugasFormTests(PerintahBaseTestCase):
    def test_form_limits_queryset_to_active_opd_and_global_signatories(self):
        user = User.objects.create_user(
            username="operator-bk",
            password="secret123",
        )
        user.userprofile.opd = self.opd_bk
        user.userprofile.save()

        request = attach_session(self.factory.get("/perintah/pemberi-tugas/form/"))
        request.user = user
        request.session["session_opd_id"] = self.opd_bk.id
        request.session["session_opd_nama"] = self.opd_bk.nama

        form = PemberiTugasForm(request=request)

        self.assertIn(self.spt_bupati, form.fields["spt"].queryset)
        self.assertIn(self.spt_spd, form.fields["spt"].queryset)
        self.assertIn(self.spt_without_eselon_ii, form.fields["spt"].queryset)
        self.assertNotIn(self.spt_setda, form.fields["spt"].queryset)
        self.assertIn(self.kepala_bk, form.fields["penandatangan"].queryset)
        self.assertIn(self.bupati, form.fields["penandatangan"].queryset)
        self.assertNotIn(self.kepala_setda, form.fields["penandatangan"].queryset)

    def test_form_rejects_bupati_when_spt_has_no_eselon_ii(self):
        form = PemberiTugasForm(data={
            "spt": self.spt_without_eselon_ii.pk,
            "penandatangan": self.bupati.pk,
            "nomor_spt": "090/ST/2026",
            "tanggal_spt": "2026-05-02",
        })

        self.assertFalse(form.is_valid())
        self.assertIn("spt", form.errors)
        self.assertIn(
            "minimal satu pelaksana dengan eselon II",
            form.errors["spt"][0],
        )


class DocumentUtilsTests(PerintahBaseTestCase):
    def test_default_document_number_uses_roman_month(self):
        result = generate_default_document_number(
            "091",
            date(2026, 5, 1),
            "800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}",
        )

        self.assertEqual(result, "800.1.11.1/091/BKAD/V/2026")

    def test_spt_signature_title_separates_prefix_from_title_lines(self):
        plt = JenisJabatan.objects.create(nama="Plt.")
        pemda = Pemda.objects.get(nama_dinas=self.opd_bk)
        pemda.nama_kabupaten = "Asahan"
        pemda.save()
        penandatangan = Penandatangan.objects.create(
            nama="Plt Kepala BKAD",
            nip="197501011999011001",
            pangkat=self.pangkat_iva,
            tugas="Kepala",
            jenis_jabatan=plt,
            opd=self.opd_bk,
        )

        result = build_spt_signature_title_parts(
            penandatangan,
            pemda=pemda,
        )

        self.assertEqual(result["prefix"], "Plt.")
        self.assertEqual(
            result["lines"],
            ["Kepala Badan Keuangan", "Daerah Kabupaten Asahan"],
        )


class PemberiTugasPrintViewTests(PerintahBaseTestCase):
    def setUp(self):
        super().setUp()
        self.superuser = User.objects.create_superuser(
            username="admin",
            email="admin@example.com",
            password="admin12345",
        )
        self.pemberi_tugas_bupati = PemberiTugas.objects.create(
            spt=self.spt_bupati,
            penandatangan=self.bupati,
            nomor_spt="090/ST/BUP/2026",
            tanggal_spt=date(2026, 4, 30),
        )
        self.pemberi_tugas_spd = PemberiTugas.objects.create(
            spt=self.spt_spd,
            penandatangan=self.kepala_bk,
            nomor_spt="091/ST/BK/2026",
            tanggal_spt=date(2026, 5, 1),
        )

    def test_print_spt_filters_pelaksana_for_bupati(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[self.pemberi_tugas_bupati.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "BUPATI ASAHAN")
        self.assertContains(response, self.pegawai_eselon_ii.nama)
        self.assertNotContains(response, self.pegawai_eselon_iii.nama)

    def test_print_spd_uses_ppk_and_shows_followers(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[self.pemberi_tugas_spd.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "SURAT PERJALANAN DINAS (SPD)")
        self.assertContains(response, self.ppk_bk.nama)
        self.assertContains(response, self.pegawai_eselon_ii.nama)
        self.assertContains(response, self.pegawai_eselon_iii.nama)
        self.assertContains(response, self.pegawai_non_eselon.nama)

    def test_print_spd_returns_404_for_bupati_signatory(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[self.pemberi_tugas_bupati.pk])
        )

        self.assertEqual(response.status_code, 404)
