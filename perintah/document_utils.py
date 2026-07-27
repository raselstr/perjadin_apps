import re
from datetime import date
from functools import lru_cache

from django.db import DatabaseError, ProgrammingError, connection
from django.utils import timezone
from django.utils.formats import date_format

from umum.models import KopSurat, Pemda, Penandatangan, Tugas


GLOBAL_SIGNATORY_TASKS = ("Bupati", "Wakil Bupati")
SECRETARY_LEVEL_SIGNATORY_TASKS = ("Sekretaris Daerah", "Asisten")
HANDWRITTEN_NUMBER_SPACE = "\u00a0" * 8
ROMAN_MAP = {
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000,
}


def get_tugas_name(tugas):
    if hasattr(tugas, "nama"):
        return tugas.nama or ""
    return str(tugas or "").strip()


def get_tugas_description(tugas):
    tugas_name = get_tugas_name(tugas)
    if not tugas_name:
        return ""

    try:
        tugas_obj = Tugas.objects.filter(nama=tugas_name).first()
    except (DatabaseError, ProgrammingError):
        tugas_obj = None

    return (getattr(tugas_obj, "keterangan", "") or tugas_name).strip()


def is_assistant_signatory(penandatangan):
    tugas = get_tugas_name(getattr(penandatangan, "tugas", ""))
    jabatan = getattr(penandatangan, "jabatan", "") or ""
    return "asisten" in f"{tugas} {jabatan}".lower()


def is_secretary_level_task(tugas):
    tugas = get_tugas_name(tugas)
    return tugas in SECRETARY_LEVEL_SIGNATORY_TASKS


def is_regional_head_task(tugas):
    tugas = get_tugas_name(tugas)
    return tugas in GLOBAL_SIGNATORY_TASKS


def get_matching_pemda(opd=None):
    queryset = Pemda.objects.select_related(
        "nama_dinas",
        "kop_surat",
    ).order_by("id")

    if opd:
        pemda = queryset.filter(nama_dinas=opd).first()
        if pemda:
            return pemda

    return queryset.first()


def get_spt_letterhead_pemda(penandatangan):
    if is_assistant_signatory(penandatangan):
        sekretaris_daerah = (
            Penandatangan.objects.select_related("opd")
            .filter(tugas__nama="Sekretaris Daerah")
            .order_by("id")
            .first()
        )
        if sekretaris_daerah and sekretaris_daerah.opd:
            return get_matching_pemda(sekretaris_daerah.opd)

    return get_matching_pemda(getattr(penandatangan, "opd", None))


def get_letterhead_office_name(penandatangan, pemda=None):
    tugas = get_tugas_name(getattr(penandatangan, "tugas", ""))

    if pemda and tugas == "Bupati":
        return penandatangan.opd.nama

    if pemda and tugas == "Wakil Bupati":
        return penandatangan.opd.nama

    if pemda and pemda.nama_dinas:
        return pemda.nama_dinas.nama

    if getattr(penandatangan, "opd", None):
        return penandatangan.opd.nama

    return "Instansi"


def build_contact_line(pemda):
    if not pemda:
        return ""

    contact_parts = []
    if pemda.telepon:
        contact_parts.append(f"{pemda.telepon}")
    if pemda.email:
        contact_parts.append(f"Email: {pemda.email}")
    if pemda.website:
        contact_parts.append(f"Website: {pemda.website}")

    return " | ".join(contact_parts)


def get_kop_surat_config(pemda):
    if not pemda:
        return KopSurat()

    try:
        return pemda.kop_surat
    except KopSurat.DoesNotExist:
        return KopSurat(pemda=pemda)


def get_signature_location(pemda, default_location=""):
    if pemda and pemda.ibukota:
        return pemda.ibukota

    return default_location or "-"


def build_penandatangan_title(penandatangan):
    if not penandatangan:
        return "-"

    jenis_jabatan = ""
    jenis_jabatan_value = getattr(penandatangan, "jenis_jabatan", None)
    if hasattr(jenis_jabatan_value, "nama"):
        jenis_jabatan = jenis_jabatan_value.nama
    elif jenis_jabatan_value:
        jenis_jabatan = str(jenis_jabatan_value)

    tugas = get_tugas_name(getattr(penandatangan, "tugas", ""))

    if tugas == "PPK":
        tugas = get_tugas_description(tugas)

    if jenis_jabatan.lower() in ("definitif", "defenitif"):
        jenis_jabatan = ""

    if jenis_jabatan and tugas:
        return f"{jenis_jabatan} {tugas}".strip()

    return tugas or jenis_jabatan or "-"


def _get_jabatan_prefix(penandatangan):
    jenis_jabatan = ""
    jenis_jabatan_value = getattr(penandatangan, "jenis_jabatan", None)
    if hasattr(jenis_jabatan_value, "nama"):
        jenis_jabatan = jenis_jabatan_value.nama
    elif jenis_jabatan_value:
        jenis_jabatan = str(jenis_jabatan_value)

    if jenis_jabatan.lower() in ("definitif", "defenitif"):
        return ""

    return jenis_jabatan


def _format_kabupaten_name(pemda):
    nama_kabupaten = (getattr(pemda, "nama_kabupaten", "") or "").strip()
    if nama_kabupaten:
        if nama_kabupaten.lower().startswith("kabupaten "):
            return nama_kabupaten
        return f"Kabupaten {nama_kabupaten}"

    nama_pemda = (getattr(pemda, "nama_pemda", "") or "").strip()
    if not nama_pemda:
        return ""

    words = nama_pemda.split()
    if len(words) >= 2 and words[-2].lower() == "kabupaten":
        return f"Kabupaten {words[-1]}"

    return nama_pemda.title()


def _build_kepala_title_lines(opd_name, pemda=None):
    title_parts = ["Kepala", opd_name]
    title = " ".join(part for part in title_parts if part).strip()
    kabupaten = _format_kabupaten_name(pemda)

    if not kabupaten:
        return [title or "-"]

    daerah_marker = " Daerah"
    if daerah_marker in title:
        before_daerah, after_daerah = title.split(daerah_marker, 1)
        return [
            before_daerah,
            f"Daerah {kabupaten}{after_daerah}",
        ]

    return [f"{title} {kabupaten}".strip()]


def build_spt_signature_title_parts(penandatangan, pemda=None):
    if not penandatangan:
        return {
            "prefix": "",
            "lines": ["-"],
        }

    tugas = get_tugas_name(getattr(penandatangan, "tugas", ""))
    opd_name = ""
    if getattr(penandatangan, "opd", None):
        opd_name = penandatangan.opd.nama
    elif pemda and pemda.nama_dinas:
        opd_name = pemda.nama_dinas.nama

    if tugas in GLOBAL_SIGNATORY_TASKS:
        return {
            "prefix": "",
            "lines": [get_letterhead_office_name(penandatangan, pemda=pemda)],
        }

    if is_assistant_signatory(penandatangan):
        assistant_title = (
            (getattr(penandatangan, "jabatan", "") or "").strip()
            or tugas
        )
        lines = ["Sekretaris Daerah"]
        if assistant_title and assistant_title != "Sekretaris Daerah":
            lines.append(assistant_title)

        return {
            "prefix": "An.",
            "lines": lines,
        }

    if tugas == "Sekretaris Daerah":
        return {
            "prefix": "",
            "lines": [tugas],
        }

    if tugas == "Kepala Bidang":
        bidang_title = (getattr(penandatangan, "jabatan", "") or "").strip()
        lines = _build_kepala_title_lines(opd_name, pemda)
        if bidang_title:
            lines.append(bidang_title)

        return {
            "prefix": "An.",
            "lines": lines,
        }

    if tugas != "Kepala":
        return {
            "prefix": "",
            "lines": [opd_name or build_penandatangan_title(penandatangan)],
        }

    return {
        "prefix": _get_jabatan_prefix(penandatangan),
        "lines": _build_kepala_title_lines(opd_name, pemda),
    }


def build_spt_signature_title_lines(penandatangan, pemda=None):
    return build_spt_signature_title_parts(
        penandatangan,
        pemda=pemda,
    )["lines"]


def normalize_text(value):
    return (value or "").strip().upper()


def roman_to_int(value):
    value = normalize_text(value)
    if not value:
        return None

    total = 0
    previous = 0

    for char in reversed(value):
        current = ROMAN_MAP.get(char)
        if current is None:
            return None
        if current < previous:
            total -= current
        else:
            total += current
            previous = current

    return total


def extract_rank_level(raw_value):
    if not raw_value:
        return None

    match = re.search(r"\b([IVXLCDM]+)\b", normalize_text(raw_value))
    if not match:
        return None

    return roman_to_int(match.group(1))


def get_eselon_level(pegawai):
    eselon = getattr(pegawai, "eselon", None)
    raw_value = getattr(eselon, "eselon", eselon)
    return extract_rank_level(raw_value)


def is_eselon_two(pegawai):
    return get_eselon_level(pegawai) == 2


def is_eselon_two_to_non(pegawai):
    eselon_level = get_eselon_level(pegawai)
    return eselon_level is None or eselon_level >= 2


def is_eselon_three_to_non(pegawai):
    eselon_level = get_eselon_level(pegawai)
    return eselon_level is None or eselon_level >= 3


def _filter_pelaksana_by_opd(pelaksana_list, opd_id=None):
    if not opd_id:
        return list(pelaksana_list)

    return [
        pelaksana for pelaksana in pelaksana_list
        if getattr(pelaksana.nama, "opd_id", None) == opd_id
    ]


def get_spt_pelaksana_scope(pelaksana_list, tugas, opd_id=None):
    pelaksana_list = list(pelaksana_list)
    tugas = get_tugas_name(tugas)

    if tugas not in ("Bupati", "Wakil Bupati", *SECRETARY_LEVEL_SIGNATORY_TASKS):
        return _filter_pelaksana_by_opd(
            pelaksana_list,
            opd_id=opd_id,
        )

    return pelaksana_list


def filter_spt_pelaksana(
    pelaksana_list,
    tugas,
    opd_id=None,
    signatory_opd_id=None,
):
    tugas = get_tugas_name(tugas)
    pelaksana_list = get_spt_pelaksana_scope(
        pelaksana_list,
        tugas,
        opd_id=opd_id,
    )

    if is_secretary_level_task(tugas):
        is_active_signatory_opd = (
            opd_id
            and signatory_opd_id
            and str(opd_id) == str(signatory_opd_id)
        )
        eselon_filter = (
            is_eselon_two_to_non
            if is_active_signatory_opd
            else is_eselon_two
        )
        filtered_pelaksana = [
            pelaksana for pelaksana in pelaksana_list
            if eselon_filter(pelaksana.nama)
        ]
        return sort_pelaksana_by_priority(filtered_pelaksana)

    if tugas in ("Bupati", "Wakil Bupati"):
        filtered_pelaksana = [
            pelaksana for pelaksana in pelaksana_list
            if is_eselon_two(pelaksana.nama)
        ]
        return sort_pelaksana_by_priority(filtered_pelaksana)

    if tugas == "Kepala":
        filtered_pelaksana = [
            pelaksana for pelaksana in pelaksana_list
            if is_eselon_three_to_non(pelaksana.nama)
        ]
        return sort_pelaksana_by_priority(filtered_pelaksana)

    return sort_pelaksana_by_priority(pelaksana_list)


def filter_spd_pelaksana(pelaksana_list, opd_id=None):
    filtered_pelaksana = list(pelaksana_list)

    if opd_id:
        filtered_pelaksana = [
            pelaksana for pelaksana in filtered_pelaksana
            if getattr(pelaksana.nama, "opd_id", None) == opd_id
        ]

    return sort_pelaksana_by_priority(filtered_pelaksana)


def is_single_eselon_two_pelaksana(pelaksana_list):
    pelaksana_list = list(pelaksana_list)
    return len(pelaksana_list) == 1 and is_eselon_two(pelaksana_list[0].nama)


def _get_pangkat_rank(pegawai):
    pangkat = getattr(pegawai, "pangkat", None)
    if not pangkat:
        return (0, 0, 0)

    golongan_rank = (extract_rank_level(getattr(pangkat, "golongan", "") or "") or 0)
    ruang = (getattr(pangkat, "ruang", "") or "").strip().lower()
    has_ruang = 1 if ruang else 0
    ruang_rank = ord(ruang[0]) - 96 if ruang else 0

    return (has_ruang, golongan_rank, ruang_rank)


def _get_birthdate_sort_value(pegawai):
    return getattr(pegawai, "tgl_lahir", None) or date.max


def _get_name_sort_value(pegawai):
    return (getattr(pegawai, "nama", "") or "").strip().lower()


def _sort_key_for_eselon_priority(pelaksana):
    pegawai = pelaksana.nama
    has_ruang, golongan_rank, ruang_rank = _get_pangkat_rank(pegawai)

    return (
        get_eselon_level(pegawai) or 999,
        -has_ruang,
        -golongan_rank,
        -ruang_rank,
        _get_birthdate_sort_value(pegawai),
        _get_name_sort_value(pegawai),
    )


def sort_pelaksana_by_priority(pelaksana_list):
    return sorted(
        list(pelaksana_list),
        key=_sort_key_for_eselon_priority,
    )


def should_hide_signatory_identity_details(penandatangan):
    tugas = get_tugas_name(getattr(penandatangan, "tugas", ""))
    return tugas in ("Bupati", "Wakil Bupati", "Sekretaris Daerah")


def select_spd_primary_pelaksana(pelaksana_list):
    pelaksana_list = sort_pelaksana_by_priority(pelaksana_list)
    if not pelaksana_list:
        return None, []

    primary = pelaksana_list[0]
    followers = pelaksana_list[1:]

    return primary, followers


def can_print_spt_document(
    pelaksana_list,
    tugas,
    opd_id=None,
    signatory_opd_id=None,
):
    tugas = get_tugas_name(tugas)
    return bool(
        filter_spt_pelaksana(
            pelaksana_list,
            tugas,
            opd_id=opd_id,
            signatory_opd_id=signatory_opd_id,
        )
    )


def find_ppk_penandatangan(opd=None, fallback_opd_id=None):
    queryset = Penandatangan.objects.select_related(
        "pangkat",
        "tugas",
        "jenis_jabatan",
        "opd",
    ).filter(tugas__nama="PPK")

    if opd:
        ppk = queryset.filter(opd=opd).first()
        if ppk:
            return ppk

    if fallback_opd_id:
        ppk = queryset.filter(opd_id=fallback_opd_id).first()
        if ppk:
            return ppk

    return queryset.first()


# Month values used in document numbers
ROMAN_MONTHS = [
    "I", "II", "III", "IV", "V", "VI",
    "VII", "VIII", "IX", "X", "XI", "XII"
]


def get_roman_month(date_obj):
    if not date_obj:
        return ""
    try:
        return ROMAN_MONTHS[date_obj.month - 1]
    except (AttributeError, IndexError):
        return ""


def _join_non_empty(parts):
    seen = set()
    normalized = []
    for part in parts:
        value = str(part or "").strip()
        if not value or value in seen:
            continue
        seen.add(value)
        normalized.append(value)
    return ", ".join(normalized)


def _split_destination_text(value):
    if not value:
        return []

    parts = []
    for line in str(value).replace(";", "\n").splitlines():
        for item in line.split(","):
            item = item.strip()
            if item:
                parts.append(item)
    return parts


@lru_cache(maxsize=1)
def _has_spt_extra_destination_table():
    from .models import Spt

    table_name = Spt.kota_tujuan_tambahan.through._meta.db_table
    try:
        return table_name in connection.introspection.table_names()
    except (DatabaseError, ProgrammingError):
        return False


def format_spt_kota_tujuan(spt):
    kota_tujuan = []
    if getattr(spt, "kota_tujuan", None):
        kota_tujuan.append(spt.kota_tujuan)

    if getattr(spt, "pk", None) and _has_spt_extra_destination_table():
        try:
            kota_tujuan.extend(spt.kota_tujuan_tambahan.all())
        except (DatabaseError, ProgrammingError, ValueError):
            pass

    return _join_non_empty(kota_tujuan)


def format_spt_tempat_tujuan(spt):
    return _join_non_empty(
        _split_destination_text(getattr(spt, "tempat_tujuan", ""))
    )


def format_spt_tujuan_perjalanan(spt):
    return _join_non_empty([
        format_spt_tempat_tujuan(spt),
        format_spt_kota_tujuan(spt),
    ])


def format_spt_date_range(tgl_berangkat, tgl_kembali):
    if not tgl_berangkat:
        return ""

    if not tgl_kembali or tgl_berangkat == tgl_kembali:
        return date_format(tgl_berangkat, "d F Y")

    if (
        tgl_berangkat.month == tgl_kembali.month
        and tgl_berangkat.year == tgl_kembali.year
    ):
        return (
            f"{date_format(tgl_berangkat, 'd')} s.d "
            f"{date_format(tgl_kembali, 'd F Y')}"
        )

    return (
        f"{date_format(tgl_berangkat, 'd F Y')} s.d "
        f"{date_format(tgl_kembali, 'd F Y')}"
    )


def generate_default_document_number(
    nomor_urut,
    tanggal,
    format_template,
    is_spd=False,
    nomor_urut_placeholder=HANDWRITTEN_NUMBER_SPACE,
):
    """
    Generate default document number based on format template.

    Args:
        nomor_urut: The sequential number input from user/model
        tanggal: The date object (tgl_spt/print date)
        format_template: The format string from KopSurat
        is_spd: Whether this is for SPD (adds 'SPD' in format)
        nomor_urut_placeholder: Non-breaking space for handwritten numbers

    Returns:
        Formatted document number string
    """
    if not format_template:
        return ""

    if not tanggal:
        tanggal = timezone.localdate()

    nomor_urut_value = str(nomor_urut or "").strip()
    if not nomor_urut_value:
        nomor_urut_value = nomor_urut_placeholder

    bulan = get_roman_month(tanggal)
    tahun = tanggal.year

    # Replace placeholders in format template
    result = format_template.replace("{nomor_urut}", nomor_urut_value)
    result = result.replace("{bulan}", bulan)
    result = result.replace("{tahun}", str(tahun))

    # Clean up double slashes or empty parts
    result = result.replace("//", "/")
    result = result.strip("/")

    return result


def get_print_opd_id(pemberi_tugas):
    """
    Menentukan OPD yang digunakan untuk filtering dokumen
    ketika tidak ada request.user atau session aktif.
    """

    if getattr(pemberi_tugas, "opd_id", None):
        return pemberi_tugas.opd_id

    if getattr(pemberi_tugas.penandatangan, "opd_id", None):
        return pemberi_tugas.penandatangan.opd_id

    return None
