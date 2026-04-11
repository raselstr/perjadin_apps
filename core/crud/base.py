from django.http import HttpResponse, JsonResponse
from django.views.generic import ListView
from django.shortcuts import render, get_object_or_404, redirect
from django.db.models import Q
from django_tables2 import RequestConfig


class BaseCRUDView(ListView):
    model = None
    form_class = None
    table_class = None
    template_name = "pages/page.html"
    template_list = "components/crud/list.html"
    template_form = "components/crud/form.html"

    title = ""

    url_list = None
    url_action = None
    url_action_pk = None
    paginate_by = 10
    

    def get_queryset(self):
        qs = self.model.objects.all().order_by('nip')
        search = self.request.GET.get("search")

        if search:
            qs = qs.filter(
                Q(nama__icontains=search) |
                Q(nip__icontains=search) |
                Q(jabatan__icontains=search)
            )

        return qs

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        table = self.table_class(self.object_list, request=self.request)
        per_page = self.request.GET.get("per_page", 10)
        if per_page == "all":
            paginate_config = False
        else:
            try:
                paginate_config = {"per_page": int(per_page)}
            except ValueError:
                paginate_config = {"per_page": 10}

        RequestConfig(
            self.request,
            paginate=paginate_config
        ).configure(table)

        context.update({
            "table": table,
            "title": self.title,
            "url_list": self.url_list,
            "url_action": self.url_action,
            "url_action_pk": self.url_action_pk,
        })

        return context

    def get_template_names(self):
        if self.request.headers.get("HX-Request"):
            return [self.template_list]  # partial (HTMX)
        return [self.template_name]  # full page
    
    def dispatch(self, request, *args, **kwargs):
        pk = kwargs.get("pk")

        if pk and "delete" in request.path:
            return self.delete_view(request, pk)

        if pk and "form" in request.path:
            return self.form_view(request, pk)

        if "form" in request.path:
            return self.form_view(request)

        return super().dispatch(request, *args, **kwargs)
    
    def list_view(self, request):
        table = self.table_class(self.model.objects.all())

        return render(request, self.template_name, {
            "table": table,
            "url_list": self.url_list,
        })

    # CREATE / UPDATE
    def form_view(self, request, pk=None):
        instance = None
        if pk:
            instance = get_object_or_404(self.model, pk=pk)

        form = self.form_class(request.POST or None, instance=instance)

        if request.method == "POST" and form.is_valid():
            form.save()

            if request.htmx:
                response = JsonResponse({"success": True})
                response["HX-Trigger"] = "formSuccess,reloadTable"
                return response

            return redirect(self.url_list)

        return render(request, self.template_form, {
            "form": form,
            "title": self.title,
        })

    def delete_view(self, request, pk):
        obj = get_object_or_404(self.model, pk=pk)

        if request.method == "POST":
            obj.delete()

            if request.htmx:
                response = JsonResponse({"ok": True})
                response["HX-Trigger"] = "formSuccess,reloadTable"
                return response

            return redirect(self.url_list)

        return render(request, "components/crud/delete.html", {
            "object": obj,
            "url_list": self.url_list,
            "title": "Hapus Data"
        })