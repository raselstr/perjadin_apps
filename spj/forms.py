from django import forms

from core.forms import BaseAppModelForm
from perintah.models import Pelaksana
from profiles.utils import filter_queryset_by_active_opd, get_active_opd_id
from .access import is_spj_admin_user, is_spj_pengguna_user

from .models import (
    JenisSPJ,
    Penginapan,
    Pesawat,
    Transport,
    UangHarian,
    UangRepresentasi,
)


class SPJModelForm(BaseAppModelForm):
    spt_field_class = "form-select select2"

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_opd_id = get_active_opd_id(self.request)
        user = getattr(self.request, "user", None)
        is_admin = is_spj_admin_user(user)
        is_pengguna = is_spj_pengguna_user(user)

        if "spt" in self.fields:
            if is_pengguna:
                self.fields["spt"].queryset = (
                    self.fields["spt"].queryset.filter(
                        pelaksana__nama__nip=user.username,
                    ).distinct()
                )
            elif active_opd_id and not is_admin:
                self.fields["spt"].queryset = filter_queryset_by_active_opd(
                    self.fields["spt"].queryset,
                    self.request,
                    "pelaksana__nama__opd_id",
                ).distinct()
            self.fields["spt"].widget.attrs.update({
                "class": self.spt_field_class,
                "data-placeholder": "Pilih SPT",
            })
            self.fields["spt"].label_from_instance = self._format_spt_label

        if "pelaksana" in self.fields:
            pelaksana_queryset = (
                Pelaksana.objects.select_related(
                    "spt",
                    "nama",
                    "nama__opd",
                    "nama__tingkat",
                ).order_by("-spt_id", "nama__nama")
            )
            if is_pengguna:
                pelaksana_queryset = pelaksana_queryset.filter(
                    nama__nip=user.username,
                )
            elif active_opd_id and not is_admin:
                pelaksana_queryset = pelaksana_queryset.filter(
                    nama__opd_id=active_opd_id,
                )
            self.fields["pelaksana"].queryset = pelaksana_queryset
            self.fields["pelaksana"].widget.attrs.update({
                "class": "form-select select2",
                "data-placeholder": "Pilih Pelaksana",
            })
            self.fields["pelaksana"].label_from_instance = (
                self._format_pelaksana_label
            )

    @staticmethod
    def _format_spt_label(obj):
        lokasi = obj.kota_tujuan_display or "-"
        tanggal = (
            obj.tgl_berangkat.strftime("%d-%m-%Y")
            if obj.tgl_berangkat else "-"
        )
        return f"SPT #{obj.pk} - {lokasi} - {tanggal}"

    @staticmethod
    def _format_pelaksana_label(obj):
        return f"SPT #{obj.spt_id} - {obj.nama}"


class JenisSPJForm(BaseAppModelForm):
    class Meta:
        model = JenisSPJ
        fields = ["jenis_spj"]
        widgets = {
            "jenis_spj": forms.TextInput(attrs={"class": "form-control"}),
        }


class PenginapanForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "nama_hotel": 6,
        "alamat_hotel": 6,
        "lama_menginap": 4,
        "harga_per_malam": 4,
        "bukti": 4,
    }

    class Meta:
        model = Penginapan
        fields = [
            "spt",
            "pelaksana",
            "nama_hotel",
            "alamat_hotel",
            "lama_menginap",
            "harga_per_malam",
            "bukti",
        ]
        widgets = {
            "nama_hotel": forms.TextInput(attrs={"class": "form-control"}),
            "alamat_hotel": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 2,
            }),
            "lama_menginap": forms.NumberInput(attrs={"class": "form-control"}),
            "harga_per_malam": forms.NumberInput(attrs={
                "class": "form-control",
            }),
            "bukti": forms.ClearableFileInput(attrs={"class": "form-control"}),
        }


class PesawatForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "jenis_spj": 4,
        "lokasi_bandara": 4,
        "tujuan_bandara": 4,
        "harga_tiket": 6,
        "bukti": 6,
    }

    class Meta:
        model = Pesawat
        fields = [
            "spt",
            "pelaksana",
            "jenis_spj",
            "lokasi_bandara",
            "tujuan_bandara",
            "harga_tiket",
            "bukti",
        ]
        widgets = {
            "jenis_spj": forms.Select(attrs={"class": "form-select select2"}),
            "lokasi_bandara": forms.Select(attrs={
                "class": "form-select select2",
            }),
            "tujuan_bandara": forms.Select(attrs={
                "class": "form-select select2",
            }),
            "harga_tiket": forms.NumberInput(attrs={"class": "form-control"}),
            "bukti": forms.ClearableFileInput(attrs={"class": "form-control"}),
        }


class UangHarianForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "uang_harian_per_hari": 6,
    }

    class Meta:
        model = UangHarian
        fields = [
            "spt",
            "pelaksana",
            "uang_harian_per_hari",
        ]
        widgets = {
            "uang_harian_per_hari": forms.NumberInput(attrs={
                "class": "form-control",
            }),
        }


class TransportForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "jenis_spj": 4,
        "jenis_transportasi": 4,
        "biaya": 4,
        "lokasi_berangkat": 6,
        "tujuan": 6,
        "bukti": 6,
    }

    class Meta:
        model = Transport
        fields = [
            "spt",
            "pelaksana",
            "jenis_spj",
            "jenis_transportasi",
            "lokasi_berangkat",
            "tujuan",
            "biaya",
            "bukti",
        ]
        widgets = {
            "jenis_spj": forms.Select(attrs={"class": "form-select select2"}),
            "jenis_transportasi": forms.Select(attrs={
                "class": "form-select select2",
            }),
            "lokasi_berangkat": forms.Select(attrs={
                "class": "form-select select2",
            }),
            "tujuan": forms.Select(attrs={"class": "form-select select2"}),
            "biaya": forms.NumberInput(attrs={"class": "form-control"}),
            "bukti": forms.ClearableFileInput(attrs={"class": "form-control"}),
        }


class UangRepresentasiForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "biaya": 6,
    }

    class Meta:
        model = UangRepresentasi
        fields = [
            "spt",
            "pelaksana",
            "biaya",
        ]
        widgets = {
            "biaya": forms.NumberInput(attrs={"class": "form-control"}),
        }
