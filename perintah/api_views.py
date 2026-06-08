import json

from django.conf import settings
from django.core.exceptions import ValidationError
from django.db import transaction
from django.http import JsonResponse
from django.utils.dateparse import parse_date
from django.utils.decorators import method_decorator
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.db.models import Q

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


def validate_api_key(request):

    api_key = (
        request.headers.get("X-API-KEY", "")
        .strip()
    )

    return api_key == settings.N8N_API_KEY


@method_decorator(csrf_exempt, name="dispatch")
class MasterDataWAApiView(View):

    def get(self, request):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        lokasi = list(
            Lokasi.objects.order_by("lokasi")
            .values(
                "id",
                "lokasi",
            )
        )

        jenis_kegiatan = list(
            JenisKegiatan.objects.order_by("nama")
            .values(
                "id",
                "nama",
            )
        )

        penandatangan = list(
            Penandatangan.objects.order_by("nama")
            .values(
                "id",
                "nama",
                "nip",
                "tugas",
            )
        )

        return JsonResponse(
            {
                "success": True,
                "data": {
                    "lokasi": lokasi,
                    "jenis_kegiatan": jenis_kegiatan,
                    "penandatangan": penandatangan,
                }
            }
        )


@method_decorator(csrf_exempt, name="dispatch")
class SearchPegawaiWAApiView(View):

    def get(self, request):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        q = request.GET.get("q", "").strip()

        data = list(
            Pegawai.objects.filter(
                nama__icontains=q
            )
            .order_by("nama")[:20]
            .values(
                "id",
                "nama",
                "nip",
            )
        )

        return JsonResponse(
            {
                "success": True,
                "count": len(data),
                "data": data,
            }
        )

@method_decorator(csrf_exempt, name="dispatch")
class SearchLokasiWAApiView(View):

    def get(self, request):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        q = request.GET.get("q", "").strip()

        lokasi = (
            Lokasi.objects
            .filter(
                Q(lokasi__icontains=q)
                | Q(kota__icontains=q)
            )
            .order_by("lokasi")[:20]
        )

        data = [
            {
                "id": item.id,
                "lokasi": item.lokasi,
                "kota": item.kota,
                "label": (
                    f"{item.lokasi} - {item.kota}"
                    if item.kota
                    else item.lokasi
                ),
            }
            for item in lokasi
        ]

        return JsonResponse(
            {
                "success": True,
                "count": len(data),
                "data": data,
            }
        )

@method_decorator(csrf_exempt, name="dispatch")
class SearchPenandatanganWAApiView(View):

    def get(self, request):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        q = request.GET.get("q", "").strip()

        data = list(
            Penandatangan.objects.filter(
                nama__icontains=q
            )
            .order_by("nama")
            .values(
                "id",
                "nama",
                "nip",
                "tugas",
            )
        )

        return JsonResponse(
            {
                "success": True,
                "count": len(data),
                "data": data,
            }
        )


@method_decorator(csrf_exempt, name="dispatch")
class CreateSptFromWAApiView(View):

    def post(self, request):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        try:
            payload = json.loads(
                request.body.decode("utf-8")
            )

        except json.JSONDecodeError:
            return JsonResponse(
                {
                    "success": False,
                    "message": "JSON tidak valid",
                },
                status=400,
            )

        required_fields = [
            "kota_tujuan_id",
            "jenis_kegiatan_id",
            "lama_perjalanan",
            "tgl_berangkat",
            "pelaksana_ids",
            "penandatangan_id",
        ]

        missing = [
            field
            for field in required_fields
            if field not in payload
        ]

        if missing:
            return JsonResponse(
                {
                    "success": False,
                    "message": "Field wajib belum lengkap",
                    "missing": missing,
                },
                status=400,
            )

        try:

            with transaction.atomic():

                kota_tujuan = Lokasi.objects.get(
                    pk=payload["kota_tujuan_id"]
                )

                jenis_kegiatan = (
                    JenisKegiatan.objects.get(
                        pk=payload[
                            "jenis_kegiatan_id"
                        ]
                    )
                )

                penandatangan = (
                    Penandatangan.objects.get(
                        pk=payload[
                            "penandatangan_id"
                        ]
                    )
                )

                tgl_berangkat = parse_date(
                    payload["tgl_berangkat"]
                )

                if not tgl_berangkat:
                    return JsonResponse(
                        {
                            "success": False,
                            "message":
                                "Format tanggal harus YYYY-MM-DD",
                        },
                        status=400,
                    )

                spt = Spt.objects.create(
                    dasar=payload.get(
                        "dasar",
                        "",
                    ),
                    berita=payload.get(
                        "berita",
                        "",
                    ),
                    kota_tujuan=kota_tujuan,
                    tempat_tujuan=payload.get(
                        "tempat_tujuan",
                        "",
                    ),
                    lama_perjalanan=int(
                        payload[
                            "lama_perjalanan"
                        ]
                    ),
                    tgl_berangkat=tgl_berangkat,
                    jenis_kegiatan=jenis_kegiatan,
                    kendaraan=payload.get(
                        "kendaraan_dinas",
                        "transport_umum",
                    ),
                )

                jumlah_pelaksana = 0

                for pegawai_id in payload[
                    "pelaksana_ids"
                ]:

                    pegawai = (
                        Pegawai.objects.get(
                            pk=pegawai_id
                        )
                    )

                    Pelaksana.objects.create(
                        spt=spt,
                        nama=pegawai,
                    )

                    jumlah_pelaksana += 1

                pemberi_tugas = (
                    PemberiTugas.objects.create(
                        spt=spt,
                        penandatangan=penandatangan,
                    )
                )

                return JsonResponse(
                    {
                        "success": True,
                        "message":
                            "SPT berhasil dibuat",
                        "data": {
                            "spt_id": spt.id,
                            "pemberi_tugas_id":
                                pemberi_tugas.id,
                            "jumlah_pelaksana":
                                jumlah_pelaksana,
                            "tgl_berangkat":
                                str(
                                    spt.tgl_berangkat
                                ),
                            "tgl_kembali":
                                str(
                                    spt.tgl_kembali
                                ),
                        }
                    }
                )

        except Lokasi.DoesNotExist:
            return JsonResponse(
                {
                    "success": False,
                    "message":
                        "Lokasi tidak ditemukan",
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

        except Penandatangan.DoesNotExist:
            return JsonResponse(
                {
                    "success": False,
                    "message":
                        "Penandatangan tidak ditemukan",
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

        except ValidationError as e:
            return JsonResponse(
                {
                    "success": False,
                    "message": e.message_dict,
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