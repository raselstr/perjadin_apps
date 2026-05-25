from decimal import Decimal
from datetime import datetime
from io import BytesIO

from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from types import SimpleNamespace
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone
from django.views import View
from openpyxl import Workbook
from openpyxl.styles import Alignment, Font, PatternFill

from core.crud.base import BaseCRUDView
from perintah.models import Pelaksana, PemberiTugas

from .access import (
    filter_spj_queryset_for_user,
    is_spj_pengguna_user,
    is_spj_verifikator_user,
)
from .forms import (
    JenisSPJForm,
    LaporanPerjalananForm,
    PenginapanForm,
    PesawatForm,
    TransportForm,
    UangHarianForm,
    UangRepresentasiForm,
)
from .models import (
    JenisSPJ,
    LaporanPerjalanan,
    Penginapan,
    Pesawat,
    Transport,
    UangHarian,
    UangRepresentasi,
)
from .tables import (
    JenisSPJTable,
    LaporanPerjalananTable,
    PenginapanTable,
    PesawatTable,
    TransportTable,
    UangHarianTable,
    UangRepresentasiTable,
)


def _date_param(request, name):
    value = request.GET.get(name)
    if not value:
        return None
    try:
        return datetime.strptime(value, "%Y-%m-%d").date()
    except ValueError:
        return None


def _first_or_none(queryset):
    return queryset.first()


class SPJQuerysetMixin:
    def get_base_queryset(self):
        queryset = self.model.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "pelaksana",
            "pelaksana__nama",
            "pelaksana__nama__opd",
            "pelaksana__nama__tingkat",
        ).order_by("-id")
        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def _is_locked_for_user(self, instance):
        return (
            getattr(instance, "verif_status", None) == "verified"
            and not is_spj_verifikator_user(self.request.user)
        )

    def form_view(self, request, pk=None):
        perm = self.get_permission()
        if pk:
            if not perm or not perm.can_edit:
                return self._forbidden(request)
        else:
            if not perm or not perm.can_add:
                return self._forbidden(request)

        instance = None
        if pk:
            instance = get_object_or_404(self.get_object_queryset(), pk=pk)
            if self._is_locked_for_user(instance):
                messages.error(
                    request,
                    "Berkas SPJ sudah diverifikasi dan tidak dapat diubah.",
                )
                if request.headers.get("HX-Request"):
                    return self._forbidden(request)
                return redirect(self.url_list)

        form = self.form_class(**self.get_form_kwargs(request, instance=instance))

        if request.method == "POST" and form.is_valid():
            action = "update" if instance else "add"
            obj = form.save(commit=False)
            if is_spj_verifikator_user(request.user):
                obj.mark_verification_user(request.user)
            obj.save()
            form.save_m2m()

            if request.headers.get("HX-Request"):
                return self._build_htmx_success_response(action)

            self._add_success_message(request, action)
            return redirect(self.url_list)

        context = {
            "form": form,
            "title": self.title,
            "permission": perm,
            "is_multipart_form": form.is_multipart(),
        }

        if request.method == "POST" and request.headers.get("HX-Request"):
            return self._build_htmx_error_response(request, context, form)

        return render(request, self.template_form, context)

    def delete_view(self, request, pk):
        instance = get_object_or_404(self.get_object_queryset(), pk=pk)
        if self._is_locked_for_user(instance):
            messages.error(
                request,
                "Berkas SPJ sudah diverifikasi dan tidak dapat dihapus.",
            )
            if request.headers.get("HX-Request"):
                return self._forbidden(request)
            return redirect(self.url_list)
        return super().delete_view(request, pk)

class JenisSPJView(BaseCRUDView):
    model = JenisSPJ
    form_class = JenisSPJForm
    table_class = JenisSPJTable
    enable_excel = False

    title = "Jenis SPJ"
    url_list = "jenis_spj_list"
    url_action = "jenis_spj_action"
    url_action_pk = "jenis_spj_action_pk"


class PenginapanView(SPJQuerysetMixin, BaseCRUDView):
    model = Penginapan
    form_class = PenginapanForm
    table_class = PenginapanTable
    enable_excel = False

    title = "SPJ Penginapan"
    url_list = "penginapan_list"
    url_action = "penginapan_action"
    url_action_pk = "penginapan_action_pk"


class PesawatView(SPJQuerysetMixin, BaseCRUDView):
    model = Pesawat
    form_class = PesawatForm
    table_class = PesawatTable
    enable_excel = False

    title = "SPJ Pesawat"
    url_list = "pesawat_list"
    url_action = "pesawat_action"
    url_action_pk = "pesawat_action_pk"

    def get_base_queryset(self):
        return super().get_base_queryset().select_related(
            "jenis_spj",
            "lokasi_bandara",
            "tujuan_bandara",
        )


class UangHarianView(SPJQuerysetMixin, BaseCRUDView):
    model = UangHarian
    form_class = UangHarianForm
    table_class = UangHarianTable
    enable_excel = False

    title = "SPJ Uang Harian"
    url_list = "uang_harian_list"
    url_action = "uang_harian_action"
    url_action_pk = "uang_harian_action_pk"


class TransportView(SPJQuerysetMixin, BaseCRUDView):
    model = Transport
    form_class = TransportForm
    table_class = TransportTable
    enable_excel = False

    title = "SPJ Transport"
    url_list = "transport_list"
    url_action = "transport_action"
    url_action_pk = "transport_action_pk"

    def get_base_queryset(self):
        return super().get_base_queryset().select_related(
            "jenis_spj",
            "jenis_transportasi",
            "lokasi_berangkat",
            "tujuan",
        )


class UangRepresentasiView(SPJQuerysetMixin, BaseCRUDView):
    model = UangRepresentasi
    form_class = UangRepresentasiForm
    table_class = UangRepresentasiTable
    enable_excel = False

    title = "SPJ Uang Representasi"
    url_list = "uang_representasi_list"
    url_action = "uang_representasi_action"
    url_action_pk = "uang_representasi_action_pk"


class LaporanPerjalananView(SPJQuerysetMixin, BaseCRUDView):
    model = LaporanPerjalanan
    form_class = LaporanPerjalananForm
    table_class = LaporanPerjalananTable
    enable_excel = False

    title = "Laporan Perjalanan Dinas"
    url_list = "laporan_perjalanan_list"
    url_action = "laporan_perjalanan_action"
    url_action_pk = "laporan_perjalanan_action_pk"

    def get_base_queryset(self):
        queryset = self.model.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "pelaksana",
            "pelaksana__nama",
            "pelaksana__nama__opd",
            "pelaksana__nama__tingkat",
        ).order_by("-id")

        if is_spj_pengguna_user(self.request.user):
            return queryset.filter(
                spt__pelaksana__nama__nip=self.request.user.username,
            ).distinct()

        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def get_permission(self):
        if is_spj_pengguna_user(self.request.user):
            return SimpleNamespace(
                can_view=True,
                can_add=True,
                can_edit=True,
                can_delete=False,
            )
        return super().get_permission()


class SPJReportView(LoginRequiredMixin, View):
    template_name = "spj/report.html"

    def _filter(self, queryset):
        return filter_spj_queryset_for_user(
            queryset,
            self.request,
            "pelaksana__nama__nip",
        ).distinct()

    def _build_rows(self, request):
        start_date = _date_param(request, "tgl1")
        end_date = _date_param(request, "tgl2")
        nama_pelaksana = (request.GET.get("nama") or "").strip()
        pelaksana = Pelaksana.objects.select_related(
            "spt",
            "spt__kota_tujuan",
            "spt__jenis_kegiatan",
            "nama",
            "nama__pangkat",
            "nama__tingkat",
            "nama__opd",
        ).order_by("spt__tgl_berangkat", "nama__nama")

        pelaksana = filter_spj_queryset_for_user(
            pelaksana,
            request,
            "nama__nip",
        ).distinct()

        if start_date:
            pelaksana = pelaksana.filter(spt__tgl_berangkat__gte=start_date)
        if end_date:
            pelaksana = pelaksana.filter(spt__tgl_berangkat__lte=end_date)
        if nama_pelaksana:
            pelaksana = pelaksana.filter(nama__nama__icontains=nama_pelaksana)

        rows = []
        for item in pelaksana:
            spt = item.spt
            pemberi = PemberiTugas.objects.filter(spt=spt).first()
            pesawat_berangkat = Pesawat.objects.filter(
                spt=spt,
                pelaksana=item,
                jenis_spj__jenis_spj__iexact="Berangkat",
            ).first()
            pesawat_kembali = Pesawat.objects.filter(
                spt=spt,
                pelaksana=item,
                jenis_spj__jenis_spj__iexact="Kembali",
            ).first()
            hotel = Penginapan.objects.filter(spt=spt, pelaksana=item).first()
            uang_harian = UangHarian.objects.filter(spt=spt, pelaksana=item).first()
            representasi = UangRepresentasi.objects.filter(spt=spt, pelaksana=item).first()
            transports = Transport.objects.filter(spt=spt, pelaksana=item).select_related("jenis_spj", "tujuan")
            transport_berangkat = transports.filter(jenis_spj__jenis_spj__iexact="Berangkat").first()
            transport_kembali = transports.filter(jenis_spj__jenis_spj__iexact="Kembali").first()

            total = sum([
                getattr(uang_harian, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(representasi, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(pesawat_berangkat, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(pesawat_kembali, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(hotel, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(transport_berangkat, "total_biaya", Decimal("0")) or Decimal("0"),
                getattr(transport_kembali, "total_biaya", Decimal("0")) or Decimal("0"),
            ], Decimal("0"))

            rows.append({
                "spt": spt,
                "pelaksana": item,
                "pemberi": pemberi,
                "pesawat_berangkat": pesawat_berangkat,
                "pesawat_kembali": pesawat_kembali,
                "hotel": hotel,
                "uang_harian": uang_harian,
                "representasi": representasi,
                "transport_berangkat": transport_berangkat,
                "transport_kembali": transport_kembali,
                "total": total,
            })

        return rows, start_date, end_date, nama_pelaksana

    def _row_values(self, idx, row):
        pegawai = row["pelaksana"].nama
        pangkat = pegawai.pangkat or "-"
        tingkat = pegawai.tingkat or "-"
        spt = row["spt"]
        pemberi = row["pemberi"]
        pb = row["pesawat_berangkat"]
        pk = row["pesawat_kembali"]
        hotel = row["hotel"]
        tb = row["transport_berangkat"]
        tk = row["transport_kembali"]
        return [
            idx,
            spt.tgl_berangkat.year if spt.tgl_berangkat else "",
            spt.jenis_kegiatan,
            pegawai.nama,
            f"{pegawai.jabatan} / {pangkat} / {tingkat}",
            getattr(pemberi, "nomor_spt", "") or "-",
            getattr(pemberi, "tanggal_spt", "") or "",
            spt.tujuan_perjalanan_display,
            spt.lama_perjalanan,
            spt.tgl_berangkat,
            spt.tgl_kembali,
            getattr(pemberi, "nomor_spd", "") or "-",
            getattr(pemberi, "tanggal_spt", "") or "",
            getattr(row["uang_harian"], "total_biaya", 0) or 0,
            getattr(row["representasi"], "total_biaya", 0) or 0,
            getattr(pb, "nama_maskapai", "") or "-",
            getattr(pb, "nomor_tiket", "") or "-",
            getattr(pb, "kode_booking", "") or "-",
            getattr(pb, "tanggal_penerbangan", "") or "",
            getattr(pb, "harga_tiket", 0) or 0,
            getattr(pk, "nama_maskapai", "") or "-",
            getattr(pk, "nomor_tiket", "") or "-",
            getattr(pk, "kode_booking", "") or "-",
            getattr(pk, "tanggal_penerbangan", "") or "",
            getattr(pk, "harga_tiket", 0) or 0,
            f"{getattr(hotel, 'nama_hotel', '')} {getattr(hotel, 'alamat_hotel', '')}".strip() or "-",
            getattr(hotel, "tipe_kamar", "") or "-",
            getattr(hotel, "nomor_kamar", "") or "-",
            getattr(hotel, "tanggal_checkin", "") or "",
            getattr(hotel, "tanggal_checkout", "") or "",
            getattr(hotel, "lama_menginap", "") or "-",
            getattr(hotel, "harga_per_malam", 0) or 0,
            getattr(hotel, "total_biaya", 0) or 0,
            str(getattr(tb, "tujuan", "") or "-"),
            spt.tgl_berangkat,
            getattr(tb, "biaya", 0) or 0,
            str(getattr(tk, "tujuan", "") or "-"),
            spt.tgl_kembali,
            getattr(tk, "biaya", 0) or 0,
            row["total"],
        ]

    def _excel_response(self, rows):
        wb = Workbook()
        ws = wb.active
        ws.title = "Laporan Pengawas"
        headers = [
            "NO", "TAHUN", "JENIS PERJALANAN", "NAMA",
            "JABATAN/GOL/TINGKAT BIAYA", "NO. SPT", "TANGGAL SPT",
            "TEMPAT TUJUAN", "JUMLAH HARI", "TGL BERANGKAT", "TGL KEMBALI",
            "NO. SPD", "TANGGAL SPD", "UANG HARIAN", "REPRESENTATIF",
            "MASKAPAI BERANGKAT", "NO TIKET", "KODE BOOKING",
            "TGL PENERBANGAN", "HARGA", "MASKAPAI KEMBALI", "NO TIKET",
            "KODE BOOKING", "TGL PENERBANGAN", "HARGA",
            "NAMA DAN LOKASI HOTEL", "TIPE KAMAR", "NOMOR KAMAR",
            "TGL CHECKIN", "TGL CHECKOUT", "LAMA", "HARGA PER MALAM",
            "TOTAL HOTEL", "TRANSPORT BERANGKAT", "HARGA",
            "TRANSPORT KEMBALI", "HARGA", "TOTAL",
        ]
        ws.append(headers)
        for cell in ws[1]:
            cell.font = Font(bold=True)
            cell.fill = PatternFill("solid", fgColor="D9EAF7")
            cell.alignment = Alignment(horizontal="center", vertical="center", wrap_text=True)

        for idx, row in enumerate(rows, start=1):
            ws.append(self._row_values(idx, row))
        stream = BytesIO()
        wb.save(stream)
        response = HttpResponse(
            stream.getvalue(),
            content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        )
        response["Content-Disposition"] = 'attachment; filename="laporan-pengawas.xlsx"'
        return response

    def _pdf_response(self, rows):
        headers = [
            "NO", "TAHUN", "JENIS", "NAMA", "JAB/GOL/TINGKAT",
            "NO SPT", "TGL SPT", "TUJUAN", "HARI", "BERANGKAT",
            "KEMBALI", "NO SPD", "UANG HARIAN", "REP", "MASK B",
            "TIKET B", "BOOK B", "HARGA B", "MASK K", "TIKET K",
            "BOOK K", "HARGA K", "HOTEL", "KAMAR", "CHECKIN",
            "CHECKOUT", "TOTAL HOTEL", "TR B", "BIAYA B", "TR K",
            "BIAYA K", "TOTAL",
        ]
        column_indexes = [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
            10, 11, 13, 14, 15, 16, 17, 19, 20, 21,
            22, 24, 25, 26, 28, 29, 32, 33, 35, 36,
            38, 39,
        ]
        lines = ["LAPORAN PENGAWAS PERJALANAN DINAS", " | ".join(headers)]
        lines.append("-" * 260)
        for idx, row in enumerate(rows, start=1):
            values = self._row_values(idx, row)
            selected = [self._pdf_cell(values[i], 18) for i in column_indexes]
            lines.append(" | ".join(selected))
        content = "\n".join(lines[:120])
        objects = [
            "1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj",
            "2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj",
            "3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 842 595] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >> endobj",
            "4 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj",
        ]
        text = "BT /F1 5 Tf 18 570 Td "
        for line in content.split("\n"):
            safe = line.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")
            text += f"({safe}) Tj 0 -8 Td "
        text += "ET"
        stream = f"<< /Length {len(text.encode('latin-1', 'ignore'))} >> stream\n{text}\nendstream"
        objects.append(f"5 0 obj {stream} endobj")
        pdf = "%PDF-1.4\n"
        offsets = [0]
        for obj in objects:
            offsets.append(len(pdf.encode("latin-1")))
            pdf += obj + "\n"
        xref = len(pdf.encode("latin-1"))
        pdf += f"xref\n0 {len(objects) + 1}\n0000000000 65535 f \n"
        for offset in offsets[1:]:
            pdf += f"{offset:010d} 00000 n \n"
        pdf += f"trailer << /Size {len(objects) + 1} /Root 1 0 R >>\nstartxref\n{xref}\n%%EOF"
        response = HttpResponse(pdf.encode("latin-1", "ignore"), content_type="application/pdf")
        response["Content-Disposition"] = 'attachment; filename="laporan-pengawas.pdf"'
        return response

    @staticmethod
    def _pdf_cell(value, max_length):
        if hasattr(value, "strftime"):
            value = value.strftime("%d/%m/%Y")
        text = str(value or "-").replace("\n", " ")
        return text[: max_length - 3] + "..." if len(text) > max_length else text

    def get(self, request):
        rows, start_date, end_date, nama_pelaksana = self._build_rows(request)
        export = request.GET.get("export")
        if export == "excel":
            return self._excel_response(rows)
        if export == "pdf":
            return self._pdf_response(rows)

        grand_total = sum((row["total"] for row in rows), Decimal("0"))
        return render(request, self.template_name, {
            "title": "Laporan Pengawas",
            "rows": rows,
            "grand_total": grand_total,
            "start_date": start_date,
            "end_date": end_date,
            "nama_pelaksana": nama_pelaksana,
        })
