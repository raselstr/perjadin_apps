from django.conf import settings
from django.db import transaction
from django.http import JsonResponse
from django.views import View
from django.utils.dateparse import parse_date

from perintah.models import (
    Spt,
    Pelaksana,
    PemberiTugas,
)
from spd.models import (
    Lokasi,
    JenisKegiatan,
)

from umum.models import (
    Pegawai,
    Penandatangan,
)

class CreateSptFromWAApiView(View):

    def post(self, request):

        import json

        api_key = request.headers.get("X-API-KEY")

        if api_key != settings.N8N_API_KEY:
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        try:
            payload = json.loads(request.body)

            with transaction.atomic():

                kota_tujuan = Lokasi.objects.get(
                    nama__iexact=payload["kota_tujuan"]
                )

                jenis_kegiatan = JenisKegiatan.objects.get(
                    nama__iexact=payload["jenis_kegiatan"]
                )

                spt = Spt.objects.create(
                    dasar=payload.get("dasar", ""),
                    berita=payload.get("berita", ""),
                    kota_tujuan=kota_tujuan,
                    tempat_tujuan=payload.get(
                        "tempat_tujuan",
                        ""
                    ),
                    lama_perjalanan=payload["lama_perjalanan"],
                    tgl_berangkat=parse_date(
                        payload["tgl_berangkat"]
                    ),
                    jenis_kegiatan=jenis_kegiatan,
                    kendaraan=payload.get(
                        "kendaraan",
                        "transport_umum"
                    ),
                )

                for pegawai_nama in payload.get(
                    "pelaksana",
                    []
                ):

                    pegawai = Pegawai.objects.get(
                        nama__iexact=pegawai_nama
                    )

                    Pelaksana.objects.create(
                        spt=spt,
                        nama=pegawai,
                    )

                penandatangan = (
                    Penandatangan.objects.get(
                        nama__iexact=payload[
                            "pemberi_tugas"
                        ]
                    )
                )

                pemberi_tugas = (
                    PemberiTugas.objects.create(
                        spt=spt,
                        penandatangan=penandatangan,
                    )
                )

            return JsonResponse(
                {
                    "success": True,
                    "spt_id": spt.id,
                    "pemberi_tugas_id":
                        pemberi_tugas.id,
                }
            )

        except Lokasi.DoesNotExist:
            return JsonResponse(
                {
                    "success": False,
                    "message":
                        "Kota tujuan tidak ditemukan",
                },
                status=400,
            )

        except JenisKegiatan.DoesNotExist:
            return JsonResponse(
                {
                    "success": False,
                    "message":
                        "Jenis kegiatan tidak ditemukan",
                },
                status=400,
            )

        except Pegawai.DoesNotExist:
            return JsonResponse(
                {
                    "success": False,
                    "message":
                        "Pegawai tidak ditemukan",
                },
                status=400,
            )

        except Penandatangan.DoesNotExist:
            return JsonResponse(
                {
                    "success": False,
                    "message":
                        "Pemberi tugas tidak ditemukan",
                },
                status=400,
            )

        except Exception as e:
            return JsonResponse(
                {
                    "success": False,
                    "message": str(e),
                },
                status=500,
            )