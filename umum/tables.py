import django_tables2 as tables
from .models import Pegawai


class PegawaiTable(tables.Table):
    no = tables.Column(empty_values=(), verbose_name="No", orderable=False)

    aksi = tables.TemplateColumn(
        template_name='components/crud/aksi.html',
        extra_context={
            "update_action": "update",
            "delete_action": "delete",
            "url_pk": "pegawai_action_pk",
            "url_delete": "pegawai_delete",
        },
        orderable=False
    )

    def render_no(self, bound_row):
        table = bound_row.table
        page = getattr(table, "page", None)

        number = bound_row.row_counter + 1  # 🔥 fix dari 0 ke 1

        if page:
            return number + (page.number - 1) * page.paginator.per_page

        return number
    
    class Meta:
        model = Pegawai
        template_name = "django_tables2/bootstrap5.html"
        fields = ('no', 'nip', 'nama', 'pangkat', 'jabatan', 'jenis_jabatan', 'status', 'opd')
        attrs = {
            "class": "table table-hover table-bordered align-middle"
        }