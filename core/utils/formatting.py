from decimal import Decimal, InvalidOperation
import re

MONEY_IDENTIFIER_KEYWORDS = {"biaya", "uang", "nominal", "harga", "tarif", "pagu"}


def is_money_identifier(name):
    if not name:
        return False

    normalized = str(name).strip().lower()
    tokens = [token for token in re.split(r"[_\W]+", normalized) if token]

    return any(token in MONEY_IDENTIFIER_KEYWORDS for token in tokens)


def format_indonesian_number(value):
    """
    Format angka dengan gaya Indonesia:
    - pemisah ribuan: titik
    - pemisah desimal: koma

    Jika bagian desimal hanya nol, bagian tersebut tidak ditampilkan.
    """
    if value in (None, ""):
        return ""

    try:
        decimal_value = Decimal(str(value))
    except (InvalidOperation, TypeError, ValueError):
        return value

    sign = "-" if decimal_value < 0 else ""
    normalized = format(abs(decimal_value), "f")
    whole_part, _, fraction_part = normalized.partition(".")
    whole_part = f"{int(whole_part):,}".replace(",", ".")

    if fraction_part and any(char != "0" for char in fraction_part):
        return f"{sign}{whole_part},{fraction_part}"

    return f"{sign}{whole_part}"


def parse_localized_decimal(value):
    """
    Parse input angka/currency Indonesia ke Decimal.

    Contoh input yang didukung:
    - 1500000
    - 1.500.000
    - 1.500.000,50
    - Rp1.500.000,50
    """
    if value is None:
        raise ValueError("Value tidak boleh None.")

    normalized = re.sub(r"(?i)(rp|idr)", "", str(value)).strip().replace(" ", "")

    if not normalized:
        raise ValueError("Value kosong.")

    if "," in normalized:
        normalized = normalized.replace(".", "").replace(",", ".")
    elif normalized.count(".") > 1:
        normalized = normalized.replace(".", "")
    elif normalized.count(".") == 1:
        left, right = normalized.split(".")
        if right.isdigit() and len(right) == 3 and left.lstrip("-").isdigit():
            normalized = f"{left}{right}"

    try:
        return Decimal(normalized)
    except (InvalidOperation, TypeError, ValueError) as exc:
        raise ValueError("Format angka tidak valid.") from exc
