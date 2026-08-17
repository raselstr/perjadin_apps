from django.db.models import Q


GLOBAL_PENANDATANGAN_TASKS = ("Bupati", "Wakil Bupati")
ADMINISTRATOR_GLOBAL_PENANDATANGAN_TASKS = (
    "Bupati",
    "Wakil Bupati",
    "Sekretaris Daerah",
    "Asisten",
)
ADMINISTRATOR_ROLE_NAMES = {"administrator", "administrasi"}
PENGGUNA_ROLE_NAME = "pengguna"


def get_user_role_name(user):
    if not user or not getattr(user, "is_authenticated", False):
        return ""

    try:
        role_name = user.userprofile.role.nama or ""
    except Exception:
        return ""

    return role_name.strip().lower()


def is_administrator_user(user):
    if not user or not getattr(user, "is_authenticated", False):
        return False

    return get_user_role_name(user) in ADMINISTRATOR_ROLE_NAMES


def is_administrator_request(request):
    return is_administrator_user(getattr(request, "user", None))


def is_pengguna_user(user):
    if not user or not getattr(user, "is_authenticated", False):
        return False
    if getattr(user, "is_superuser", False):
        return False

    return get_user_role_name(user) == PENGGUNA_ROLE_NAME


def get_pengguna_nip(user):
    if not is_pengguna_user(user):
        return ""

    return (getattr(user, "username", "") or "").strip()


def get_global_penandatangan_tasks(request=None):
    if is_administrator_request(request):
        return ADMINISTRATOR_GLOBAL_PENANDATANGAN_TASKS

    return GLOBAL_PENANDATANGAN_TASKS


def get_active_opd_id(request):
    if not request:
        return None

    user = getattr(request, "user", None)
    if not user or not user.is_authenticated or user.is_superuser:
        return None

    session_opd_id = request.session.get("session_opd_id")
    if session_opd_id:
        return session_opd_id

    try:
        return user.userprofile.opd_id
    except Exception:
        return None


def filter_queryset_by_active_opd(queryset, request, lookup):
    active_opd_id = get_active_opd_id(request)
    if not active_opd_id:
        return queryset

    return queryset.filter(**{lookup: active_opd_id})


def filter_queryset_by_pengguna_or_active_opd(
    queryset,
    request,
    opd_lookup,
    nip_lookup,
):
    pengguna_nip = get_pengguna_nip(getattr(request, "user", None))
    if pengguna_nip:
        return queryset.filter(**{nip_lookup: pengguna_nip})

    return filter_queryset_by_active_opd(queryset, request, opd_lookup)


def filter_penandatangan_queryset(
    queryset,
    request,
    opd_lookup="opd_id",
    include_global_tasks=True,
    exclude_tasks=None,
):
    active_opd_id = get_active_opd_id(request)
    result_queryset = queryset

    if active_opd_id:
        filters = Q(**{opd_lookup: active_opd_id})

        if include_global_tasks:
            filters |= Q(tugas__nama__in=get_global_penandatangan_tasks(request))

        result_queryset = queryset.filter(filters).distinct()

    if exclude_tasks:
        result_queryset = result_queryset.exclude(tugas__nama__in=exclude_tasks)

    return result_queryset
