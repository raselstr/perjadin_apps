import json
from django.shortcuts import get_object_or_404, render
from django.conf import settings
from django.core.exceptions import ValidationError
from django.db import transaction
from django.http import JsonResponse, Http404
from django.urls import reverse
from django.utils.dateparse import parse_date
from django.utils.decorators import method_decorator
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.db.models import Q, Prefetch
from django.test import RequestFactory
from urllib.parse import quote
from .utils.pdf import render_pdf
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
from perintah.views import (
    _get_default_signature_location,
    _get_primary_instansi_name,
    _build_number_from_format,
)

from perintah.document_utils import (
    get_matching_pemda,
    build_contact_line,
    build_penandatangan_title,
    build_spt_signature_title_parts,
    get_letterhead_office_name,
    get_signature_location,
    should_hide_signatory_identity_details,
    format_spt_date_range,
    filter_spt_pelaksana,
    generate_default_document_number,
    get_kop_surat_config,
    is_regional_head_task,
    find_ppk_penandatangan,
    filter_spd_pelaksana,
    select_spd_primary_pelaksana,
)
from .api_models import WaSession

@method_decorator(csrf_exempt, name="dispatch")
class WaSessionApiView(View):

    def get(self, request):

        nomor = request.GET.get("nomor")

        if not nomor:
            return JsonResponse({
                "success": False,
                "message": "nomor wajib diisi"
            }, status=400)

        try:

            session = WaSession.objects.get(
                nomor=nomor
            )

            return JsonResponse({
                "success": True,
                "exists": True,
                "data": {
                    "id": session.id,
                    "nomor": session.nomor,
                    "step": session.step,
                    "payload": session.payload,
                }
            })

        except WaSession.DoesNotExist:

            return JsonResponse({
                "success": True,
                "exists": False,
            })
    
    def post(self, request):
        try:
            body = json.loads(
                request.body.decode("utf-8")
            )

        except Exception:
            return JsonResponse({
                "success": False,
                "message": "JSON tidak valid"
            }, status=400)

        nomor = body.get("nomor")

        if not nomor:
            return JsonResponse({
                "success": False,
                "message": "nomor wajib diisi"
            }, status=400)

        session, created = (
            WaSession.objects.get_or_create(
                nomor=nomor
            )
        )

        if "step" in body:
            session.step = body["step"]

        payload = session.payload or {}

        incoming_payload = body.get(
            "payload",
            {}
        )

        if isinstance(incoming_payload, str):
            try:
                incoming_payload = json.loads(
                    incoming_payload
                )
            except Exception:
                return JsonResponse({
                    "success": False,
                    "message": "payload tidak valid"
                }, status=400)

        payload.update(
            incoming_payload
        )

        session.payload = payload

        session.save()

        return JsonResponse({
            "success": True,
            "created": created,
            "data": {
                "nomor": session.nomor,
                "step": session.step,
                "payload": session.payload,
            }
        })

    def delete(self, request):
        nomor = request.GET.get("nomor")
        if not nomor:
            return JsonResponse({
                "success": False,
                "message": "nomor wajib diisi"
            }, status=400)

        deleted, _ = (
            WaSession.objects.filter(
                nomor=nomor
            ).delete()
        )

        return JsonResponse({
            "success": True,
            "deleted": deleted > 0,
        })

def validate_api_key(request):

    api_key = (
        request.headers.get("X-API-KEY", "")
        .strip()
    )

    return api_key == settings.N8N_API_KEY


def build_absolute_named_url(request, url_name, *args):
    return request.build_absolute_uri(reverse(url_name, args=args))


def build_document_links(request, pemberi_tugas_id):
    links = {
        "spt": build_absolute_named_url(
            request,
            "pemberi_tugas_preview_spt",
            pemberi_tugas_id,
        ),
        "spd": build_absolute_named_url(
            request,
            "pemberi_tugas_preview_spd",
            pemberi_tugas_id,
        ),
        "spd_belakang": build_absolute_named_url(
            request,
            "pemberi_tugas_preview_spd_belakang",
            pemberi_tugas_id,
        ),
    }
    links["whatsapp_text"] = "\n".join([
        "Link cetak dokumen perjalanan dinas:",
        f"SPT: {links['spt']}",
        f"SPD: {links['spd']}",
        f"SPD Belakang: {links['spd_belakang']}",
    ])
    links["whatsapp_url"] = (
        "https://wa.me/?text=" + quote(links["whatsapp_text"])
    )
    return links


def document_link_response(request, pemberi_tugas, document_key):
    links = build_document_links(request, pemberi_tugas.pk)
    return JsonResponse({
        "success": True,
        "data": {
            "pemberi_tugas_id": pemberi_tugas.pk,
            "document": document_key,
            "url": links[document_key],
            "links": links,
        },
    })


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
            Lokasi.objects.order_by("id")
            .values(
                "id",
                "lokasi",
            )
        )

        jenis_kegiatan = list(
            JenisKegiatan.objects.order_by("id")
            .values(
                "id",
                "nama",
            )
        )

        penandatangan = list(
            Penandatangan.objects.order_by("id")
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
class SearchJenisKegiatanWAApiView(View):

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
            JenisKegiatan.objects.filter(
                nama__icontains=q
            )
            .order_by("nama")
            .values(
                "id",
                "nama",
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
                            "document_links": build_document_links(
                                request,
                                pemberi_tugas.id,
                            ),
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




@method_decorator(csrf_exempt, name="dispatch")
class PrintSptWAApiView(View):

    template_name = "components/pdf/spt.html"

    def get_queryset(self):

        return (
            PemberiTugas.objects
            .select_related(
                "spt",
                "spt__kota_tujuan",
                "spt__jenis_kegiatan",
                "penandatangan",
                "penandatangan__pangkat",
                "penandatangan__jenis_jabatan",
                "penandatangan__opd",
            )
            .prefetch_related(
                "spt__pelaksana",
                "spt__pelaksana__nama",
            )
        )

    def get(self, request, pk):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        pemberi_tugas = get_object_or_404(
            self.get_queryset(),
            pk=pk,
        )

        if request.GET.get("download") != "1":
            return document_link_response(request, pemberi_tugas, "spt")

        spt = pemberi_tugas.spt

        pemda = get_matching_pemda(
            pemberi_tugas.penandatangan.opd
        )

        opd_id = getattr(
            pemberi_tugas.penandatangan,
            "opd_id",
            None,
        )

        pelaksana_list = filter_spt_pelaksana(
            spt.pelaksana.all(),
            pemberi_tugas.penandatangan.tugas,
            opd_id=opd_id,
            signatory_opd_id=opd_id,
        )

        kop_surat = get_kop_surat_config(
            pemda
        )

        nomor_spt = generate_default_document_number(
            pemberi_tugas.nomor_urut,
            pemberi_tugas.tanggal_spt,
            kop_surat.default_spt_number_format,
        )

        signature_parts = (
            build_spt_signature_title_parts(
                pemberi_tugas.penandatangan,
                pemda,
            )
        )

        context = {
            "pemda": pemda,
            "pemberi_tugas": pemberi_tugas,
            "spt": spt,
            "pelaksana_list": pelaksana_list,

            "kop_office_name":
                get_letterhead_office_name(
                    pemberi_tugas.penandatangan,
                    pemda,
                ),

            "kop_contact_line":
                build_contact_line(
                    pemda,
                ),

            "kop_surat":
                kop_surat,

            "signature_title":
                build_penandatangan_title(
                    pemberi_tugas.penandatangan,
                ),

            "spt_signature_title_prefix":
                signature_parts["prefix"],

            "spt_signature_title_lines":
                signature_parts["lines"],

            "show_signature_identity_details":
                not should_hide_signatory_identity_details(
                    pemberi_tugas.penandatangan
                ),

            "signature_location":
                get_signature_location(
                    pemda,
                    default_location=(
                        spt.kota_tujuan.kota
                        if spt.kota_tujuan
                        else ""
                    ),
                ),

            "nomor_spt":
                nomor_spt,

            "kota_tujuan_text":
                spt.kota_tujuan_display,

            "tempat_tujuan_text":
                spt.tempat_tujuan_display,

            "tujuan_perjalanan_text":
                spt.tujuan_perjalanan_display,

            "tanggal_perjalanan_spt":
                format_spt_date_range(
                    spt.tgl_berangkat,
                    spt.tgl_kembali,
                ),

            "auto_print": False,
        }

        return render_pdf(
            request,
            self.template_name,
            context,
            f"SPT-{pemberi_tugas.pk}.pdf",
        )
@method_decorator(csrf_exempt, name="dispatch")
class PrintSpdWAApiView(View):

    template_name = "components/pdf/spd.html"

    def get_queryset(self):
        return (
            PemberiTugas.objects
            .select_related(
                "spt",
                "spt__kota_tujuan",
                "spt__jenis_kegiatan",
                "penandatangan",
                "penandatangan__pangkat",
                "penandatangan__jenis_jabatan",
                "penandatangan__opd",
            )
            .prefetch_related(
                Prefetch(
                    "spt__pelaksana",
                    queryset=Pelaksana.objects.select_related(
                        "nama",
                        "nama__eselon",
                        "nama__pangkat",
                        "nama__tingkat",
                        "nama__opd",
                    ).order_by("id"),
                )
            )
        )

    def build_document_context(
        self,
        pemberi_tugas,
        pemda,
        penandatangan,
    ):

        spt = pemberi_tugas.spt

        default_signature_location = (
            _get_default_signature_location(spt)
        )

        asal_instansi = _get_primary_instansi_name(
            pemda,
            penandatangan=penandatangan,
            fallback=pemberi_tugas.opd,
        )

        kop_surat = get_kop_surat_config(pemda)

        tanggal_spt = pemberi_tugas.tanggal_spt

        nomor_spt = _build_number_from_format(
            pemberi_tugas.nomor_spt,
            pemberi_tugas.nomor_urut,
            tanggal_spt,
            kop_surat.default_spt_number_format,
        )

        nomor_spd = _build_number_from_format(
            pemberi_tugas.nomor_spd,
            pemberi_tugas.nomor_urut,
            tanggal_spt,
            kop_surat.default_spd_number_format,
        )

        spt_signature_title_parts = (
            build_spt_signature_title_parts(
                penandatangan,
                pemda=pemda,
            )
        )

        return {
            "pemda": pemda,
            "pemberi_tugas": pemberi_tugas,
            "penandatangan_dokumen": penandatangan,
            "spt": spt,
            "tanggal_dokumen": tanggal_spt,
            "asal_instansi": asal_instansi,

            # pengganti _get_active_opd_name()
            "active_opd_name": asal_instansi,

            "kop_office_name": get_letterhead_office_name(
                penandatangan,
                pemda=pemda,
            ),

            "kop_contact_line": build_contact_line(
                pemda
            ),

            "kop_surat": kop_surat,

            "kop_is_regional_head": (
                is_regional_head_task(
                    getattr(
                        penandatangan,
                        "tugas",
                        "",
                    )
                )
            ),

            "signature_title": (
                build_penandatangan_title(
                    penandatangan
                )
            ),

            "spt_signature_title_prefix":
                spt_signature_title_parts["prefix"],

            "spt_signature_title_lines":
                spt_signature_title_parts["lines"],

            "show_signature_identity_details":
                not should_hide_signatory_identity_details(
                    penandatangan
                ),

            "signature_location":
                get_signature_location(
                    pemda,
                    default_location=
                    default_signature_location,
                ),

            "auto_print": False,

            "nomor_spt": nomor_spt,
            "nomor_spd": nomor_spd,

            "kota_tujuan_text":
                spt.kota_tujuan_display,

            "tempat_tujuan_text":
                spt.tempat_tujuan_display,

            "tujuan_perjalanan_text":
                spt.tujuan_perjalanan_display,

            "tanggal_perjalanan_spt":
                format_spt_date_range(
                    spt.tgl_berangkat,
                    spt.tgl_kembali,
                ),
        }

    def get(self, request, pk):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        pemberi_tugas = get_object_or_404(
            self.get_queryset(),
            pk=pk,
        )

        if is_regional_head_task(
            pemberi_tugas.penandatangan.tugas
        ):
            raise Http404(
                "SPD tidak tersedia untuk "
                "penandatangan Bupati/Wakil Bupati."
            )

        if request.GET.get("download") != "1":
            return document_link_response(request, pemberi_tugas, "spd")

        #
        # pengganti get_active_opd_id(request)
        #
        active_opd_id = (
            getattr(
                pemberi_tugas,
                "opd_id",
                None,
            )
            or getattr(
                pemberi_tugas.penandatangan,
                "opd_id",
                None,
            )
        )

        ppk = find_ppk_penandatangan(
            opd=pemberi_tugas.penandatangan.opd,
            fallback_opd_id=active_opd_id,
        ) or pemberi_tugas.penandatangan

        pemda = get_matching_pemda(
            getattr(
                ppk,
                "opd",
                None,
            )
        )

        pelaksana_list = filter_spd_pelaksana(
            pemberi_tugas.spt.pelaksana.all(),
            opd_id=(
                getattr(
                    ppk,
                    "opd_id",
                    None,
                )
                or active_opd_id
            ),
        )

        primary_pelaksana, followers = (
            select_spd_primary_pelaksana(
                pelaksana_list
            )
        )

        context = self.build_document_context(
            pemberi_tugas,
            pemda,
            ppk,
        )

        context.update({
            "primary_pelaksana": primary_pelaksana,
            "followers": followers,
            "show_followers": len(followers) > 0,
        })

        response = render_pdf(
            request,
            self.template_name,
            context,
            f"SPD-{pemberi_tugas.pk}.pdf",
        )

        response["X-Frame-Options"] = "SAMEORIGIN"

        return response
    
@method_decorator(csrf_exempt, name="dispatch")
class PrintSpdBelakangWAApiView(View):

    template_name = "components/pdf/belakang.html"

    def get(self, request, pk):

        if not validate_api_key(request):
            return JsonResponse(
                {
                    "success": False,
                    "message": "API Key tidak valid",
                },
                status=401,
            )

        pemberi_tugas = get_object_or_404(
            PemberiTugas.objects.select_related(
                "spt",
                "penandatangan",
                "penandatangan__opd",
            ),
            pk=pk,
        )

        if request.GET.get("download") != "1":
            return document_link_response(request, pemberi_tugas, "spd_belakang")

        pemda = get_matching_pemda(
            pemberi_tugas.penandatangan.opd
        )

        context = {
            "pemda": pemda,
            "pemberi_tugas": pemberi_tugas,
            "spt": pemberi_tugas.spt,
            "auto_print": False,
        }

        return render_pdf(
            request,
            self.template_name,
            context,
            f"SPDBack-{pemberi_tugas.pk}.pdf",
        )
