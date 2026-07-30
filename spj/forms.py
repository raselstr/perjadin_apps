import json

from django import forms
from django.core.exceptions import ValidationError
from django.urls import reverse_lazy

from core.forms import BaseAppModelForm
from perintah.models import Pelaksana
from profiles.utils import get_active_opd_id
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

            if not is_admin:
                if active_opd_id:
                    self.fields["spt"].queryset = (
                        self.fields["spt"].queryset.filter(
                            pelaksana__nama__opd_id=active_opd_id,
                        ).distinct()
                    )
                else:
                    self.fields["spt"].queryset = (
                        self.fields["spt"].queryset.none()
                    )
            self.fields["spt"].widget.attrs.update({
                "class": self.spt_field_class,
                "data-placeholder": "Pilih SPT",
                "data-spj-spt-field": "1",
                "data-spj-model": self._spj_model_key(),
            })
            self.fields["spt"].label_from_instance = self._format_spt_label
            self._filter_available_spt_options(user, selected_spt_id)

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
            if not is_admin:
                if active_opd_id:
                    pelaksana_queryset = pelaksana_queryset.filter(
                        nama__opd_id=active_opd_id,
                    )
                else:
                    pelaksana_queryset = pelaksana_queryset.none()
            if selected_spt_id:
                pelaksana_queryset = pelaksana_queryset.filter(
                    spt_id=selected_spt_id,
                )
                pelaksana_queryset = self._exclude_unavailable_pelaksana_options(
                    pelaksana_queryset,
                    selected_spt_id,
                )
            elif not getattr(self.instance, "pelaksana_id", None):
                pelaksana_queryset = pelaksana_queryset.none()
            self.fields["pelaksana"].queryset = pelaksana_queryset
            self.fields["pelaksana"].widget.attrs.update({
                "class": "form-select select2",
                "data-placeholder": "Pilih Pelaksana",
                "data-spj-pelaksana-field": "1",
                "data-spj-pelaksana-url": str(
                    reverse_lazy("spj_pelaksana_options")
                ),
                "data-spj-model": self._spj_model_key(),
                "data-spj-instance": str(getattr(self.instance, "pk", "") or ""),
            })
            if "spt" in self.fields:
                trigger = "change, load"
                if "jenis_spj" in self.fields:
                    trigger += f", change from:#{self['jenis_spj'].id_for_label}"
                self.fields["spt"].widget.attrs.update({
                    "hx-get": str(reverse_lazy("spj_pelaksana_options")),
                    "hx-trigger": trigger,
                    "hx-target": f"#{self['pelaksana'].id_for_label}",
                    "hx-swap": "innerHTML",
                    "hx-include": "closest form",
                    "hx-vals": json.dumps({
                        "model": self._spj_model_key(),
                        "instance": str(getattr(self.instance, "pk", "") or ""),
                    }),
                })
            self.fields["pelaksana"].label_from_instance = (
                self._format_pelaksana_label
            )
            if is_pengguna and pelaksana_queryset.count() == 1:
                self.fields["pelaksana"].initial = pelaksana_queryset.first()

        self._configure_verification_fields(user)
        self._configure_upload_fields()
        self._configure_geo_fields()

    def _configure_verification_fields(self, user):
        if "verif_status" not in self.fields:
            return

        allowed = is_spj_verifikator_user(user)
        for name in ("verif_status",):
            if name in self.fields:
                self.fields[name].disabled = not allowed
                self.fields[name].widget.attrs["class"] = (
                    self.fields[name].widget.attrs.get("class", "")
                )

    def _filter_available_spt_options(self, user, selected_spt_id=None):
        if getattr(self.instance, "pk", None):
            return

        model = self._meta.model
        exclude_spt_ids = []
        if model is LaporanPerjalanan:
            exclude_spt_ids = model.objects.values_list("spt_id", flat=True)

        if selected_spt_id:
            exclude_spt_ids = [
                spt_id for spt_id in exclude_spt_ids
                if str(spt_id) != str(selected_spt_id)
            ]

        if exclude_spt_ids:
            self.fields["spt"].queryset = self.fields["spt"].queryset.exclude(
                pk__in=list(exclude_spt_ids),
            )

    def _spj_model_key(self):
        model_map = {
            Penginapan: "penginapan",
            Pesawat: "pesawat",
            Transport: "transport",
            UangHarian: "uang_harian",
            UangRepresentasi: "uang_representasi",
            LaporanPerjalanan: "laporan_perjalanan",
        }
        return model_map.get(self._meta.model, "")

    def _exclude_unavailable_pelaksana_options(self, queryset, spt_id):
        model = self._meta.model
        instance_id = getattr(self.instance, "pk", None)
        used = None

        if model in (Penginapan, UangHarian, UangRepresentasi):
            used = model.objects.filter(spt_id=spt_id)
        elif model is Pesawat:
            jenis_spj_id = (
                self.data.get(self.add_prefix("jenis_spj"))
                if self.is_bound else self.initial.get("jenis_spj")
            )
            if not jenis_spj_id and getattr(self.instance, "jenis_spj_id", None):
                jenis_spj_id = self.instance.jenis_spj_id
            if jenis_spj_id:
                used = model.objects.filter(
                    spt_id=spt_id,
                    jenis_spj_id=jenis_spj_id,
                )

        if used is None:
            return queryset
        if instance_id:
            used = used.exclude(pk=instance_id)
        return queryset.exclude(
            pk__in=used.values_list("pelaksana_id", flat=True)
        )

    def _configure_upload_fields(self):
        for name, field in self.fields.items():
            widget = field.widget
            if not isinstance(widget, forms.ClearableFileInput):
                continue

            if name.startswith("foto_") or name == "foto_hotel":
                widget.attrs.pop("capture", None)
                widget.attrs.update({
                    "accept": "image/jpeg,image/png,image/webp",
                    "data-spj-camera-upload": "1",
                    "data-spj-geotag-upload": "1",
                })
            elif name == "bukti":
                widget.attrs.update({
                    "accept": "application/pdf,image/*",
                })

    def _configure_geo_fields(self):
        if "latitude" not in self.fields or "longitude" not in self.fields:
            self.has_geo_map = False
            return

        self.has_geo_map = True
        self.geo_latitude_field_id = self["latitude"].id_for_label
        self.geo_longitude_field_id = self["longitude"].id_for_label
        for name in ("latitude", "longitude"):
            self.fields[name].required = True
            self.fields[name].widget.attrs.update({
                "class": "form-control",
                "step": "0.0000001",
            })

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


class RichTextarea(forms.Textarea):
    def __init__(self, attrs=None):
        default_attrs = {
            "class": "form-control",
            "rows": 6,
            "data-spj-rich-editor": "1",
        }
        if attrs:
            default_attrs.update(attrs)
        super().__init__(attrs=default_attrs)


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
        "tipe_kamar": 3,
        "nomor_kamar": 3,
        "tanggal_checkin": 3,
        "tanggal_checkout": 3,
        "lama_menginap": 3,
        "harga_per_malam": 3,
        "bukti": 3,
        "verif_status": 3,
    }

    class Meta:
        model = Penginapan
        fields = [
            "spt",
            "pelaksana",
            "nama_hotel",
            "alamat_hotel",
            "tipe_kamar",
            "nomor_kamar",
            "tanggal_checkin",
            "tanggal_checkout",
            "lama_menginap",
            "harga_per_malam",
            "bukti",
            "verif_status",
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


class PenginapanMediaForm(SPJModelForm):
    field_layout = {
        "foto_hotel": 12,
        "latitude": 6,
        "longitude": 6,
    }

    class Meta:
        model = Penginapan
        fields = [
            "foto_hotel",
            "latitude",
            "longitude",
        ]
        widgets = {
            "foto_hotel": forms.ClearableFileInput(attrs={"class": "form-control"}),
            "latitude": forms.NumberInput(attrs={"class": "form-control"}),
            "longitude": forms.NumberInput(attrs={"class": "form-control"}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name in ("latitude", "longitude"):
            self.fields[name].required = False


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

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if "jenis_spj" in self.fields:
            self.fields["jenis_spj"].widget.attrs.update({
                "data-spj-jenis-spj-field": "1",
            })


class UangHarianForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "uang_harian_per_hari": 4,
        "total_uang_harian": 4,
        "verif_status": 4,
    }
    total_uang_harian = forms.DecimalField(
        label="Total Uang Harian",
        required=False,
        disabled=True,
        widget=forms.NumberInput(attrs={"class": "form-control"}),
    )

    class Meta:
        model = UangHarian
        fields = [
            "spt",
            "pelaksana",
            "uang_harian_per_hari",
            "verif_status",
        ]
        widgets = {
            "uang_harian_per_hari": forms.NumberInput(attrs={
                "class": "form-control",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["uang_harian_per_hari"].disabled = True
        self.fields["uang_harian_per_hari"].required = False
        self.fields["uang_harian_per_hari"].widget.attrs.update({
            "data-spj-calculation-field": "nilai",
        })
        self.fields["total_uang_harian"].widget.attrs.update({
            "data-spj-calculation-field": "total",
        })
        if "spt" in self.fields:
            self.fields["spt"].widget.attrs.update({
                "data-spj-calculation-kind": "uang_harian",
                "data-spj-calculation-url": str(reverse_lazy("spj_calculation")),
            })
        self.order_fields([
            "spt",
            "pelaksana",
            "uang_harian_per_hari",
            "total_uang_harian",
            "verif_status",
        ])
        nilai, total = self._calculate_values()
        self.fields["uang_harian_per_hari"].initial = nilai
        self.fields["total_uang_harian"].initial = total

    def _calculate_values(self):
        spt_id = self.data.get(self.add_prefix("spt")) if self.is_bound else self.initial.get("spt")
        pelaksana_id = self.data.get(self.add_prefix("pelaksana")) if self.is_bound else self.initial.get("pelaksana")
        if not spt_id and getattr(self.instance, "spt_id", None):
            spt_id = self.instance.spt_id
        if not pelaksana_id and getattr(self.instance, "pelaksana_id", None):
            pelaksana_id = self.instance.pelaksana_id
        if not spt_id or not pelaksana_id:
            return None, None

        from perintah.models import Spt

        try:
            spt = Spt.objects.select_related("kota_tujuan", "jenis_kegiatan").get(pk=spt_id)
        except Spt.DoesNotExist:
            return None, None

        obj = self._meta.model(spt=spt)
        nilai = obj.get_standar_maksimal()
        total = nilai * spt.lama_perjalanan if nilai is not None else None
        return nilai, total

    def clean(self):
        cleaned_data = super().clean()
        nilai, total = self._calculate_values()
        cleaned_data["uang_harian_per_hari"] = nilai
        cleaned_data["total_uang_harian"] = total
        return cleaned_data


class TransportForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "jenis_spj": 4,
        "jenis_transportasi": 4,
        "tanggal_berangkat": 4,
        "biaya": 4,
        "lokasi_berangkat": 6,
        "tujuan": 6,
        "bukti": 4,
        "verif_status": 4,
    }

    class Meta:
        model = Transport
        fields = [
            "spt",
            "pelaksana",
            "jenis_spj",
            "jenis_transportasi",
            "tanggal_berangkat",
            "lokasi_berangkat",
            "tujuan",
            "biaya",
            "bukti",
            "verif_status",
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
            "tanggal_berangkat": forms.DateInput(attrs={"type": "date"}),
            "biaya": forms.NumberInput(attrs={"class": "form-control"}),
            "bukti": forms.ClearableFileInput(attrs={"class": "form-control"}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        instance_id = getattr(self.instance, "pk", "") or ""

        if "spt" in self.fields:
            self.fields["spt"].widget.attrs.update({
                "data-spj-availability-url": str(
                    reverse_lazy("spj_available_options")
                ),
                "data-spj-availability-model": "transport",
                "data-spj-availability-instance": str(instance_id),
            })
        if "jenis_spj" in self.fields:
            self.fields["jenis_spj"].widget.attrs.update({
                "data-spj-jenis-spj-field": "1",
            })
        if "jenis_transportasi" in self.fields:
            self.fields["jenis_transportasi"].widget.attrs.update({
                "data-spj-jenis-transportasi-field": "1",
            })

        self._filter_available_transport_options()

    def _filter_available_transport_options(self):
        spt_id = self.data.get(self.add_prefix("spt")) if self.is_bound else self.initial.get("spt")
        pelaksana_id = self.data.get(self.add_prefix("pelaksana")) if self.is_bound else self.initial.get("pelaksana")
        jenis_spj_id = self.data.get(self.add_prefix("jenis_spj")) if self.is_bound else self.initial.get("jenis_spj")

        if not spt_id and getattr(self.instance, "spt_id", None):
            spt_id = self.instance.spt_id
        if not pelaksana_id and getattr(self.instance, "pelaksana_id", None):
            pelaksana_id = self.instance.pelaksana_id
        if not jenis_spj_id and getattr(self.instance, "jenis_spj_id", None):
            jenis_spj_id = self.instance.jenis_spj_id

        if not (spt_id and pelaksana_id and jenis_spj_id):
            return

        used = Transport.objects.filter(
            spt_id=spt_id,
            pelaksana_id=pelaksana_id,
            jenis_spj_id=jenis_spj_id,
        )
        if getattr(self.instance, "pk", None):
            used = used.exclude(pk=self.instance.pk)

        used_transport_ids = list(
            used.values_list("jenis_transportasi_id", flat=True)
        )
        selected_transport_id = (
            self.data.get(self.add_prefix("jenis_transportasi"))
            if self.is_bound else self.initial.get("jenis_transportasi")
        )
        if not selected_transport_id and getattr(self.instance, "jenis_transportasi_id", None):
            selected_transport_id = self.instance.jenis_transportasi_id
        if selected_transport_id:
            used_transport_ids = [
                item_id for item_id in used_transport_ids
                if str(item_id) != str(selected_transport_id)
            ]

        if used_transport_ids and "jenis_transportasi" in self.fields:
            self.fields["jenis_transportasi"].queryset = (
                self.fields["jenis_transportasi"].queryset.exclude(
                    pk__in=used_transport_ids,
                )
            )


class UangRepresentasiForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "biaya": 4,
        "verif_status": 4,
    }

    class Meta:
        model = UangRepresentasi
        fields = [
            "spt",
            "pelaksana",
            "biaya",
            "verif_status",
        ]
        widgets = {
            "biaya": forms.NumberInput(attrs={"class": "form-control"}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["biaya"].disabled = True
        self.fields["biaya"].required = False
        self.fields["biaya"].widget.attrs.update({
            "data-spj-calculation-field": "nilai",
        })
        if "spt" in self.fields:
            self.fields["spt"].widget.attrs.update({
                "data-spj-calculation-kind": "representasi",
                "data-spj-calculation-url": str(reverse_lazy("spj_calculation")),
            })
        self.fields["biaya"].initial = self._calculate_value()

    def _calculate_value(self):
        spt_id = self.data.get(self.add_prefix("spt")) if self.is_bound else self.initial.get("spt")
        pelaksana_id = self.data.get(self.add_prefix("pelaksana")) if self.is_bound else self.initial.get("pelaksana")
        if not spt_id and getattr(self.instance, "spt_id", None):
            spt_id = self.instance.spt_id
        if not pelaksana_id and getattr(self.instance, "pelaksana_id", None):
            pelaksana_id = self.instance.pelaksana_id
        if not spt_id or not pelaksana_id:
            return None

        try:
            pelaksana = Pelaksana.objects.select_related(
                "spt",
                "spt__kota_tujuan",
                "nama",
                "nama__tingkat",
            ).get(pk=pelaksana_id, spt_id=spt_id)
        except Pelaksana.DoesNotExist:
            return None

        obj = self._meta.model(spt=pelaksana.spt, pelaksana=pelaksana)
        return obj.get_standar_maksimal()

    def clean(self):
        cleaned_data = super().clean()
        cleaned_data["biaya"] = self._calculate_value()
        return cleaned_data


class LaporanPerjalananForm(SPJModelForm):
    field_layout = {
        "spt": 6,
        "pelaksana": 6,
        "pembukaan": 12,
        "isi_pertemuan": 12,
        "penutup": 12,
    }

    class Meta:
        model = LaporanPerjalanan
        fields = [
            "spt",
            "pelaksana",
            "pembukaan",
            "isi_pertemuan",
            "penutup",
        ]
        widgets = {
            "pembukaan": RichTextarea(),
            "isi_pertemuan": RichTextarea(),
            "penutup": RichTextarea(),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if not self.is_bound and not getattr(self.instance, "pk", None):
            self.fields["pembukaan"].initial = ""
            self.fields["isi_pertemuan"].initial = ""
            self.fields["penutup"].initial = (
                "Demikian Laporan Perjalanan Dinas ini dibuat, sebagai bahan Laporan."
            )


class LaporanPerjalananMediaForm(SPJModelForm):
    field_layout = {
        "foto_1": 3,
        "foto_2": 3,
        "foto_3": 3,
        "foto_4": 3,
        "latitude": 6,
        "longitude": 6,
    }

    class Meta:
        model = LaporanPerjalanan
        fields = [
            "foto_1",
            "foto_2",
            "foto_3",
            "foto_4",
            "latitude",
            "longitude",
        ]
        widgets = {
            "latitude": forms.NumberInput(attrs={"class": "form-control"}),
            "longitude": forms.NumberInput(attrs={"class": "form-control"}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for name in ("foto_1", "foto_2", "foto_3", "foto_4", "latitude", "longitude"):
            self.fields[name].required = False
