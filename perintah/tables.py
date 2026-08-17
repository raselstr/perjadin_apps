import django_tables2 as tables

from core.tables import BaseTable, render_numbered_list, action_column

from .models import PemberiTugas, Spt, TtdSptSpd


class SptTable(BaseTable):
    aksi = tables.TemplateColumn(
        verbose_name="Aksi",
        orderable=False,
        extra_context={
            "update_action": "update",
            "delete_action": "delete",
            "copy_action": "copy",
        },
        template_code="""
        <div class="d-flex gap-1 justify-content-center">
            <button
                class="btn btn-sm btn-outline-warning d-flex align-items-center justify-content-center"
                style="width:32px;height:32px"
                hx-get="{% url 'spt_action_pk' record.id update_action %}"
                hx-target="#modal-body"
                data-bs-toggle="modal"
                data-bs-target="#modal"
                title="Edit">
                <i class="ti ti-pencil"></i>
            </button>
            <form method="post" action="{% url 'spt_action_pk' record.id copy_action %}" class="d-inline">
                {% csrf_token %}
                <button
                    class="btn btn-sm btn-outline-info d-flex align-items-center justify-content-center"
                    style="width:32px;height:32px"
                    type="submit"
                    title="Copy SPT">
                    <i class="ti ti-copy"></i>
                </button>
            </form>
            <button
                class="btn btn-sm btn-outline-danger d-flex align-items-center justify-content-center"
                style="width:32px;height:32px"
                hx-get="{% url 'spt_delete' record.id delete_action %}"
                hx-target="#modal-body"
                data-bs-toggle="modal"
                data-bs-target="#modal"
                title="Hapus">
                <i class="ti ti-trash"></i>
            </button>
        </div>
        """,
    )

    spt_id = tables.TemplateColumn(
        verbose_name="ID SPT",
        orderable=False,
        template_code="SPT #{{ record.pk }}",
    )

    berita = tables.TemplateColumn(
        verbose_name="Maksud dan Tujuan Perjalanan Dinas",
        orderable=False,
        template_code="""
        {{ record.tujuan_perjalanan_display|default:"-" }}<br>
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
            "spt_id",
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

    spt_id = tables.TemplateColumn(
        verbose_name="ID SPT",
        orderable=False,
        template_code="SPT #{{ record.spt_id }}",
    )
    
    dokumen = tables.TemplateColumn(
        verbose_name="Cetak",
        orderable=False,
        template_code="""
        <div class="d-flex gap-1 justify-content-center">
            {% if record.can_print_spt %}
                <a
                    class="btn btn-sm btn-outline-primary"
                    href="{% url 'pemberi_tugas_print_spt' record.id %}?autoprint=0"
                    hx-get="{% url 'pemberi_tugas_preview_spt' record.id %}"
                    hx-target="#print-preview-modal-body"
                    hx-swap="innerHTML">
                    SPT
                </a>
            {% endif %}
            {% if record.can_print_spd %}
                <a
                    class="btn btn-sm btn-outline-info"
                    href="{% url 'pemberi_tugas_print_spd' record.id %}?autoprint=0"
                    hx-get="{% url 'pemberi_tugas_preview_spd' record.id %}"
                    hx-target="#print-preview-modal-body"
                    hx-swap="innerHTML">
                    SPD
                </a>

                <a
                    class="btn btn-sm btn-outline-danger"
                    href="{% url 'pemberi_tugas_print_spd_belakang' record.id %}?autoprint=0"
                    hx-get="{% url 'pemberi_tugas_preview_spd_belakang' record.id %}"
                    hx-target="#print-preview-modal-body"
                    hx-swap="innerHTML">
                    Back
                </a>
            {% endif %}
        </div>
        """,
    )
    spt = tables.TemplateColumn(
        verbose_name="Maksud dan Tujuan Perjalanan Dinas",
        orderable=False,
        template_code="""
        {{ record.spt.tujuan_perjalanan_display|default:"-" }}<br>
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
            "spt_id",
            "spt",
            "penandatangan",
            "nomor_spt",
            "nomor_spd",
            "tanggal_spt",
            "dokumen",
            "aksi",
        )

class TtdSptSpdTable(BaseTable):
    spt_id = tables.TemplateColumn(
        verbose_name="ID SPT",
        orderable=False,
        template_code="SPT #{{ record.pemberi_tugas.spt_id }}",
    )

    spt = tables.TemplateColumn(
        verbose_name="Maksud dan Tujuan Perjalanan Dinas",
        orderable=False,
        template_code="""
        {{ record.pemberi_tugas.spt.tujuan_perjalanan_display|default:"-" }}<br>
        <span class="text-muted small fst-italic">
            {{ record.pemberi_tugas.spt.berita }}
        </span>
        """
    )

    hardcopy_status = tables.TemplateColumn(
        verbose_name="File Hardcopy",
        orderable=False,
        template_code="""
        {% if record.hardcopy %}
            <span class="badge bg-success">Ada</span>
        {% else %}
            <span class="badge bg-warning">Belum Upload</span>
        {% endif %}
        """
    )

    aksi = tables.TemplateColumn(
        verbose_name="Aksi",
        orderable=False,
        template_code="""
        <div class="d-flex gap-1 justify-content-center">
            <input type="file" 
                   id="file-upload-{{ record.id }}" 
                   class="d-none pdf-file-input"
                   accept="application/pdf"
                   data-ttd-id="{{ record.id }}">
            <button class="btn btn-sm btn-outline-primary upload-pdf-btn"
                    type="button"
                    data-ttd-id="{{ record.id }}"
                    onclick="document.getElementById('file-upload-{{ record.id }}').click();">
                Upload
            </button>
            {% if record.hardcopy %}
                <button class="btn btn-sm btn-outline-info"
                        hx-get="{% url 'ttd_spt_spd_view_modal' record.id %}"
                        hx-target="#modal-body"
                        hx-trigger="click">
                    Lihat
                </button>
            {% endif %}
        </div>
        """
    )

    class Meta(BaseTable.Meta):
        model = TtdSptSpd
        fields = (
            "no",
            "spt_id",
            "spt",
            "pemberi_tugas",
            "hardcopy_status",
            "aksi",
        )
