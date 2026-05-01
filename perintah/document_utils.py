import re
from datetime import date

from umum.models import KopSurat, Pemda, Penandatangan


GLOBAL_SIGNATORY_TASKS = ("Bupati", "Wakil Bupati")
TUGAS_DISPLAY_MAP = dict(Penandatangan.TUGAS_CHOICES)
ROMAN_MAP = {
    "I": 1,
    "V": 5,
    "X": 10,
    "L": 50,
    "C": 100,
    "D": 500,
    "M": 1000,
}


def is_regional_head_task(tugas):
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


def get_letterhead_office_name(penandatangan, pemda=None):
    tugas = getattr(penandatangan, "tugas", "")

    if tugas == "Bupati":
        return "Bupati Asahan"

    if tugas == "Wakil Bupati":
        return "Wakil Bupati Asahan"

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
        contact_parts.append(f"Telp. {pemda.telepon}")
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

    tugas = getattr(penandatangan, "tugas", "") or ""

    if tugas == "PPK":
        tugas = TUGAS_DISPLAY_MAP.get("PPK", tugas)

    if jenis_jabatan.lower() == "definitif":
        jenis_jabatan = ""

    if jenis_jabatan and tugas:
        return f"{jenis_jabatan} {tugas}".strip()

    return tugas or jenis_jabatan or "-"


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


def is_eselon_three_to_non(pegawai):
    eselon_level = get_eselon_level(pegawai)
    return eselon_level is None or eselon_level >= 3


def filter_spt_pelaksana(pelaksana_list, tugas):
    if tugas == "Bupati":
        return [
            pelaksana for pelaksana in pelaksana_list
            if is_eselon_two(pelaksana.nama)
        ]

    if tugas == "Kepala":
        return [
            pelaksana for pelaksana in pelaksana_list
            if is_eselon_three_to_non(pelaksana.nama)
        ]

    return list(pelaksana_list)


def _get_pangkat_rank(pegawai):
    pangkat = getattr(pegawai, "pangkat", None)
    if not pangkat:
        return (0, 0)

    golongan_rank = extract_rank_level(getattr(pangkat, "golongan", ""))
    ruang = (getattr(pangkat, "ruang", "") or "").strip().lower()
    ruang_rank = ord(ruang[0]) - 96 if ruang else 0

    return (golongan_rank or 0, ruang_rank)


def _get_birthdate_sort_value(pegawai):
    return getattr(pegawai, "tgl_lahir", None) or date.max


def _get_name_sort_value(pegawai):
    return (getattr(pegawai, "nama", "") or "").strip().lower()


def _sort_key_for_eselon_priority(pelaksana):
    pegawai = pelaksana.nama
    golongan_rank, ruang_rank = _get_pangkat_rank(pegawai)

    return (
        get_eselon_level(pegawai) or 999,
        -golongan_rank,
        -ruang_rank,
        _get_birthdate_sort_value(pegawai),
        _get_name_sort_value(pegawai),
    )


def _sort_key_for_non_eselon_priority(pelaksana):
    pegawai = pelaksana.nama
    golongan_rank, ruang_rank = _get_pangkat_rank(pegawai)

    return (
        -golongan_rank,
        -ruang_rank,
        _get_birthdate_sort_value(pegawai),
        _get_name_sort_value(pegawai),
    )


def _sort_key_for_birthdate_priority(pelaksana):
    pegawai = pelaksana.nama
    return (
        _get_birthdate_sort_value(pegawai),
        _get_name_sort_value(pegawai),
    )


def select_spd_primary_pelaksana(pelaksana_list):
    pelaksana_list = list(pelaksana_list)
    if not pelaksana_list:
        return None, []

    with_eselon = [
        pelaksana for pelaksana in pelaksana_list
        if get_eselon_level(pelaksana.nama) is not None
    ]

    if with_eselon:
        primary = sorted(
            with_eselon,
            key=_sort_key_for_eselon_priority,
        )[0]
    else:
        with_pangkat = [
            pelaksana for pelaksana in pelaksana_list
            if _get_pangkat_rank(pelaksana.nama) > (0, 0)
        ]

        if with_pangkat:
            primary = sorted(
                with_pangkat,
                key=_sort_key_for_non_eselon_priority,
            )[0]
        else:
            primary = sorted(
                pelaksana_list,
                key=_sort_key_for_birthdate_priority,
            )[0]

    followers = [
        pelaksana for pelaksana in pelaksana_list
        if pelaksana.pk != primary.pk
    ]

    return primary, followers


def find_ppk_penandatangan(opd=None, fallback_opd_id=None):
    queryset = Penandatangan.objects.select_related(
        "pangkat",
        "jenis_jabatan",
        "opd",
    ).filter(tugas="PPK")

    if opd:
        ppk = queryset.filter(opd=opd).first()
        if ppk:
            return ppk

    if fallback_opd_id:
        ppk = queryset.filter(opd_id=fallback_opd_id).first()
        if ppk:
            return ppk

    return queryset.first()


# Indonesian month names
INDONESIAN_MONTHS = [
    "Januari", "Februari", "Maret", "April", "Mei", "Juni",
    "Juli", "Agustus", "September", "Oktober", "November", "Desember"
]


def get_indonesian_month(date_obj):
    """Get Indonesian month name from date object."""
    if not date_obj:
        return ""
    try:
        return INDONESIAN_MONTHS[date_obj.month - 1]
    except (AttributeError, IndexError):
        return ""


def generate_default_document_number(
    nomor_urut,
    tanggal,
    format_template,
    is_spd=False,
):
    """
    Generate default document number based on format template.

    Args:
        nomor_urut: The sequential number input from user/model
        tanggal: The date object (tgl_spt)
        format_template: The format string from KopSurat
        is_spd: Whether this is for SPD (adds 'SPD' in format)

    Returns:
        Formatted document number string
    """
    if not tanggal:
        return ""

    bulan = get_indonesian_month(tanggal)
    tahun = tanggal.year

    # Replace placeholders in format template
    result = format_template.replace("{nomor_urut}", str(nomor_urut or ""))
    result = result.replace("{bulan}", bulan)
    result = result.replace("{tahun}", str(tahun))

    # Clean up double slashes or empty parts
    result = result.replace("//", "/")
    result = result.strip("/")

    return result
