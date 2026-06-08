# utils/pdf.py

from django.http import HttpResponse
from django.template.loader import render_to_string
from weasyprint import HTML


def render_pdf(request, template_name, context, filename):

    html = render_to_string(
        template_name,
        context,
        request=request,
    )

    pdf = HTML(
        string=html,
        base_url=request.build_absolute_uri("/"),
    ).write_pdf()

    response = HttpResponse(
        pdf,
        content_type="application/pdf",
    )

    response["Content-Disposition"] = (
        f'inline; filename="{filename}"'
    )

    return response