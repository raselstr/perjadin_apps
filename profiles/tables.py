from core.tables import BaseTable, action_column
from .models import OPD, Role, UserProfile


class OPDTable(BaseTable):
    aksi = action_column("opd_action_pk", "opd_delete")

    class Meta(BaseTable.Meta):
        model = OPD
        fields = ('no', 'nama', 'aksi')


class RoleTable(BaseTable):
    aksi = action_column("role_action_pk", "role_delete")

    class Meta(BaseTable.Meta):
        model = Role
        fields = ('no', 'nama', 'aksi')


class UserProfileTable(BaseTable):
    aksi = action_column("userprofile_action_pk", "userprofile_delete")

    class Meta(BaseTable.Meta):
        model = UserProfile
        fields = ('no', 'user', 'opd', 'role', 'aksi')
