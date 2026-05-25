from django import template

from umum.models import Pegawai


register = template.Library()


@register.simple_tag
def user_initials(user):
    name = (
        f"{getattr(user, 'first_name', '')} {getattr(user, 'last_name', '')}".strip()
        or getattr(user, "username", "")
    )
    parts = [part for part in name.split() if part]
    if not parts:
        return "U"
    if len(parts) == 1:
        return parts[0][:2].upper()
    return f"{parts[0][0]}{parts[-1][0]}".upper()


@register.simple_tag
def user_photo_url(user):
    try:
        if user.userprofile.foto:
            return user.userprofile.foto.url
    except Exception:
        pass

    pegawai = Pegawai.objects.filter(nip=getattr(user, "username", "")).first()
    if pegawai and pegawai.foto:
        try:
            return pegawai.foto.url
        except Exception:
            return ""
    return ""
