import django_tables2 as tables

from core.tables import BaseTable, render_numbered_list, action_column

from .models import PemberiTugas, Spt


class SptTable(BaseTable):
    aksi = action_column("spt_action_pk", "spt_delete")

    berita = tables.TemplateColumn(
        verbose_name="Maksud dan Tujuan Perjalanan Dinas",
        orderable=False,
        template_code="""
        {{ record.tempat_tujuan }}<br>
        <span class="text-muted small fst-italic">
            {{ record.berita }}
        </span>
        """
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
            "berita",
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
            {% if record.can_print_spt %}
                <a
                    class="btn btn-sm btn-outline-primary"
                    href="{% url 'pemberi_tugas_print_spt' record.id %}"
                    onclick="return window.openPrintPreviewWindow(this.href, 'print-preview-spt-{{ record.id }}');">
                    SPT
                </a>
            {% endif %}
            {% if record.can_print_spd %}
                <a
                    class="btn btn-sm btn-outline-info"
                    href="{% url 'pemberi_tugas_print_spd' record.id %}"
                    onclick="return window.openPrintPreviewWindow(this.href, 'print-preview-spd-{{ record.id }}');">
                    SPD
                </a>
            {% endif %}
        </div>
        """,
    )
    spt = tables.TemplateColumn(
        verbose_name="Maksud dan Tujuan Perjalanan Dinas",
        orderable=False,
        template_code="""
        {{ record.spt.tempat_tujuan }}<br>
        <span class="text-muted small fst-italic">
            {{ record.spt.berita }}
        </span>
        """
    )
    penandatangan = tables.TemplateColumn(
        verbose_name="Pejabat yang menugaskan",
        orderable=False,
        template_code="""
        {{ record.penandatangan.nama }}<br>
        <span class="text-muted small fst-italic">
            {{ record.penandatangan.tugas }}
        </span>
        """
    )
    

    aksi = action_column("pemberi_tugas_action_pk", "pemberi_tugas_delete")

    tanggal_spt = tables.DateColumn(
        verbose_name="Tanggal Dokumen",
        format="d M Y"
    )

    class Meta(BaseTable.Meta):
        model = PemberiTugas
        fields = (
            "no",
            "spt",
            "penandatangan",
            "nomor_spt",
            "nomor_spd",
            "tanggal_spt",
            "dokumen",
            "aksi",
        )
        
