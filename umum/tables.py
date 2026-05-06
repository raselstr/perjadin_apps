import django_tables2 as tables
from django.utils.html import format_html

from core.tables import BaseTable, action_column
from .models import (
    Eselon,
    KopSurat,
    Pegawai,
    Pemda,
    Penandatangan,
    Pangkat,
    JenisJabatan,
    StatusASN,
    Tingkat,
)


class PangkatTable(BaseTable):
    aksi = action_column("pangkat_action_pk", "pangkat_delete")

    class Meta(BaseTable.Meta):
        model = Pangkat
        fields = ('no', 'pangkat', 'golongan', 'ruang', 'aksi')


class JenisJabatanTable(BaseTable):
    aksi = action_column("jenis_jabatan_action_pk", "jenis_jabatan_delete")

    class Meta(BaseTable.Meta):
        model = JenisJabatan
        fields = ('no', 'nama', 'keterangan', 'fungsi', 'aksi')

class EselonTable(BaseTable):
    aksi = action_column("eselon_action_pk", "eselon_delete")

    class Meta(BaseTable.Meta):
        model = Eselon
        fields = ('no', 'eselon', 'keterangan', 'aksi')


class StatusASNTable(BaseTable):
    aksi = action_column("status_asn_action_pk", "status_asn_delete")

    class Meta(BaseTable.Meta):
        model = StatusASN
        fields = ('no', 'nama', 'aksi')

class TingkatTable(BaseTable):
    aksi = action_column("tingkat_action_pk", "tingkat_delete")

    class Meta(BaseTable.Meta):
        model = Tingkat
        fields = ('no', 'tingkat', 'ket', 'pesawat','kapal','keretaapian','lainnya','aksi')

class PegawaiTable(BaseTable):
    aksi = action_column("pegawai_action_pk", "pegawai_delete")

    class Meta(BaseTable.Meta):
        model = Pegawai
        fields = ('no', 'nip', 'nama', 'pangkat', 'eselon', 'jabatan', 'jenis_jabatan', 'status', 'tgl_lahir', 'opd','tingkat', 'aksi')

class PenandatanganTable(BaseTable):
    aksi = action_column("penandatangan_action_pk", "penandatangan_delete")

    class Meta(BaseTable.Meta):
        model = Penandatangan
        fields = ('no', 'nama', 'nip', 'pangkat', 'tugas', 'jenis_jabatan', 'opd','aksi')


class PemdaTable(BaseTable):
    aksi = action_column("pemda_action_pk", "pemda_delete")

    logo_preview = tables.Column(
        empty_values=(),
        verbose_name="Logo",
        orderable=False,
    )

    class Meta(BaseTable.Meta):
        model = Pemda
        fields = (
            'no',
            'logo_preview',
            'nama_pemda',
            'nama_dinas',
            'nama_kabupaten',
            'ibukota',
            'telepon',
            'email',
            'website',
            'aksi',
        )

    def render_logo_preview(self, record):
        if not record.logo:
            return "-"

        return format_html(
            '<img src="{}" alt="{}" class="rounded border" '
            'style="width:56px;height:56px;object-fit:contain;background:#fff;padding:4px;">',
            record.logo.url,
            record.nama_pemda,
        )

    def render_jenis_kop(self, record):
        return record.get_jenis_kop_display() or "-"


class KopSuratTable(BaseTable):
    aksi = action_column("kop_surat_action_pk", "kop_surat_delete")

    logo_size = tables.Column(
        empty_values=(),
        verbose_name="Ukuran Logo",
        orderable=False,
    )
    font_family_display = tables.Column(
        accessor="font_family",
        verbose_name="Jenis Font",
        orderable=False,
    )

    class Meta(BaseTable.Meta):
        model = KopSurat
        fields = (
            "no",
            "pemda.nama_dinas",
            "font_family_display",
            "region_font_size_pt",
            "office_font_size_pt",
            "address_font_size_pt",
            "contact_font_size_pt",
            "logo_size",
            "default_spt_number_format",
            "default_spd_number_format",
            "aksi",
        )

    def render_font_family_display(self, record):
        return record.get_font_family_display()

    def render_logo_size(self, record):
        return f"{record.logo_width_px} x {record.logo_height_px} px"
