import django_tables2 as tables
from .models import DasarPeraturan, JenisSPD, JenisKegiatan, Lokasi

def action_column(url_pk, url_delete):
    return tables.TemplateColumn(
        template_name='components/crud/aksi.html',
        extra_context={
            "update_action": "update",
            "delete_action": "delete",
            "url_pk": url_pk,
            "url_delete": url_delete,
        },
        orderable=False
    )

class BaseTable(tables.Table):
    no = tables.Column(empty_values=(), verbose_name="No", orderable=False)

    def render_no(self, bound_row):
        table = bound_row.table
        page = getattr(table, "page", None)

        number = bound_row.row_counter + 1  # 🔥 fix dari 0 ke 1

        if page:
            return number + (page.number - 1) * page.paginator.per_page

        return number

    class Meta:
        template_name = "django_tables2/bootstrap5.html"
        attrs = {
            "class": "table table-hover table-bordered align-middle"
        }
    
class DasarPeraturanTable(BaseTable):
    aksi = action_column("dasar_peraturan_action_pk", "dasar_peraturan_delete")

    class Meta(BaseTable.Meta):
        model = DasarPeraturan
        fields = ('no', 'nama_peraturan', 'nomor_peraturan', 'tanggal_peraturan', 'keterangan', 'aktif', 'aksi')

class JenisSPDTable(BaseTable):
    aksi = action_column("jenis_spd_action_pk", "jenis_spd_delete")

    class Meta(BaseTable.Meta):
        model = JenisSPD
        fields = ('no', 'nama', 'aksi')

class JenisKegiatanTable(BaseTable):
    aksi = action_column("jenis_kegiatan_action_pk", "jenis_kegiatan_delete")

    class Meta(BaseTable.Meta):
        model = JenisKegiatan
        fields = ('no', 'nama', 'aksi')

class LokasiTable(BaseTable):
    aksi = action_column("lokasi_kegiatan_action_pk", "lokasi_kegiatan_delete")

    class Meta(BaseTable.Meta):
        model = Lokasi
        fields = ('no', 'lokasi', 'jenis_spd', 'aksi')

