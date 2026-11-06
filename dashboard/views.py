from datetime import timedelta
from zoneinfo import ZoneInfo

from django.contrib.auth.decorators import login_required
from django.db.models import Count, Q
from django.db.models.functions import ExtractMonth
from django.shortcuts import redirect, render
from django.utils import timezone

from perintah.models import Pelaksana, Spt
from profiles.utils import get_active_opd_id
from spj.models import LaporanPerjalanan
from umum.models import Pegawai


MONTH_LABELS = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "Mei",
    "Jun",
    "Jul",
    "Agu",
    "Sep",
    "Okt",
    "Nov",
    "Des",
]


def home_redirect(request):
    if request.user.is_authenticated:
        return redirect("/dashboard/")
    return redirect("/profiles/masuk/")


def _get_today_jakarta():
    return timezone.now().astimezone(ZoneInfo("Asia/Jakarta")).date()


def _build_pelaksana_queryset(user, session_opd_id=None):
    queryset = Pelaksana.objects.select_related(
        "nama",
        "nama__opd",
        "nama__pangkat",
        "nama__tingkat",
        "spt",
        "spt__kota_tujuan",
        "spt__jenis_kegiatan",
    )

    if session_opd_id and not user.is_superuser:
        queryset = queryset.filter(nama__opd_id=session_opd_id)

    return queryset


def _build_spt_queryset(user, session_opd_id=None):
    queryset = Spt.objects.select_related(
        "kota_tujuan",
        "jenis_kegiatan",
    )

    if session_opd_id and not user.is_superuser:
        queryset = queryset.filter(
            pelaksana__nama__opd_id=session_opd_id
        ).distinct()

    return queryset


@login_required
def dashboard_view(request):
    opd = request.session.get("session_opd_nama")
    session_opd_id = get_active_opd_id(request)
    today = _get_today_jakarta()

    tahun_anggaran = request.session.get("tahun_anggaran")
    try:
        dashboard_year = int(tahun_anggaran)
    except (TypeError, ValueError):
        dashboard_year = today.year

    pelaksana_queryset = _build_pelaksana_queryset(
        request.user,
        session_opd_id=session_opd_id,
    )
    spt_queryset = _build_spt_queryset(
        request.user,
        session_opd_id=session_opd_id,
    )

    monthly_rows = (
        pelaksana_queryset.filter(spt__tgl_berangkat__year=dashboard_year)
        .annotate(month=ExtractMonth("spt__tgl_berangkat"))
        .values("month")
        .annotate(total=Count("id"))
        .order_by("month")
    )

    monthly_map = {
        row["month"]: row["total"]
        for row in monthly_rows
        if row["month"]
    }
    monthly_counts = [
        monthly_map.get(month_number, 0)
        for month_number in range(1, 13)
    ]

    today_travelers = pelaksana_queryset.filter(
        spt__tgl_berangkat__lte=today,
        spt__tgl_kembali__gte=today,
    ).order_by(
        "nama__nama",
        "spt__tgl_berangkat",
        "spt__tgl_kembali",
    )

    top_travelers = list(
        pelaksana_queryset.filter(spt__tgl_berangkat__year=dashboard_year)
        .values(
            "nama_id",
            "nama__nama",
            "nama__nip",
            "nama__jabatan",
        )
        .annotate(total=Count("id"))
        .order_by("-total", "nama__nama")[:5]
    )

    birthday_employees = Pegawai.objects.select_related("opd").filter(
        tgl_lahir__month=today.month,
        tgl_lahir__day=today.day,
    )
    if session_opd_id and not request.user.is_superuser:
        birthday_employees = birthday_employees.filter(opd_id=session_opd_id)
    birthday_employees = birthday_employees.order_by("nama")

    laporan_queryset = LaporanPerjalanan.objects.select_related(
        "spt",
        "spt__kota_tujuan",
        "spt__jenis_kegiatan",
        "pelaksana",
        "pelaksana__nama",
    ).filter(
        Q(foto_1__gt="")
        | Q(foto_2__gt="")
        | Q(foto_3__gt="")
        | Q(foto_4__gt="")
    )
    if session_opd_id and not request.user.is_superuser:
        laporan_queryset = laporan_queryset.filter(
            pelaksana__nama__opd_id=session_opd_id
        )

    laporan_photos = []
    for laporan in laporan_queryset.order_by("-created_at", "-id")[:12]:
        spt = laporan.spt
        berita_spt = (getattr(spt, "berita", None) or "").strip()
        maksud_perjalanan = (getattr(laporan, "maksud_perjalanan", None) or "").strip()
        judul_laporan = (getattr(laporan, "judul", None) or "").strip()
        tempat_tujuan = (getattr(spt, "tempat_tujuan", None) or "").strip()
        kota_tujuan = str(getattr(spt, "kota_tujuan", "") or "").strip()
        kegiatan = str(getattr(spt, "jenis_kegiatan", "") or "").strip()

        # Prioritaskan isi berita / maksud tujuan perjalanan agar tidak kosong
        teks_utama = berita_spt or maksud_perjalanan
        if not teks_utama:
            if judul_laporan and judul_laporan != f"{tempat_tujuan} - {kota_tujuan}":
                teks_utama = judul_laporan
            elif kegiatan:
                teks_utama = f"Kegiatan {kegiatan}"
            elif tempat_tujuan or kota_tujuan:
                teks_utama = f"Perjalanan Dinas ke {tempat_tujuan or kota_tujuan}"
            else:
                teks_utama = "Perjalanan Dinas"

        lokasi_display = " - ".join(p for p in [tempat_tujuan, kota_tujuan] if p)

        tgl_kembali = spt.tgl_kembali if spt else None
        if not tgl_kembali and spt and spt.tgl_berangkat and spt.lama_perjalanan:
            tgl_kembali = spt.tgl_berangkat + timedelta(days=spt.lama_perjalanan - 1)

        for field_name in ("foto_1", "foto_2", "foto_3", "foto_4"):
            photo = getattr(laporan, field_name)
            if photo:
                laporan_photos.append({
                    "url": photo.url,
                    "berita": berita_spt,
                    "maksud_perjalanan": maksud_perjalanan,
                    "judul": judul_laporan,
                    "lokasi": lokasi_display,
                    "teks": teks_utama,
                    "tgl_berangkat": spt.tgl_berangkat if spt else None,
                    "tgl_kembali": tgl_kembali,
                })
                if len(laporan_photos) == 12:
                    break
        if len(laporan_photos) == 12:
            break

    stats = {
        "total_spt_year": spt_queryset.filter(
            tgl_berangkat__year=dashboard_year
        ).count(),
        "total_pelaksana_year": pelaksana_queryset.filter(
            spt__tgl_berangkat__year=dashboard_year
        ).count(),
        "total_current_month": spt_queryset.filter(
            tgl_berangkat__year=today.year,
            tgl_berangkat__month=today.month,
        ).count(),
        "total_today": today_travelers.count(),
    }

    context = {
        "opd": opd,
        "dashboard_year": dashboard_year,
        "today": today,
        "today_travelers": today_travelers,
        "birthday_employees": birthday_employees,
        "laporan_photos": laporan_photos,
        "stats": stats,
        "chart_data": {
            "labels": MONTH_LABELS,
            "series": monthly_counts,
        },
        "top_travelers": top_travelers,
        "top_travelers_chart_data": {
            "labels": [row["nama__nama"] for row in top_travelers],
            "series": [row["total"] for row in top_travelers],
        },
        "peak_month_total": max(monthly_counts) if monthly_counts else 0,
    }

    return render(request, "dashboard/index.html", context)
