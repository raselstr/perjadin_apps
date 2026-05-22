import django_tables2 as tables

from core.tables import BaseTable, action_column
from core.utils.formatting import format_indonesian_number

from .models import (
    JenisSPJ,
    Penginapan,
    Pesawat,
    Transport,
    UangHarian,
    UangRepresentasi,
)


class BuktiColumn(tables.TemplateColumn):
    def __init__(self, *args, **kwargs):
        kwargs.setdefault("orderable", False)
        kwargs.setdefault("template_code", """
            {% if record.bukti %}
                <a href="{{ record.bukti.url }}" target="_blank">Lihat</a>
            {% else %}
                -
            {% endif %}
            """)
        super().__init__(*args, **kwargs)


class SPJBaseTable(BaseTable):
    spt_info = tables.TemplateColumn(
        verbose_name="SPT",
        orderable=False,
        template_code="""
        SPT #{{ record.spt_id }}<br>
        <span class="text-muted small fst-italic">
            {{ record.spt.tujuan_perjalanan_display|default:"-" }}
        </span>
        """,
    )
    pelaksana_info = tables.TemplateColumn(
        verbose_name="Pelaksana",
        orderable=False,
        template_code="""
        {{ record.pelaksana.nama.nama }}<br>
        <span class="text-muted small fst-italic">
            {{ record.pelaksana.nama.tingkat|default:"-" }}
        </span>
        """,
    )
    standar_maksimal = tables.Column(
        empty_values=(),
        verbose_name="Standar Maksimal",
        orderable=False,
    )
    total_biaya = tables.Column(
        empty_values=(),
        verbose_name="Total",
        orderable=False,
    )

    def render_standar_maksimal(self, record):
        value = record.get_standar_maksimal()
        return "-" if value is None else format_indonesian_number(value)

    def render_total_biaya(self, record):
        return format_indonesian_number(record.total_biaya)


class JenisSPJTable(BaseTable):
    aksi = action_column("jenis_spj_action_pk", "jenis_spj_delete")

    class Meta(BaseTable.Meta):
        model = JenisSPJ
        fields = ("no", "jenis_spj", "aksi")


class PenginapanTable(SPJBaseTable):
    aksi = action_column("penginapan_action_pk", "penginapan_delete")
    bukti_link = BuktiColumn(verbose_name="Bukti")

    class Meta(BaseTable.Meta):
        model = Penginapan
        fields = (
            "no",
            "spt_info",
            "pelaksana_info",
            "nama_hotel",
            "lama_menginap",
            "harga_per_malam",
            "standar_maksimal",
            "total_biaya",
            "bukti_link",
            "aksi",
        )


class PesawatTable(SPJBaseTable):
    aksi = action_column("pesawat_action_pk", "pesawat_delete")
    bukti_link = BuktiColumn(verbose_name="Bukti")

    class Meta(BaseTable.Meta):
        model = Pesawat
        fields = (
            "no",
            "spt_info",
            "pelaksana_info",
            "jenis_spj",
            "lokasi_bandara",
            "tujuan_bandara",
            "harga_tiket",
            "standar_maksimal",
            "bukti_link",
            "aksi",
        )


class UangHarianTable(SPJBaseTable):
    aksi = action_column("uang_harian_action_pk", "uang_harian_delete")

    class Meta(BaseTable.Meta):
        model = UangHarian
        fields = (
            "no",
            "spt_info",
            "pelaksana_info",
            "uang_harian_per_hari",
            "standar_maksimal",
            "total_uang_harian",
            "aksi",
        )


class TransportTable(SPJBaseTable):
    aksi = action_column("transport_action_pk", "transport_delete")
    bukti_link = BuktiColumn(verbose_name="Bukti")

    class Meta(BaseTable.Meta):
        model = Transport
        fields = (
            "no",
            "spt_info",
            "pelaksana_info",
            "jenis_spj",
            "jenis_transportasi",
            "lokasi_berangkat",
            "tujuan",
            "biaya",
            "standar_maksimal",
            "bukti_link",
            "aksi",
        )


class UangRepresentasiTable(SPJBaseTable):
    aksi = action_column(
        "uang_representasi_action_pk",
        "uang_representasi_delete",
    )

    class Meta(BaseTable.Meta):
        model = UangRepresentasi
        fields = (
            "no",
            "spt_info",
            "pelaksana_info",
            "biaya",
            "standar_maksimal",
            "aksi",
        )
