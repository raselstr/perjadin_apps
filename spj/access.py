from profiles.utils import filter_queryset_by_active_opd


def get_user_role_name(user):
    if not user or not getattr(user, "is_authenticated", False):
        return ""

    try:
        return (user.userprofile.role.nama or "").strip().lower()
    except Exception:
        return ""


def is_spj_admin_user(user):
    return (
        bool(user and getattr(user, "is_superuser", False))
        or get_user_role_name(user) == "administrator"
    )


def is_spj_verifikator_user(user):
    return is_spj_admin_user(user) or get_user_role_name(user) == "verifikator"


def is_spj_pengguna_user(user):
    return get_user_role_name(user) == "pengguna"


def filter_spj_queryset_for_user(queryset, request, lookup):
    user = getattr(request, "user", None)

    if is_spj_admin_user(user):
        return queryset

    if is_spj_pengguna_user(user):
        return queryset.filter(**{lookup: user.username})

    return filter_queryset_by_active_opd(
        queryset,
        request,
        "pelaksana__nama__opd_id",
    )
