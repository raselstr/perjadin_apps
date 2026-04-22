import django_tables2 as tables
from .models import Pegawai, Penandatangan, Pangkat, JenisJabatan, StatusASN


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


class PangkatTable(BaseTable):
    aksi = action_column("pangkat_action_pk", "pangkat_delete")

    class Meta(BaseTable.Meta):
        model = Pangkat
        fields = ('no', 'pangkat', 'golongan', 'ruang', 'aksi')


class JenisJabatanTable(BaseTable):
    aksi = action_column("jenis_jabatan_action_pk", "jenis_jabatan_delete")

    class Meta(BaseTable.Meta):
        model = JenisJabatan
        fields = ('no', 'nama', 'aksi')


class StatusASNTable(BaseTable):
    aksi = action_column("status_asn_action_pk", "status_asn_delete")

    class Meta(BaseTable.Meta):
        model = StatusASN
        fields = ('no', 'nama', 'aksi')


class PegawaiTable(BaseTable):
    aksi = action_column("pegawai_action_pk", "pegawai_delete")

    class Meta(BaseTable.Meta):
        model = Pegawai
        fields = ('no', 'nip', 'nama', 'pangkat', 'jabatan', 'jenis_jabatan', 'status', 'tgl_lahir', 'opd')

class PenandatanganTable(BaseTable):
    aksi = action_column("penandatangan_action_pk", "penandatangan_delete")

    class Meta(BaseTable.Meta):
        model = Penandatangan
        fields = ('no', 'nama', 'nip', 'pangkat', 'tugas', 'jenis_jabatan', 'opd')
