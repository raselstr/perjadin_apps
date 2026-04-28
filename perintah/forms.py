from datetime import timedelta

from django import forms
from django.forms import inlineformset_factory
from django.utils.dateparse import parse_date

from .models import Spt, Pelaksana


class SptForm(forms.ModelForm):
    # Layout untuk template generic
    field_layout = {
        "nomor_spt": 12,
        "tanggal_spt": 12,
        "kota_tujuan": 6,
        "jenis_kegiatan": 6,
        "lama_perjalanan": 4,
        "tgl_berangkat": 4,
        "tgl_kembali": 4,
        "kendaraan": 6,
        "tempat_tujuan": 12,
        "dasar": 12,
        "berita": 12,
    }

    tgl_kembali = forms.DateField(
        required=False,
        widget=forms.DateInput(attrs={
            "class": "form-control",
            "type": "date",
            "readonly": "readonly",
        })
    )

    class Meta:
        model = Spt
        fields = [
            "nomor_spt",
            "tanggal_spt",
            "dasar",
            "berita",
            "kota_tujuan",
            "tempat_tujuan",
            "lama_perjalanan",
            "tgl_berangkat",
            "tgl_kembali",
            "jenis_kegiatan",
            "kendaraan",
        ]

        widgets = {
            "nomor_spt": forms.HiddenInput(),

            "tanggal_spt": forms.HiddenInput(),

            "dasar": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3,
                "placeholder": (
                    "Masukkan dasar perjalanan dinas, "
                    "biarkan kosong jika tidak memiliki dasar"
                )
            }),

            "berita": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3,
                "placeholder": (
                    "Masukkan maksud dan tujuan perjalanan dinas"
                )
            }),

            "kota_tujuan": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Kota Tujuan",
            }),

            "tempat_tujuan": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3,
                "placeholder": (
                    "Masukkan tempat tujuan, nama kantor, "
                    "dan/atau hotel beserta alamatnya (jika ada)"
                )
            }),

            "lama_perjalanan": forms.Select(attrs={
                "class": "form-select",
            }),

            "tgl_berangkat": forms.DateInput(attrs={
                "class": "form-control",
                "type": "date",
            }),

            "jenis_kegiatan": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Jenis Kegiatan",
            }),

            "kendaraan": forms.Select(attrs={
                "class": "form-select",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # Isi otomatis tanggal kembali
        self.fields["tgl_kembali"].initial = (
            self._get_calculated_return_date()
        )

        # Urutan field tampil
        self.order_fields([
            "nomor_spt",
            "tanggal_spt",
            "kota_tujuan",
            "jenis_kegiatan",
            "lama_perjalanan",
            "tgl_berangkat",
            "tgl_kembali",
            "kendaraan",
            "tempat_tujuan",
            "dasar",
            "berita",
        ])

    def _get_calculated_return_date(self):
        """
        Hitung otomatis:
        tgl_kembali = tgl_berangkat + (lama_perjalanan - 1)

        Contoh:
        1 hari = hari yang sama
        2 hari = +1 hari
        """

        # Saat POST (form bound)
        if self.is_bound:
            departure_date = parse_date(
                self.data.get(
                    self.add_prefix("tgl_berangkat"),
                    ""
                )
            )

            try:
                duration = int(
                    self.data.get(
                        self.add_prefix("lama_perjalanan")
                    ) or 0
                )
            except (TypeError, ValueError):
                duration = 0

            if departure_date and duration > 0:
                return departure_date + timedelta(
                    days=duration - 1
                )

        # Saat edit data lama
        if (
            self.instance
            and self.instance.tgl_berangkat
            and self.instance.lama_perjalanan
        ):
            return (
                self.instance.tgl_kembali
                or self.instance.tgl_berangkat
                + timedelta(
                    days=self.instance.lama_perjalanan - 1
                )
            )

        return None


class PelaksanaForm(forms.ModelForm):
    class Meta:
        model = Pelaksana
        fields = ["nama"]

        widgets = {
            "nama": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Nama Pelaksana",
            }),
        }


PelaksanaFormSet = inlineformset_factory(
    parent_model=Spt,
    model=Pelaksana,
    form=PelaksanaForm,
    extra=1,
    can_delete=True,
)