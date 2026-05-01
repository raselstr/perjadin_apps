from django import template

from core.utils.formatting import number_to_words as _number_to_words

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
