from datetime import timedelta
from zoneinfo import ZoneInfo

from django.contrib.auth.models import User
from django.test import TestCase
from django.urls import reverse
from django.utils import timezone

from perintah.models import Spt
from profiles.models import OPD
from spd.models import JenisKegiatan, Lokasi
from umum.models import JenisJabatan, Pangkat, Pegawai


class DashboardViewTests(TestCase):
    def setUp(self):
        self.superuser = User.objects.create_superuser(
            username="superadmin",
            email="superadmin@example.com",
            password="supersecret123",
        )
        self.opd = OPD.objects.create(nama="BKAD")
        self.pangkat = Pangkat.objects.create(
            pangkat="Pembina",
            golongan="IV",
            ruang="a",
        )
        self.jenis_jabatan = JenisJabatan.objects.create(
            nama="Definitif",
        )
        self.kegiatan = JenisKegiatan.objects.create(nama="Monitoring")
        self.lokasi = Lokasi.objects.create(lokasi="Jakarta", kota="Jakarta")
        self.pegawai = Pegawai.objects.create(
            nip="198901012011011001",
            nama="Rina Pelaksana",
            pangkat=self.pangkat,
            jabatan="Analis Anggaran",
            jenis_jabatan=self.jenis_jabatan,
            opd=self.opd,
        )

    def test_dashboard_shows_today_travelers(self):
        today = timezone.now().astimezone(ZoneInfo("Asia/Jakarta")).date()
        spt = Spt.objects.create(
            dasar="Surat tugas",
            berita="Rapat koordinasi",
            kota_tujuan=self.lokasi,
            tempat_tujuan="Kementerian Dalam Negeri",
            lama_perjalanan=3,
            tgl_berangkat=today - timedelta(days=1),
            jenis_kegiatan=self.kegiatan,
            kendaraan="transport_umum",
        )
        spt.pelaksana.create(nama=self.pegawai)

        self.client.force_login(self.superuser)
        session = self.client.session
        session["tahun_anggaran"] = today.year
        session.save()

        response = self.client.get(reverse("dashboard"))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Pelaksana Perjalanan Dinas Hari Ini")
        self.assertContains(response, self.pegawai.nama)
        self.assertEqual(response.context["stats"]["total_today"], 1)
