from django import template

from core.utils.formatting import number_to_words as _number_to_words, format_nip as _format_nip

register = template.Library()


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