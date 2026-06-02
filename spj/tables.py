import django_tables2 as tables

from core.tables import BaseTable, action_column
from core.utils.formatting import format_indonesian_number

from .models import (
    JenisSPJ,
    LaporanPerjalanan,
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
    verifikasi = tables.TemplateColumn(
        verbose_name="Verifikasi",
        orderable=False,
        template_code="""
        {% if record.verif_status == "verified" %}
          <span class="badge bg-light-success text-success">Diverifikasi</span>
        {% elif record.verif_status == "rejected" %}
          <span class="badge bg-light-danger text-danger">Ditolak</span>
        {% else %}
          <span class="badge bg-light-secondary text-secondary">Belum</span>
        {% endif %}
        """,
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
    lokasi_hotel = tables.TemplateColumn(
        verbose_name="Lokasi",
        orderable=False,
        template_code="""
        {% if record.latitude and record.longitude %}
          <a href="https://www.openstreetmap.org/?mlat={{ record.latitude }}&mlon={{ record.longitude }}#map=17/{{ record.latitude }}/{{ record.longitude }}" target="_blank" class="btn btn-sm btn-outline-primary">
            <i class="ti ti-map-pin"></i> Titik
          </a>
        {% else %}
          -
        {% endif %}
        """,
    )

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
            "lokasi_hotel",
            "verifikasi",
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
            "nama_maskapai",
            "lokasi_bandara",
            "tujuan_bandara",
            "tanggal_penerbangan",
            "harga_tiket",
            "standar_maksimal",
            "verifikasi",
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
            "verifikasi",
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
            "tanggal_berangkat",
            "biaya",
            "standar_maksimal",
            "verifikasi",
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
            "verifikasi",
            "aksi",
        )


class LaporanPerjalananTable(SPJBaseTable):
    standar_maksimal = None
    total_biaya = None
    aksi = action_column("laporan_perjalanan_action_pk", "laporan_perjalanan_delete")
    dokumen = tables.TemplateColumn(
        verbose_name="Cetak",
        orderable=False,
        template_code="""
        <a
          class="btn btn-sm btn-outline-primary"
          href="{% url 'laporan_perjalanan_print' record.id %}?autoprint=0"
          hx-get="{% url 'laporan_perjalanan_preview' record.id %}"
          hx-target="#print-preview-modal-body"
          hx-swap="innerHTML">
          Cetak
        </a>
        """,
    )
    foto = tables.TemplateColumn(
        verbose_name="Foto",
        orderable=False,
        template_code="""
        {% with total=0 %}
          {% if record.foto_1 %} <a href="{{ record.foto_1.url }}" target="_blank">1</a>{% endif %}
          {% if record.foto_2 %} <a href="{{ record.foto_2.url }}" target="_blank">2</a>{% endif %}
          {% if record.foto_3 %} <a href="{{ record.foto_3.url }}" target="_blank">3</a>{% endif %}
          {% if record.foto_4 %} <a href="{{ record.foto_4.url }}" target="_blank">4</a>{% endif %}
        {% endwith %}
        """,
    )

    class Meta(BaseTable.Meta):
        model = LaporanPerjalanan
        fields = (
            "no",
            "spt_info",
            "pelaksana_info",
            "judul",
            "foto",
            "verifikasi",
            "dokumen",
            "aksi",
        )
