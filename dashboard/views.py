from zoneinfo import ZoneInfo

from django.contrib.auth.decorators import login_required
from django.db.models import Count
from django.db.models.functions import ExtractMonth
from django.shortcuts import redirect, render
from django.utils import timezone

from perintah.models import Pelaksana, Spt


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
    session_opd_id = request.session.get("session_opd_id")
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
        "stats": stats,
        "chart_data": {
            "labels": MONTH_LABELS,
            "series": monthly_counts,
        },
        "peak_month_total": max(monthly_counts) if monthly_counts else 0,
    }

    return render(request, "dashboard/index.html", context)
