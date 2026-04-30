from django.db.models import Q


GLOBAL_PENANDATANGAN_TASKS = ("Bupati", "Wakil Bupati")


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


def filter_penandatangan_queryset(
    queryset,
    request,
    opd_lookup="opd_id",
    include_global_tasks=True,
):
    active_opd_id = get_active_opd_id(request)
    if not active_opd_id:
        return queryset

    filters = Q(**{opd_lookup: active_opd_id})

    if include_global_tasks:
        filters |= Q(tugas__in=GLOBAL_PENANDATANGAN_TASKS)

    return queryset.filter(filters).distinct()
