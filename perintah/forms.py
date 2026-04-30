from datetime import timedelta

from django import forms
from django.forms import inlineformset_factory
from django.utils.dateparse import parse_date

from core.forms import BaseAppModelForm

from .models import Pelaksana, PemberiTugas, Spt


class SptForm(BaseAppModelForm):
    # Layout untuk template generic
    field_layout = {
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


class PelaksanaForm(BaseAppModelForm):
    class Meta:
        model = Pelaksana
        fields = ["nama"]

        widgets = {
            "nama": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Nama Pelaksana",
            }),
        }


class PemberiTugasForm(BaseAppModelForm):
    field_layout = {
        "spt": 12,
        "penandatangan": 12,
        "nomor_spt": 6,
        "tanggal_spt": 6,
    }

    class Meta:
        model = PemberiTugas
        fields = [
            "spt",
            "penandatangan",
            "nomor_spt",
            "tanggal_spt",
        ]
        labels = {
            "spt": "SPT",
            "penandatangan": "Pemberi Tugas",
            "nomor_spt": "Nomor SPT",
            "tanggal_spt": "Tanggal SPT",
        }
        widgets = {
            "spt": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih SPT",
            }),
            "penandatangan": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Pemberi Tugas",
            }),
            "nomor_spt": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nomor surat tugas",
            }),
            "tanggal_spt": forms.DateInput(attrs={
                "class": "form-control",
                "type": "date",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["spt"].queryset = (
            Spt.objects.select_related("kota_tujuan").order_by("-id")
        )
        self.fields["spt"].label_from_instance = self._format_spt_label
        self.order_fields([
            "spt",
            "penandatangan",
            "nomor_spt",
            "tanggal_spt",
        ])

    @staticmethod
    def _format_spt_label(obj):
        lokasi = obj.kota_tujuan if obj.kota_tujuan else "-"
        tanggal = (
            obj.tgl_berangkat.strftime("%d-%m-%Y")
            if obj.tgl_berangkat else "-"
        )
        return f"SPT #{obj.pk} - {lokasi} - {tanggal}"


PelaksanaFormSet = inlineformset_factory(
    parent_model=Spt,
    model=Pelaksana,
    form=PelaksanaForm,
    extra=1,
    can_delete=True,
)
