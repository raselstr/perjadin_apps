from django import template

from core.utils.formatting import (
    format_indonesian_number as _format_indonesian_number,
    format_nip as _format_nip,
    number_to_words as _number_to_words,
)

register = template.Library()
EMPTY_DOCUMENT_VALUES = {"", "-", "–", "—", "null", "none"}


def _meaningful_text(value):
    text = str(value or "").strip()
    if text.lower() in EMPTY_DOCUMENT_VALUES:
        return ""
    return text


@register.filter
def number_to_words(value):
    """
    Convert number to Indonesian words (terbilang).

    Usage: {{ spt.lama_perjalanan|number_to_words }}

    Examples:
        2 -> "dua"
        21 -> "dua puluh satu"
    """
    if value is None:
        return ""
    return _number_to_words(value)

@register.filter
def format_nip(value):
    """
    Format NIP (Nomor Induk Pegawai) with dots and spaces.

    Usage: {{ penandatangan.nip|format_nip }}

    Example:
        "198001012010011001" -> "19800101 2010 011 001"
    """
    if value is None:
        return ""
    return _format_nip(value)


@register.filter
def format_indonesian_number(value):
    if value is None:
        return ""
    return _format_indonesian_number(value)


@register.filter
def meaningful_text(value):
    return _meaningful_text(value)


@register.filter
def pangkat_gol_display(value):
    pangkat = _meaningful_text(getattr(value, "pangkat", value))
    golongan = _meaningful_text(getattr(value, "golongan", ""))
    ruang = _meaningful_text(getattr(value, "ruang", ""))

    golongan_ruang = ""
    if golongan and ruang:
        golongan_ruang = f"{golongan}.{ruang}"
    elif golongan:
        golongan_ruang = golongan
    elif ruang:
        golongan_ruang = ruang

    if pangkat and golongan_ruang:
        return f"{pangkat} / {golongan_ruang}"
    if pangkat:
        return pangkat
    return golongan_ruang
