from datetime import timedelta

from django import forms
from django.db.models import Q
from django.forms import inlineformset_factory
from django.utils.dateparse import parse_date

from core.forms import BaseAppModelForm
from profiles.utils import (
    GLOBAL_PENANDATANGAN_TASKS,
    filter_penandatangan_queryset,
    get_active_opd_id,
)
from umum.models import Pegawai, Penandatangan

from .document_utils import is_eselon_two
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
        
        self.fields["kota_tujuan"].label_from_instance = self.label_lokasi

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
    
    def label_lokasi(self, obj):
        if obj.jenis_spd and obj.jenis_spd.id == 1:
            return f"Provinsi {obj.lokasi} - {obj.kota}"
        if obj.jenis_spd and obj.jenis_spd.id == 2:
            return f"{obj.lokasi} - {obj.kota}"
        return obj.kota or obj.lokasi
    
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

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_opd_id = get_active_opd_id(self.request)

        queryset = Pegawai.objects.select_related(
            "pangkat",
            "eselon",
            "jenis_jabatan",
            "opd",
        ).order_by("nama")

        if active_opd_id:
            filters = Q(opd_id=active_opd_id)
            if self.instance and self.instance.nama_id:
                filters |= Q(pk=self.instance.nama_id)
            queryset = queryset.filter(filters).distinct()

        self.fields["nama"].queryset = queryset


class PemberiTugasForm(BaseAppModelForm):
    field_layout = {
        "spt": 12,
        "penandatangan": 12,
        "nomor_spt": 4,
        "nomor_spd": 4,
        "tanggal_spt": 4,
    }

    class Meta:
        model = PemberiTugas
        fields = [
            "spt",
            "penandatangan",
            "nomor_spt",
            "nomor_spd",
            "tanggal_spt",
        ]
        labels = {
            "spt": "SPT",
            "penandatangan": "Pemberi Tugas",
            "nomor_spt": "Nomor SPT",
            "nomor_spd": "Nomor SPD",
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
            "nomor_spd": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nomor surat perjalanan",
            }),
            "tanggal_spt": forms.DateInput(attrs={
                "class": "form-control",
                "type": "date",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_opd_id = get_active_opd_id(self.request)

        spt_queryset = Spt.objects.select_related(
            "kota_tujuan"
        ).order_by("-id")
        if active_opd_id:
            spt_filters = Q(pelaksana__nama__opd_id=active_opd_id)
            if self.instance and self.instance.spt_id:
                spt_filters |= Q(pk=self.instance.spt_id)
            spt_queryset = spt_queryset.filter(spt_filters).distinct()

        penandatangan_queryset = Penandatangan.objects.select_related(
            "jenis_jabatan",
            "opd",
        ).order_by("nama")
        penandatangan_queryset = filter_penandatangan_queryset(
            penandatangan_queryset,
            self.request,
        )

        if active_opd_id and self.instance and self.instance.penandatangan_id:
            penandatangan_queryset = Penandatangan.objects.select_related(
                "jenis_jabatan",
                "opd",
            ).filter(
                Q(pk__in=penandatangan_queryset.values("pk")) |
                Q(pk=self.instance.penandatangan_id) |
                Q(tugas__in=GLOBAL_PENANDATANGAN_TASKS)
            ).distinct().order_by("nama")

        self.fields["spt"].queryset = spt_queryset
        self.fields["penandatangan"].queryset = penandatangan_queryset
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

    def clean(self):
        cleaned_data = super().clean()
        spt = cleaned_data.get("spt")
        penandatangan = cleaned_data.get("penandatangan")

        if (
            spt
            and penandatangan
            and penandatangan.tugas == "Bupati"
        ):
            pelaksana_queryset = spt.pelaksana.select_related(
                "nama",
                "nama__eselon",
            )
            has_eselon_two = any(
                is_eselon_two(pelaksana.nama)
                for pelaksana in pelaksana_queryset
            )

            if not has_eselon_two:
                self.add_error(
                    "spt",
                    (
                        "SPT untuk Bupati harus memiliki minimal satu "
                        "pelaksana dengan eselon II."
                    ),
                )

        return cleaned_data


PelaksanaFormSet = inlineformset_factory(
    parent_model=Spt,
    model=Pelaksana,
    form=PelaksanaForm,
    extra=1,
    can_delete=True,
)
