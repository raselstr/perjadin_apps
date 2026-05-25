from django import forms
from django.core.exceptions import ValidationError
from django.urls import reverse_lazy

from core.forms import BaseAppModelForm
from perintah.models import Pelaksana
from profiles.utils import filter_queryset_by_active_opd, get_active_opd_id
from .access import is_spj_admin_user, is_spj_pengguna_user, is_spj_verifikator_user

from .models import (
    JenisSPJ,
    LaporanPerjalanan,
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
            selected_spt_id = None
            if self.is_bound:
                selected_spt_id = self.data.get(self.add_prefix("spt"))
            elif getattr(self.instance, "spt_id", None):
                selected_spt_id = self.instance.spt_id

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
                "data-spj-spt-field": "1",
            })
            self.fields["spt"].label_from_instance = self._format_spt_label

        if "pelaksana" in self.fields:
            selected_spt_id = None
            if self.is_bound:
                selected_spt_id = self.data.get(self.add_prefix("spt"))
            elif getattr(self.instance, "spt_id", None):
                selected_spt_id = self.instance.spt_id

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
            if selected_spt_id:
                pelaksana_queryset = pelaksana_queryset.filter(
                    spt_id=selected_spt_id,
                )
            self.fields["pelaksana"].queryset = pelaksana_queryset
            self.fields["pelaksana"].widget.attrs.update({
                "class": "form-select select2",
                "data-placeholder": "Pilih Pelaksana",
                "data-spj-pelaksana-field": "1",
                "data-spj-pelaksana-url": str(
                    reverse_lazy("spj_pelaksana_options")
                ),
            })
            self.fields["pelaksana"].label_from_instance = (
                self._format_pelaksana_label
            )
            if is_pengguna and pelaksana_queryset.count() == 1:
                self.fields["pelaksana"].initial = pelaksana_queryset.first()

        self._configure_verification_fields(user)

    def _configure_verification_fields(self, user):
        if "verif_status" not in self.fields:
            return

        allowed = is_spj_verifikator_user(user)
        for name in ("verif_status", "verif_catatan"):
            if name in self.fields:
                self.fields[name].disabled = not allowed
                self.fields[name].widget.attrs["class"] = (
                    self.fields[name].widget.attrs.get("class", "")
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

    def clean(self):
        cleaned_data = super().clean()
        spt = cleaned_data.get("spt")
        pelaksana = cleaned_data.get("pelaksana")

        if spt and pelaksana and pelaksana.spt_id != spt.id:
            raise ValidationError({
                "pelaksana": (
                    "Pelaksana harus sesuai dengan SPT yang dipilih."
                )
            })

        return cleaned_data


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
        "foto_hotel": 4,
        "latitude": 4,
        "longitude": 4,
        "tipe_kamar": 3,
        "nomor_kamar": 3,
        "tanggal_checkin": 3,
        "tanggal_checkout": 3,
        "lama_menginap": 3,
        "harga_per_malam": 3,
        "bukti": 3,
        "verif_status": 3,
        "verif_catatan": 12,
    }

    class Meta:
        model = Penginapan
        fields = [
            "spt",
            "pelaksana",
            "nama_hotel",
            "alamat_hotel",
            "foto_hotel",
            "latitude",
            "longitude",
            "tipe_kamar",
            "nomor_kamar",
            "tanggal_checkin",
            "tanggal_checkout",
            "lama_menginap",
            "harga_per_malam",
            "bukti",
            "verif_status",
            "verif_catatan",
        ]
        widgets = {
            "nama_hotel": forms.TextInput(attrs={"class": "form-control"}),
            "alamat_hotel": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 2,
            }),
            "lama_menginap": forms.NumberInput(attrs={"class": "form-control"}),
            "tanggal_checkin": forms.DateInput(attrs={"type": "date"}),
            "tanggal_checkout": forms.DateInput(attrs={"type": "date"}),
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
        "nama_maskapai": 4,
        "tanggal_penerbangan": 4,
        "lokasi_bandara": 4,
        "tujuan_bandara": 4,
        "nomor_tiket": 4,
        "kode_booking": 4,
        "harga_tiket": 4,
        "bukti": 4,
        "verif_status": 4,
        "verif_catatan": 12,
    }

    class Meta:
        model = Pesawat
        fields = [
            "spt",
            "pelaksana",
            "jenis_spj",
            "nama_maskapai",
            "tanggal_penerbangan",
            "lokasi_bandara",
            "tujuan_bandara",
            "nomor_tiket",
            "kode_booking",
            "harga_tiket",
            "bukti",
            "verif_status",
            "verif_catatan",
        ]
        widgets = {
            "jenis_spj": forms.Select(attrs={"class": "form-select select2"}),
            "tanggal_penerbangan": forms.DateInput(attrs={"type": "date"}),
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
        "uang_harian_per_hari": 4,
        "verif_status": 4,
        "verif_catatan": 12,
    }

    class Meta:
        model = UangHarian
        fields = [
            "spt",
            "pelaksana",
            "uang_harian_per_hari",
            "verif_status",
            "verif_catatan",
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
        "bukti": 4,
        "verif_status": 4,
        "verif_catatan": 12,
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
            "verif_status",
            "verif_catatan",
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
        "biaya": 4,
        "verif_status": 4,
        "verif_catatan": 12,
    }

    class Meta:
        model = UangRepresentasi
        fields = [
            "spt",
            "pelaksana",
            "biaya",
            "verif_status",
            "verif_catatan",
        ]
        widgets = {
            "biaya": forms.NumberInput(attrs={"class": "form-control"}),
        }


class LaporanPerjalananForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "hasil": 12,
        "foto_1": 3,
        "foto_2": 3,
        "foto_3": 3,
        "foto_4": 3,
    }

    class Meta:
        model = LaporanPerjalanan
        fields = [
            "spt",
            "pelaksana",
            "hasil",
            "foto_1",
            "foto_2",
            "foto_3",
            "foto_4",
        ]
        widgets = {
            "hasil": forms.Textarea(attrs={"rows": 5}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["hasil"].help_text = (
            "Isi hasil laporan dalam 3 bagian utama: 1. Pembukaan, "
            "2. Gambaran acara berlangsung, 3. Penutup."
        )
        if not self.is_bound and not getattr(self.instance, "pk", None):
            self.fields["hasil"].initial = (
                "1. Pembukaan\n\n"
                "2. Gambaran acara berlangsung\n\n"
                "3. Penutup"
            )
        if "spt" in self.fields and not getattr(self.instance, "pk", None):
            self.fields["spt"].queryset = self.fields["spt"].queryset.exclude(
                laporan_perjalanan__isnull=False,
            )
