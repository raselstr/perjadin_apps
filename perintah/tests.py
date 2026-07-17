from datetime import date

from django.contrib.auth.models import User
from django.contrib.sessions.middleware import SessionMiddleware
from django.core.exceptions import ValidationError
from django.template.loader import render_to_string
from django.test import RequestFactory, TestCase
from django.urls import reverse

from core.utils.formatting import format_nip
from profiles.models import OPD, Role, UserProfile
from spd.models import JenisKegiatan, Lokasi
from umum.models import Eselon, JenisJabatan, Pangkat, Pegawai, Pemda, Penandatangan

from .document_utils import (
    build_spt_signature_title_parts,
    format_spt_kota_tujuan,
    format_spt_tempat_tujuan,
    format_spt_tujuan_perjalanan,
    format_spt_date_range,
    generate_default_document_number,
)
from .forms import PelaksanaForm, PelaksanaFormSet, PemberiTugasForm
from .models import PemberiTugas, Spt
from .tables import PemberiTugasTable, SptTable, TtdSptSpdTable


class ModalTemplateTestCase(TestCase):
    def test_crud_modal_allows_dismissal_without_static_restrictions(self):
        html = render_to_string("components/crud/modal.html")

        self.assertNotIn('data-bs-backdrop="static"', html)
        self.assertNotIn('data-bs-keyboard="false"', html)

    def test_tables_include_spt_id_column(self):
        self.assertIn("spt_id", SptTable.base_columns)
        self.assertIn("spt_id", PemberiTugasTable.base_columns)
        self.assertIn("spt_id", TtdSptSpdTable.base_columns)


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
        self.role_operator = Role.objects.create(nama="Operator")
        self.role_administrator = Role.objects.create(nama="Administrator")

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
        self.eselon_iv = Eselon.objects.create(
            eselon="IV",
            keterangan="Pengawas",
        )
        self.eselon_i = Eselon.objects.create(
            eselon="I",
            keterangan="Pimpinan Tinggi Madya",
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
        self.wakil_bupati = Penandatangan.objects.create(
            nama="Wakil Bupati Asahan",
            nip="197501011999051001",
            pangkat=self.pangkat_ivc,
            tugas="Wakil Bupati",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_setda,
        )
        self.sekretaris_daerah = Penandatangan.objects.create(
            nama="Sekretaris Daerah Asahan",
            nip="197601012000061001",
            pangkat=self.pangkat_ivc,
            tugas="Sekretaris Daerah",
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
        self.pegawai_eselon_i = Pegawai.objects.create(
            nip="197901012004011000",
            nama="Pelaksana Eselon I",
            pangkat=self.pangkat_ivc,
            jabatan="Asisten Daerah",
            eselon=self.eselon_i,
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
            tgl_lahir=date(1979, 1, 1),
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
        self.pegawai_eselon_iv = Pegawai.objects.create(
            nip="198604042008041004",
            nama="Pelaksana Eselon IV",
            pangkat=self.pangkat_iiic,
            jabatan="Kepala Sub Bagian Umum",
            eselon=self.eselon_iv,
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_bk,
            tgl_lahir=date(1986, 4, 4),
        )
        self.pegawai_setda = Pegawai.objects.create(
            nip="198704042009041005",
            nama="Pelaksana Setda",
            pangkat=self.pangkat_iiic,
            jabatan="Analis Pemerintahan",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_setda,
            tgl_lahir=date(1987, 4, 4),
        )
        self.pegawai_setda_eselon_ii = Pegawai.objects.create(
            nip="198105052006051006",
            nama="Pelaksana Setda Eselon II",
            pangkat=self.pangkat_ivc,
            jabatan="Asisten Administrasi",
            eselon=self.eselon_ii,
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd_setda,
            tgl_lahir=date(1981, 5, 5),
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

        self.spt_only_eselon_ii = Spt.objects.create(
            dasar="Dasar khusus eselon dua",
            berita="Koordinasi pimpinan saja",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Kementerian",
            lama_perjalanan=1,
            tgl_berangkat=date(2026, 5, 4),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        self.spt_only_eselon_ii.pelaksana.create(
            nama=self.pegawai_eselon_ii
        )

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
        user.userprofile.role = self.role_operator
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
        self.assertNotIn(self.sekretaris_daerah, form.fields["penandatangan"].queryset)
        self.assertNotIn(self.ppk_bk, form.fields["penandatangan"].queryset)
        self.assertNotIn(self.kepala_setda, form.fields["penandatangan"].queryset)

    def test_pelaksana_form_expands_queryset_for_administrator_role(self):
        user = User.objects.create_user(
            username="administrator-bk",
            password="secret123",
        )
        user.userprofile.opd = self.opd_bk
        user.userprofile.role = self.role_administrator
        user.userprofile.save()

        request = attach_session(self.factory.get("/perintah/spt/form/"))
        request.user = user
        request.session["session_opd_id"] = self.opd_bk.id
        request.session["session_opd_nama"] = self.opd_bk.nama

        form = PelaksanaForm(request=request)

        self.assertIn(self.pegawai_eselon_ii, form.fields["nama"].queryset)
        self.assertIn(self.pegawai_eselon_iii, form.fields["nama"].queryset)
        self.assertIn(self.pegawai_non_eselon, form.fields["nama"].queryset)
        self.assertIn(
            self.pegawai_setda_eselon_ii,
            form.fields["nama"].queryset,
        )
        self.assertNotIn(self.pegawai_setda, form.fields["nama"].queryset)

    def test_pelaksana_formset_rejects_duplicate_pegawai(self):
        spt = Spt.objects.create(
            dasar="Dasar formset duplikat",
            berita="Uji pelaksana ganda",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Uji",
            lama_perjalanan=1,
            tgl_berangkat=date(2026, 5, 9),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )

        formset = PelaksanaFormSet(
            data={
                "pelaksana-TOTAL_FORMS": "2",
                "pelaksana-INITIAL_FORMS": "0",
                "pelaksana-MIN_NUM_FORMS": "0",
                "pelaksana-MAX_NUM_FORMS": "1000",
                "pelaksana-0-nama": str(self.pegawai_eselon_iii.pk),
                "pelaksana-1-nama": str(self.pegawai_eselon_iii.pk),
            },
            instance=spt,
        )

        self.assertFalse(formset.is_valid())
        self.assertIn(
            "tidak boleh dipilih lebih dari satu kali",
            formset.non_form_errors()[0],
        )
        self.assertIn("nama", formset.forms[1].errors)

    def test_pelaksana_formset_requires_minimum_one_pegawai(self):
        spt = Spt.objects.create(
            dasar="Dasar tanpa pelaksana",
            berita="Uji validasi minimal pelaksana",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Uji",
            lama_perjalanan=1,
            tgl_berangkat=date(2026, 5, 10),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )

        formset = PelaksanaFormSet(
            data={
                "pelaksana-TOTAL_FORMS": "1",
                "pelaksana-INITIAL_FORMS": "0",
                "pelaksana-MIN_NUM_FORMS": "0",
                "pelaksana-MAX_NUM_FORMS": "1000",
                "pelaksana-0-nama": "",
            },
            instance=spt,
        )

        self.assertFalse(formset.is_valid())
        self.assertIn(
            "Minimal 1 pelaksana harus dipilih",
            formset.non_form_errors()[0],
        )
        self.assertIn("nama", formset.forms[0].errors)

    def test_pelaksana_formset_rejects_departure_inside_existing_spt_range(self):
        existing_spt = Spt.objects.create(
            dasar="Dasar bentrok",
            berita="SPT pertama",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Provinsi",
            lama_perjalanan=6,
            tgl_berangkat=date(2026, 5, 10),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        existing_spt.pelaksana.create(nama=self.pegawai_eselon_iii)

        formset = PelaksanaFormSet(data={
            "tgl_berangkat": "2026-05-14",
            "pelaksana-TOTAL_FORMS": "1",
            "pelaksana-INITIAL_FORMS": "0",
            "pelaksana-MIN_NUM_FORMS": "0",
            "pelaksana-MAX_NUM_FORMS": "1000",
            "pelaksana-0-nama": str(self.pegawai_eselon_iii.pk),
        })

        self.assertFalse(formset.is_valid())
        self.assertIn(
            "Tanggal berangkat SPT baru harus lebih besar atau sama",
            formset.non_form_errors()[0],
        )
        self.assertIn("nama", formset.forms[0].errors)

    def test_pelaksana_formset_allows_departure_on_existing_return_date(self):
        existing_spt = Spt.objects.create(
            dasar="Dasar tidak bentrok",
            berita="SPT pertama",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Provinsi",
            lama_perjalanan=6,
            tgl_berangkat=date(2026, 5, 10),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        existing_spt.pelaksana.create(nama=self.pegawai_eselon_iii)

        formset = PelaksanaFormSet(data={
            "tgl_berangkat": "2026-05-15",
            "pelaksana-TOTAL_FORMS": "1",
            "pelaksana-INITIAL_FORMS": "0",
            "pelaksana-MIN_NUM_FORMS": "0",
            "pelaksana-MAX_NUM_FORMS": "1000",
            "pelaksana-0-nama": str(self.pegawai_eselon_iii.pk),
        })

        self.assertTrue(formset.is_valid(), formset.errors)

    def test_form_includes_sekretaris_daerah_for_administrator_role(self):
        user = User.objects.create_user(
            username="administrator-signatory",
            password="secret123",
        )
        user.userprofile.opd = self.opd_bk
        user.userprofile.role = self.role_administrator
        user.userprofile.save()

        request = attach_session(self.factory.get("/perintah/pemberi-tugas/form/"))
        request.user = user
        request.session["session_opd_id"] = self.opd_bk.id
        request.session["session_opd_nama"] = self.opd_bk.nama

        form = PemberiTugasForm(request=request)

        self.assertIn(self.bupati, form.fields["penandatangan"].queryset)
        self.assertIn(self.wakil_bupati, form.fields["penandatangan"].queryset)
        self.assertIn(
            self.sekretaris_daerah,
            form.fields["penandatangan"].queryset,
        )
        self.assertNotIn(self.ppk_bk, form.fields["penandatangan"].queryset)

    def test_administrator_can_select_mixed_opd_spt_and_only_get_spd_for_kepala(self):
        spt = Spt.objects.create(
            dasar="Dasar SPT campuran untuk administrator",
            berita="Koordinasi gabungan",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Gabungan",
            lama_perjalanan=1,
            tgl_berangkat=date(2026, 5, 8),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        spt.pelaksana.create(nama=self.pegawai_eselon_ii)
        spt.pelaksana.create(nama=self.pegawai_setda)
        PemberiTugas.objects.create(
            spt=spt,
            penandatangan=self.bupati,
            nomor_spt="098/ST/BUP/2026",
            tanggal_spt=date(2026, 5, 8),
        )

        user = User.objects.create_user(
            username="administrator-mixed-opd",
            password="secret123",
        )
        user.userprofile.opd = self.opd_bk
        user.userprofile.role = self.role_administrator
        user.userprofile.save()

        request = attach_session(self.factory.get("/perintah/pemberi-tugas/form/"))
        request.user = user
        request.session["session_opd_id"] = self.opd_bk.id
        request.session["session_opd_nama"] = self.opd_bk.nama

        form = PemberiTugasForm(
            data={
                "spt": spt.pk,
                "penandatangan": self.kepala_bk.pk,
                "nomor_spt": "099/ST/BK/2026",
                "tanggal_spt": "2026-05-08",
            },
            request=request,
        )

        self.assertIn(spt, form.fields["spt"].queryset)
        self.assertTrue(form.is_valid(), form.errors)

        pemberi_tugas = PemberiTugas(
            spt=spt,
            penandatangan=self.kepala_bk,
            nomor_spt="099/ST/BK/2026",
            tanggal_spt=date(2026, 5, 8),
        )
        pemberi_tugas.sync_from_penandatangan()

        self.assertFalse(pemberi_tugas.can_print_spt)
        self.assertTrue(pemberi_tugas.can_print_spd)

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

    def test_form_rejects_tanggal_spt_after_spt_departure(self):
        form = PemberiTugasForm(data={
            "spt": self.spt_spd.pk,
            "penandatangan": self.kepala_bk.pk,
            "nomor_spt": "090/ST/BK/2026",
            "tanggal_spt": "2026-05-02",
        })

        self.assertFalse(form.is_valid())
        self.assertIn("tanggal_spt", form.errors)
        self.assertIn(
            "tidak boleh lebih besar dari tanggal berangkat",
            form.errors["tanggal_spt"][0],
        )

    def test_form_allows_tanggal_spt_same_as_spt_departure(self):
        form = PemberiTugasForm(data={
            "spt": self.spt_spd.pk,
            "penandatangan": self.kepala_bk.pk,
            "nomor_spt": "090/ST/BK/2026",
            "tanggal_spt": "2026-05-01",
        })

        self.assertTrue(form.is_valid(), form.errors)

    def test_form_allows_same_spt_with_different_penandatangan(self):
        PemberiTugas.objects.create(
            spt=self.spt_bupati,
            penandatangan=self.bupati,
            nomor_spt="090/ST/BUP/2026",
            tanggal_spt=date(2026, 4, 30),
        )

        form = PemberiTugasForm(data={
            "spt": self.spt_bupati.pk,
            "penandatangan": self.kepala_bk.pk,
            "nomor_spt": "091/ST/BK/2026",
            "tanggal_spt": "2026-04-30",
        })

        self.assertTrue(form.is_valid(), form.errors)

    def test_form_rejects_duplicate_spt_and_penandatangan(self):
        PemberiTugas.objects.create(
            spt=self.spt_bupati,
            penandatangan=self.bupati,
            nomor_spt="090/ST/BUP/2026",
            tanggal_spt=date(2026, 4, 30),
        )

        form = PemberiTugasForm(data={
            "spt": self.spt_bupati.pk,
            "penandatangan": self.bupati.pk,
            "nomor_spt": "091/ST/BUP/2026",
            "tanggal_spt": "2026-04-30",
        })

        self.assertFalse(form.is_valid())
        self.assertIn("spt", form.errors)
        self.assertIn("penandatangan", form.errors)
        self.assertIn(
            "pemberi tugas yang sama sudah terdaftar",
            form.errors["spt"][0],
        )

    def test_form_allows_kepala_when_spt_has_single_eselon_two_pelaksana(self):
        form = PemberiTugasForm(data={
            "spt": self.spt_only_eselon_ii.pk,
            "penandatangan": self.kepala_bk.pk,
            "nomor_spt": "092/ST/BK/2026",
            "tanggal_spt": "2026-05-04",
        })

        self.assertTrue(form.is_valid(), form.errors)

    def test_form_allows_sekretaris_daerah_for_eselon_two_to_non_eselon(self):
        form = PemberiTugasForm(data={
            "spt": self.spt_spd.pk,
            "penandatangan": self.sekretaris_daerah.pk,
            "nomor_spt": "093/ST/SETDA/2026",
            "tanggal_spt": "2026-05-01",
        })

        self.assertTrue(form.is_valid(), form.errors)


class PemberiTugasModelTests(PerintahBaseTestCase):
    def test_save_rejects_tanggal_spt_after_spt_departure(self):
        with self.assertRaisesMessage(
            ValidationError,
            "Tanggal SPT tidak boleh lebih besar dari tanggal berangkat pada SPT.",
        ):
            PemberiTugas.objects.create(
                spt=self.spt_spd,
                penandatangan=self.kepala_bk,
                nomor_spt="094/ST/BK/2026",
                tanggal_spt=date(2026, 5, 2),
            )

    def test_save_rejects_duplicate_filled_nomor_spt(self):
        PemberiTugas.objects.create(
            spt=self.spt_bupati,
            penandatangan=self.bupati,
            nomor_spt="095/ST/BUP/2026",
            tanggal_spt=date(2026, 4, 30),
        )

        with self.assertRaisesMessage(
            ValidationError,
            "Nomor SPT sudah digunakan. Isi nomor SPT yang berbeda.",
        ):
            PemberiTugas.objects.create(
                spt=self.spt_spd,
                penandatangan=self.kepala_bk,
                nomor_spt="095/ST/BUP/2026",
                tanggal_spt=date(2026, 5, 1),
            )

    def test_save_allows_multiple_blank_document_numbers(self):
        PemberiTugas.objects.create(
            spt=self.spt_bupati,
            penandatangan=self.bupati,
            nomor_spt="",
            nomor_spd="",
            tanggal_spt=date(2026, 4, 30),
        )
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt_spd,
            penandatangan=self.kepala_bk,
            nomor_spt="",
            nomor_spd="",
            tanggal_spt=date(2026, 5, 1),
        )

        self.assertEqual(pemberi_tugas.nomor_spt, "")
        self.assertEqual(pemberi_tugas.nomor_spd, "")


class DocumentUtilsTests(PerintahBaseTestCase):
    def test_default_document_number_uses_roman_month(self):
        result = generate_default_document_number(
            "091",
            date(2026, 5, 1),
            "800.1.11.1/{nomor_urut}/BKAD/{bulan}/{tahun}",
        )

        self.assertEqual(result, "800.1.11.1/091/BKAD/V/2026")

    def test_format_spt_date_range_same_month(self):
        result = format_spt_date_range(
            date(2026, 5, 10),
            date(2026, 5, 15),
        )

        self.assertEqual(result, "10 s.d 15 Mei 2026")

    def test_format_spt_date_range_different_month(self):
        result = format_spt_date_range(
            date(2026, 5, 10),
            date(2026, 6, 1),
        )

        self.assertEqual(result, "10 Mei 2026 s.d 01 Juni 2026")

    def test_format_spt_destination_combines_multiple_locations_and_places(self):
        lokasi_kisaran = Lokasi.objects.create(
            lokasi="Kisaran",
            kota="Kisaran",
        )
        spt = Spt.objects.create(
            dasar="Dasar tujuan gabungan",
            berita="Koordinasi lintas tujuan",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Gubernur\nAula BPKAD",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 5, 10),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        spt.kota_tujuan_tambahan.add(lokasi_kisaran)

        self.assertEqual(format_spt_kota_tujuan(spt), "Medan, Kisaran")
        self.assertEqual(
            format_spt_tempat_tujuan(spt),
            "Kantor Gubernur, Aula BPKAD",
        )
        self.assertEqual(
            format_spt_tujuan_perjalanan(spt),
            "Kantor Gubernur, Aula BPKAD, Medan, Kisaran",
        )

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

    def test_table_hides_spt_button_for_single_eselon_two_kepala(self):
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt_only_eselon_ii,
            penandatangan=self.kepala_bk,
            nomor_spt="092/ST/BK/2026",
            tanggal_spt=date(2026, 5, 4),
        )
        request = self.factory.get("/perintah/pemberi-tugas/")
        request.user = self.superuser
        table = PemberiTugasTable([pemberi_tugas])
        rendered_cell = table.rows[0].get_cell("dokumen")

        self.assertFalse(pemberi_tugas.can_print_spt)
        self.assertTrue(pemberi_tugas.can_print_spd)
        self.assertNotIn("/cetak/spt/", rendered_cell)
        self.assertIn("/cetak/spd/", rendered_cell)

    def test_table_uses_htmx_preview_modal_for_print_preview(self):
        request = self.factory.get("/perintah/pemberi-tugas/")
        request.user = self.superuser
        table = PemberiTugasTable([self.pemberi_tugas_spd])
        rendered_cell = table.rows[0].get_cell("dokumen")

        self.assertIn(
            reverse(
                "pemberi_tugas_preview_spd",
                args=[self.pemberi_tugas_spd.pk],
            ),
            rendered_cell,
        )
        self.assertIn('hx-target="#print-preview-modal-body"', rendered_cell)
        self.assertNotIn("openPrintPreviewWindow", rendered_cell)
        self.assertNotIn('target="_blank"', rendered_cell)

    def test_preview_spd_renders_iframe_modal(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse(
                "pemberi_tugas_preview_spd",
                args=[self.pemberi_tugas_spd.pk],
            )
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Preview SPD")
        self.assertContains(response, "<iframe", html=False)
        self.assertContains(response, "data-print-scale-toolbar", html=False)
        self.assertContains(response, "data-print-scale-range", html=False)
        self.assertContains(response, "data-print-scale-input", html=False)
        self.assertContains(response, "data-print-scale-current-label", html=False)
        self.assertContains(response, "data-print-scale-state-label", html=False)
        self.assertContains(response, 'data-print-margin-input="top"', html=False)
        self.assertContains(response, 'data-print-margin-input="right"', html=False)
        self.assertContains(response, 'data-print-margin-input="bottom"', html=False)
        self.assertContains(response, 'data-print-margin-input="left"', html=False)
        self.assertContains(response, "data-print-margin-default-label", html=False)
        self.assertContains(response, "data-print-margin-current-label", html=False)
        self.assertContains(
            response,
            (
                reverse(
                    "pemberi_tugas_print_spd",
                    args=[self.pemberi_tugas_spd.pk],
                )
                + "?autoprint=0"
            ),
            html=False,
        )

    def test_print_spt_allows_same_origin_iframe_preview(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse(
                "pemberi_tugas_print_spt",
                args=[self.pemberi_tugas_bupati.pk],
            )
        )

        self.assertEqual(response.status_code, 200)
        self.assertEqual(
            response["X-Frame-Options"],
            "SAMEORIGIN",
        )
        self.assertIn(
            "frame-ancestors 'self'",
            response["Content-Security-Policy"],
        )

    def test_print_spt_filters_pelaksana_for_bupati(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[self.pemberi_tugas_bupati.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Bupati Asahan")
        self.assertContains(response, self.pegawai_eselon_ii.nama)
        self.assertNotContains(response, self.pegawai_eselon_iii.nama)
        self.assertRegex(
            response_html,
            (
                r'<div class="signature-identity">\s*'
                r'<div class="signature-name signature-name-no-underline">'
                r'Bupati Asahan</div>\s*'
                r'</div>'
            ),
        )
        self.assertNotContains(
            response,
            f"NIP. {format_nip(self.bupati.nip)}",
            html=False,
        )

    def test_print_spt_aligns_signature_identity_with_title_text(self):
        plt = JenisJabatan.objects.create(nama="Plt.")
        penandatangan = Penandatangan.objects.create(
            nama="Plt Kepala BKAD",
            nip="197501011999011001",
            pangkat=self.pangkat_iva,
            tugas="Kepala",
            jenis_jabatan=plt,
            opd=self.opd_bk,
        )
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt_setda,
            penandatangan=penandatangan,
            nomor_spt="092/ST/BK/2026",
            tanggal_spt=date(2026, 5, 3),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[pemberi_tugas.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'class="signature-title-prefix">Plt.')
        self.assertContains(response, 'class="signature-identity"')
        self.assertContains(response, self.pangkat_iva.pangkat)
        self.assertContains(
            response,
            f"NIP. {format_nip(penandatangan.nip)}",
            html=False,
        )

    def test_print_spt_filters_pelaksana_for_kepala(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[self.pemberi_tugas_spd.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertNotIn(
            f"<td>{self.pegawai_eselon_ii.nama}</td>",
            response_html,
        )
        self.assertIn(
            f"<td>{self.pegawai_eselon_iii.nama}</td>",
            response_html,
        )
        self.assertIn(
            f"<td>{self.pegawai_non_eselon.nama}</td>",
            response_html,
        )

    def test_print_spt_sorts_pelaksana_by_eselon_priority(self):
        spt = Spt.objects.create(
            dasar="Dasar urutan eselon",
            berita="Koordinasi urutan pelaksana",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Regional",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 5, 6),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        spt.pelaksana.create(nama=self.pegawai_non_eselon)
        spt.pelaksana.create(nama=self.pegawai_eselon_iv)
        spt.pelaksana.create(nama=self.pegawai_eselon_iii)
        pemberi_tugas = PemberiTugas.objects.create(
            spt=spt,
            penandatangan=self.kepala_bk,
            nomor_spt="094/ST/BK/2026",
            tanggal_spt=date(2026, 5, 6),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[pemberi_tugas.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertLess(
            response_html.index(self.pegawai_eselon_iii.nama),
            response_html.index(self.pegawai_eselon_iv.nama),
        )
        self.assertLess(
            response_html.index(self.pegawai_eselon_iv.nama),
            response_html.index(self.pegawai_non_eselon.nama),
        )

    def test_print_spt_filters_pelaksana_for_wakil_bupati(self):
        spt_wakil = Spt.objects.create(
            dasar="Dasar Wakil Bupati",
            berita="Koordinasi lintas perangkat daerah",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Provinsi",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 5, 5),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        spt_wakil.pelaksana.create(nama=self.pegawai_eselon_i)
        spt_wakil.pelaksana.create(nama=self.pegawai_eselon_ii)
        spt_wakil.pelaksana.create(nama=self.pegawai_eselon_iii)
        spt_wakil.pelaksana.create(nama=self.pegawai_non_eselon)
        pemberi_tugas = PemberiTugas.objects.create(
            spt=spt_wakil,
            penandatangan=self.wakil_bupati,
            nomor_spt="095/ST/WABUP/2026",
            tanggal_spt=date(2026, 5, 5),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[pemberi_tugas.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertNotIn(
            f"<td>{self.pegawai_eselon_i.nama}</td>",
            response_html,
        )
        self.assertIn(
            f"<td>{self.pegawai_eselon_ii.nama}</td>",
            response_html,
        )
        self.assertIn(
            f"<td>{self.pegawai_eselon_iii.nama}</td>",
            response_html,
        )
        self.assertIn(
            f"<td>{self.pegawai_non_eselon.nama}</td>",
            response_html,
        )

    def test_print_spt_shows_sekretaris_daerah_title_and_name_only(self):
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt_spd,
            penandatangan=self.sekretaris_daerah,
            nomor_spt="096/ST/SETDA/2026",
            tanggal_spt=date(2026, 5, 1),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[pemberi_tugas.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Sekretaris Daerah")
        self.assertRegex(
            response_html,
            (
                r'<div class="signature-identity">\s*'
                r'<div class="signature-name signature-name-no-underline">'
                r'Sekretaris Daerah Asahan</div>\s*'
                r'</div>'
            ),
        )
        self.assertNotContains(
            response,
            f"NIP. {format_nip(self.sekretaris_daerah.nip)}",
            html=False,
        )

    def test_print_spt_shows_blank_number_placeholder_when_number_empty(self):
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt_setda,
            penandatangan=self.kepala_setda,
            tanggal_spt=date(2026, 5, 1),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[pemberi_tugas.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertRegex(
            response_html,
            r'<span class="document-number-value">&nbsp;</span>',
        )

    def test_print_spt_uses_browser_native_print_scaling(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spt", args=[self.pemberi_tugas_spd.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertIn("margin: 0;", response_html)
        self.assertIn("letterhead-shell", response_html)
        self.assertIn("document-body-scale", response_html)
        self.assertIn("--content-scale: 0.96;", response_html)
        self.assertNotIn("--content-scale: 0,96;", response_html)
        self.assertIn("--letterhead-side-padding: 18mm;", response_html)
        self.assertIn("width: auto;", response_html)
        self.assertIn("zoom: var(--content-scale);", response_html)
        self.assertIn('body[data-force-print-margins="true"] .document-body-frame', response_html)
        self.assertNotIn("--preview-scale", response_html)
        self.assertNotIn("data-print-toolbar", response_html)

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

    def test_print_spd_sorts_pelaksana_by_priority_for_ppk_opd(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[self.pemberi_tugas_spd.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertIn(self.pegawai_eselon_ii.nama, response_html)
        self.assertIn(self.pegawai_eselon_iii.nama, response_html)
        self.assertIn(self.pegawai_non_eselon.nama, response_html)
        self.assertLess(
            response_html.index(self.pegawai_eselon_ii.nama),
            response_html.index(self.pegawai_eselon_iii.nama),
        )
        self.assertLess(
            response_html.index(self.pegawai_eselon_iii.nama),
            response_html.index(self.pegawai_non_eselon.nama),
        )

    def test_print_spd_filters_pelaksana_by_ppk_opd(self):
        spt = Spt.objects.create(
            dasar="Dasar SPD campuran OPD",
            berita="Koordinasi lintas OPD",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kantor Regional",
            lama_perjalanan=2,
            tgl_berangkat=date(2026, 5, 7),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        spt.pelaksana.create(nama=self.pegawai_eselon_ii)
        spt.pelaksana.create(nama=self.pegawai_eselon_iii)
        spt.pelaksana.create(nama=self.pegawai_setda)
        pemberi_tugas = PemberiTugas.objects.create(
            spt=spt,
            penandatangan=self.kepala_bk,
            nomor_spt="097/ST/BK/2026",
            tanggal_spt=date(2026, 5, 7),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[pemberi_tugas.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertIn(self.pegawai_eselon_ii.nama, response_html)
        self.assertIn(self.pegawai_eselon_iii.nama, response_html)
        self.assertNotIn(self.pegawai_setda.nama, response_html)

    def test_print_spd_shows_blank_number_placeholder_when_number_empty(self):
        pemberi_tugas = PemberiTugas.objects.create(
            spt=self.spt_without_eselon_ii,
            penandatangan=self.sekretaris_daerah,
            tanggal_spt=date(2026, 5, 1),
        )
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[pemberi_tugas.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertRegex(
            response_html,
            r'<td>&nbsp;</td>',
        )

    def test_print_spd_uses_browser_native_print_scaling(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[self.pemberi_tugas_spd.pk])
        )
        response_html = response.content.decode()

        self.assertEqual(response.status_code, 200)
        self.assertIn("margin: 0;", response_html)
        self.assertIn("letterhead-shell", response_html)
        self.assertIn("document-body-scale", response_html)
        self.assertIn("--content-scale: 0.96;", response_html)
        self.assertNotIn("--content-scale: 0,96;", response_html)
        self.assertIn("--letterhead-side-padding: 18mm;", response_html)
        self.assertIn("width: auto;", response_html)
        self.assertIn("zoom: var(--content-scale);", response_html)
        self.assertIn('body[data-force-print-margins="true"] .document-body-frame', response_html)
        self.assertNotIn("--print-scale", response_html)
        self.assertNotIn("data-print-toolbar", response_html)

    def test_print_spd_returns_404_for_bupati_signatory(self):
        self.client.force_login(self.superuser)

        response = self.client.get(
            reverse("pemberi_tugas_print_spd", args=[self.pemberi_tugas_bupati.pk])
        )

        self.assertEqual(response.status_code, 404)


class SptListViewTests(PerintahBaseTestCase):
    def test_per_page_all_falls_back_to_twenty_five_rows(self):
        superuser = User.objects.create_superuser(
            username="admin-list",
            email="admin-list@example.com",
            password="admin12345",
        )
        self.client.force_login(superuser)

        response = self.client.get(reverse("spt_list"), {"per_page": "all"})

        self.assertEqual(response.status_code, 200)
        self.assertEqual(
            response.context["table"].page.paginator.per_page,
            25,
        )
