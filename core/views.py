from django.shortcuts import render
from django.urls import reverse, NoReverseMatch

PAGE_TITLES = {
    "dashboard": "Dashboard",
    "pegawai_list": "Pegawai",
}

def page_view(request):
    page = request.GET.get("page", "dashboard")

    try:
        initial_url = reverse(page)
        title = PAGE_TITLES.get(page, "Dashboard")
    except NoReverseMatch:
        initial_url = reverse("dashboard")
        title = "Dashboard"

    return render(request, "pages/page.html", {
        "initial_url": initial_url,
        "title": title,
        "current_page": page,
    })