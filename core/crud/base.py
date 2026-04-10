from django.http import HttpResponse, JsonResponse
from django.views.generic import ListView
from django.shortcuts import render, get_object_or_404, redirect


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
    
    def get_queryset(self):
        return self.model.objects.all()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)

        table = self.table_class(self.object_list, request=self.request)

        # SAFE ASSIGN (bukan direct context)
        table.url_name = self.url_action

        context.update({
            "table": table,
            "title": self.title,
            "url_list": self.url_list,
            "url_action": self.url_action,
            "url_action_pk": self.url_action_pk,
            "initial_url": self.request.path,
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
    def form_view(self, request, pk=None, action=None):
        instance = None
        if pk:
            instance = get_object_or_404(self.model, pk=pk)

        form = self.form_class(request.POST or None, instance=instance)

        if request.POST:
            if form.is_valid():
                form.save()
                if request.htmx:
                    response = JsonResponse({"ok": True})
                    response["HX-Trigger"] = "formSuccess,reloadTable"
                    return response
                return redirect(self.url_list)

        template = self.template_form
        if not request.headers.get("HX-Request"):
            template = self.template_name  # fallback full page

        return render(request, template, {
            "form": form,
            "title": self.title,
            "url_list": self.url_list,
            "initial_url": request.path,
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