from decimal import Decimal

from django.test import SimpleTestCase
import django_tables2 as tables

from core.tables import BaseTable
from core.utils.formatting import (
    format_indonesian_number,
    is_money_identifier,
    parse_localized_decimal,
)
from spd.tables import StandardPenginapanTable


class DummyMoneyTable(BaseTable):
    biaya = tables.Column()
    ruang = tables.Column()


class IndonesianCurrencyFormattingTests(SimpleTestCase):
    def test_format_indonesian_number_uses_dots_for_thousands(self):
        self.assertEqual(format_indonesian_number(1500000), "1.500.000")

    def test_format_indonesian_number_keeps_non_zero_decimals(self):
        self.assertEqual(
            format_indonesian_number(Decimal("1500000.50")),
            "1.500.000,50",
        )

    def test_parse_localized_decimal_accepts_indonesian_currency_input(self):
        self.assertEqual(parse_localized_decimal("1.500.000"), Decimal("1500000"))
        self.assertEqual(
            parse_localized_decimal("Rp1.500.000,50"),
            Decimal("1500000.50"),
        )

    def test_is_money_identifier_detects_money_without_matching_ruang(self):
        self.assertTrue(is_money_identifier("biaya"))
        self.assertTrue(is_money_identifier("uang_harian"))
        self.assertFalse(is_money_identifier("ruang"))
        self.assertFalse(is_money_identifier("urutan"))

    def test_biaya_column_is_rendered_with_indonesian_format(self):
        table = StandardPenginapanTable([])

        self.assertEqual(table.render_biaya(Decimal("2500000.00")), "2.500.000")

    def test_money_columns_are_right_aligned_but_non_money_columns_are_not(self):
        table = DummyMoneyTable([])
        ruang_attrs = table.columns["ruang"].column.attrs or {}

        self.assertIn("text-end", table.columns["biaya"].column.attrs["td"]["class"])
        self.assertIn("text-end", table.columns["biaya"].column.attrs["th"]["class"])
        self.assertNotIn("td", ruang_attrs)
