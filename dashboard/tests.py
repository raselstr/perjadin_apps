from datetime import date, timedelta
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

    def test_dashboard_shows_top_five_frequent_travelers(self):
        other_people = [
            Pegawai.objects.create(
                nip=f"19890101201101100{index}",
                nama=f"Pelaksana {index}",
                pangkat=self.pangkat,
                jabatan="Analis",
                jenis_jabatan=self.jenis_jabatan,
                opd=self.opd,
            )
            for index in range(2, 8)
        ]
        people = [self.pegawai, *other_people]
        frequencies = [6, 5, 4, 3, 2, 1, 7]
        target_year = 2026

        day = 1
        for pegawai, frequency in zip(people, frequencies):
            for _ in range(frequency):
                spt = Spt.objects.create(
                    dasar="Surat tugas",
                    berita="Rapat koordinasi",
                    kota_tujuan=self.lokasi,
                    tempat_tujuan="Kementerian Dalam Negeri",
                    lama_perjalanan=1,
                    tgl_berangkat=date(target_year, 5, day),
                    jenis_kegiatan=self.kegiatan,
                    kendaraan="transport_umum",
                )
                spt.pelaksana.create(nama=pegawai)
                day = day + 1 if day < 27 else 1

        self.client.force_login(self.superuser)
        session = self.client.session
        session["tahun_anggaran"] = target_year
        session.save()

        response = self.client.get(reverse("dashboard"))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Pelaksana Terbanyak")
        top_travelers = response.context["top_travelers"]
        self.assertEqual(len(top_travelers), 5)
        self.assertEqual(top_travelers[0]["nama__nama"], "Pelaksana 7")
        self.assertEqual(top_travelers[0]["total"], 7)
        self.assertNotIn(
            "Pelaksana 6",
            [row["nama__nama"] for row in top_travelers],
        )
