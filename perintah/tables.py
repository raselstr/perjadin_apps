import django_tables2 as tables

from core.tables import BaseTable, render_numbered_list, action_column

from .models import Spt


class SptTable(BaseTable):
    aksi = action_column("spt_action_pk", "spt_delete")

    tempat_tujuan = tables.Column(
        verbose_name="Tempat Tujuan"
    )

    jenis_kegiatan = tables.Column(
        verbose_name="Jenis Kegiatan"
    )

    lama_perjalanan = tables.Column(
        verbose_name="Lama Perjalanan",
        accessor="lama_perjalanan_display"
    )

    tgl_berangkat = tables.DateColumn(
        verbose_name="Tgl Berangkat",
        format="d M Y"
    )

    tgl_kembali = tables.DateColumn(
        verbose_name="Tgl Kembali",
        format="d M Y"
    )

    kendaraan = tables.Column(
        verbose_name="Kendaraan",
        accessor="get_kendaraan_display"
    )

    pelaksana_list = tables.Column(
        empty_values=(),
        verbose_name="Pelaksana"
    )

    class Meta(BaseTable.Meta):
        model = Spt
        fields = (
            "no",
            "tempat_tujuan",
            "jenis_kegiatan",
            "lama_perjalanan",
            "tgl_berangkat",
            "tgl_kembali",
            "kendaraan",
            "pelaksana_list",
            "aksi",
        )

    def render_pelaksana_list(self, record):
        return render_numbered_list(
            record.pelaksana.all(),
            "nama"
        )
