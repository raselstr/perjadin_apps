from django import template
from django.urls import reverse, NoReverseMatch

register = template.Library()

@register.simple_tag
def safe_url(name):
    if not name:
        return "#"
    try:
        return reverse(name)
    except NoReverseMatch:
        return "#"