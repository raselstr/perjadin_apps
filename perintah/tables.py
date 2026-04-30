import django_tables2 as tables

from core.tables import BaseTable, render_numbered_list, action_column

from .models import PemberiTugas, Spt


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


class PemberiTugasTable(BaseTable):
    dokumen = tables.TemplateColumn(
        verbose_name="Cetak",
        orderable=False,
        template_code="""
        <div class="d-flex gap-1 justify-content-center">
            <a
                class="btn btn-sm btn-outline-primary"
                href="{% url 'pemberi_tugas_print_spt' record.id %}"
                target="_blank"
                rel="noopener">
                SPT
            </a>
            {% if record.tugas != "Bupati" and record.tugas != "Wakil Bupati" %}
                <a
                    class="btn btn-sm btn-outline-info"
                    href="{% url 'pemberi_tugas_print_spd' record.id %}"
                    target="_blank"
                    rel="noopener">
                    SPD
                </a>
            {% endif %}
        </div>
        """,
    )

    aksi = action_column("pemberi_tugas_action_pk", "pemberi_tugas_delete")

    tanggal_spt = tables.DateColumn(
        verbose_name="Tanggal SPT",
        format="d M Y"
    )

    class Meta(BaseTable.Meta):
        model = PemberiTugas
        fields = (
            "no",
            "spt",
            "penandatangan",
            "nomor_spt",
            "tanggal_spt",
            "nama",
            "tugas",
            "dokumen",
            "aksi",
        )
