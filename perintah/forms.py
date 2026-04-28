from datetime import timedelta

from django import forms
from django.forms import inlineformset_factory
from django.utils.dateparse import parse_date

from .models import Spt, Pelaksana


class SptForm(forms.ModelForm):
    tgl_kembali = forms.DateField(
        required=False,
        disabled=True,
        widget=forms.DateInput(attrs={
            "class": "form-control",
            "type": "date",
            "readonly": "readonly"
        })
    )

    class Meta:
        model = Spt
        exclude = ["tgl_kembali"]
        widgets = {
            "nomor_spt": forms.TextInput(attrs={
                "class": "form-control"
            }),
            "tanggal_spt": forms.DateInput(attrs={
                "class": "form-control",
                "type": "date"
            }),
            "dasar": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3
            }),
            "berita": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3
            }),
            "kota_tujuan": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Kota Tujuan"
            }),
            "lama_perjalanan": forms.Select(attrs={
                "class": "form-select"
            }),
            "tgl_berangkat": forms.DateInput(attrs={
                "class": "form-control",
                "type": "date"
            }),
            "jenis_kegiatan": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Jenis Kegiatan"
            }),
            "kendaraan": forms.Select(attrs={
                "class": "form-select"
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["tgl_kembali"].initial = self._get_calculated_return_date()
        self.order_fields([
            "nomor_spt",
            "tanggal_spt",
            "dasar",
            "berita",
            "kota_tujuan",
            "lama_perjalanan",
            "tgl_berangkat",
            "tgl_kembali",
            "jenis_kegiatan",
            "kendaraan",
        ])

    def _get_calculated_return_date(self):
        if self.is_bound:
            departure_date = parse_date(
                self.data.get(self.add_prefix("tgl_berangkat"), "")
            )

            try:
                duration = int(
                    self.data.get(self.add_prefix("lama_perjalanan")) or 0
                )
            except (TypeError, ValueError):
                duration = 0

            if departure_date and duration > 0:
                return departure_date + timedelta(days=duration - 1)

        if self.instance and self.instance.tgl_berangkat and self.instance.lama_perjalanan:
            return self.instance.tgl_kembali or (
                self.instance.tgl_berangkat +
                timedelta(days=self.instance.lama_perjalanan - 1)
            )

        return None


class PelaksanaForm(forms.ModelForm):
    class Meta:
        model = Pelaksana
        fields = ["nama"]
        widgets = {
            "nama": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Nama Pelaksana"
            }),
        }


PelaksanaFormSet = inlineformset_factory(
    Spt,
    Pelaksana,
    form=PelaksanaForm,
    extra=2,
    can_delete=True
)
