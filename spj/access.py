from profiles.utils import get_active_opd_id


def get_user_role_name(user):
    if not user or not getattr(user, "is_authenticated", False):
        return ""

    try:
        return (user.userprofile.role.nama or "").strip().lower()
    except Exception:
        return ""


def is_spj_admin_user(user):
    return bool(user and getattr(user, "is_superuser", False))


def is_spj_verifikator_user(user):
    return is_spj_admin_user(user) or get_user_role_name(user) == "verifikator"


def is_spj_pengguna_user(user):
    if user and getattr(user, "is_superuser", False):
        return False

    return get_user_role_name(user) == "pengguna"


def _opd_lookup_from_user_lookup(lookup):
    if lookup and lookup.endswith("__nip"):
        return f"{lookup[:-5]}__opd_id"
    return "pelaksana__nama__opd_id"


def filter_spj_queryset_for_user(queryset, request, lookup):
    user = getattr(request, "user", None)

    if is_spj_admin_user(user):
        return queryset

    active_opd_id = get_active_opd_id(request)
    if not active_opd_id:
        return queryset.none()

    return queryset.filter(**{_opd_lookup_from_user_lookup(lookup): active_opd_id})
