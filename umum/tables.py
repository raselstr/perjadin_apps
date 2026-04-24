from core.tables import BaseTable, action_column
from .models import Pegawai, Penandatangan, Pangkat, JenisJabatan, StatusASN, Tingkat


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

class TingkatTable(BaseTable):
    aksi = action_column("tingkat_action_pk", "tingkat_delete")

    class Meta(BaseTable.Meta):
        model = Tingkat
        fields = ('no', 'tingkat', 'ket', 'pesawat','kapal','keretaapian','lainnya','aksi')

class PegawaiTable(BaseTable):
    aksi = action_column("pegawai_action_pk", "pegawai_delete")

    class Meta(BaseTable.Meta):
        model = Pegawai
        fields = ('no', 'nip', 'nama', 'pangkat', 'jabatan', 'jenis_jabatan', 'status', 'tgl_lahir', 'opd','tingkat', 'aksi')

class PenandatanganTable(BaseTable):
    aksi = action_column("penandatangan_action_pk", "penandatangan_delete")

    class Meta(BaseTable.Meta):
        model = Penandatangan
        fields = ('no', 'nama', 'nip', 'pangkat', 'tugas', 'jenis_jabatan', 'opd','aksi')
