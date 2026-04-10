import django_tables2 as tables
from .models import Pegawai


class PegawaiTable(tables.Table):
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

    class Meta:
        model = Pegawai
        template_name = "django_tables2/bootstrap5.html"
        fields = ('nip', 'nama', 'pangkat', 'jabatan', 'jenis_jabatan', 'status', 'opd')
        attrs = {
            "class": "table table-hover table-bordered align-middle"
        }