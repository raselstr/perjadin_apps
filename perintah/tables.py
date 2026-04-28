import django_tables2 as tables

from core.tables import BaseTable, action_column

from .models import Spt


class SptTable(BaseTable):
    aksi = action_column("spt_action_pk", "spt_delete")

    nomor_spt = tables.Column(
        verbose_name="Nomor SPT"
    )

    tanggal_spt = tables.DateColumn(
        verbose_name="Tanggal SPT",
        format="d M Y"
    )

    kota_tujuan = tables.Column(
        verbose_name="Kota Tujuan"
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
        verbose_name="Kendaraan"
    )

    pelaksana_list = tables.Column(
        empty_values=(),
        verbose_name="Pelaksana"
    )

    class Meta(BaseTable.Meta):
        model = Spt
        fields = (
            "no",
            "nomor_spt",
            "tanggal_spt",
            "kota_tujuan",
            "jenis_kegiatan",
            "lama_perjalanan",
            "tgl_berangkat",
            "tgl_kembali",
            "kendaraan",
            "pelaksana_list",
            "aksi",
        )

    def render_kendaraan(self, value):
        mapping = {
            "transport_umum": "Transport Umum",
            "kendaraan_dinas": "Kendaraan Dinas",
        }
        return mapping.get(value, "-")

    def render_pelaksana_list(self, record):
        """
        Menampilkan daftar pelaksana dalam 1 kolom
        """
        nama_pelaksana = [
            str(item.nama)
            for item in record.pelaksana.all()
        ]

        if not nama_pelaksana:
            return "-"

        return ", ".join(nama_pelaksana)
