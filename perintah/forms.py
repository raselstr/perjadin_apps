from datetime import timedelta

from django import forms
from django.db.models import Q
from django.forms import BaseInlineFormSet, inlineformset_factory
from django.utils.dateparse import parse_date

from core.forms import BaseAppModelForm
from profiles.utils import (
    filter_penandatangan_queryset,
    get_global_penandatangan_tasks,
    get_active_opd_id,
    is_administrator_request,
)
from umum.models import Pegawai, Penandatangan

from .document_utils import (
    filter_spt_pelaksana,
    get_spt_pelaksana_scope,
    is_single_eselon_two_pelaksana,
)
from .models import Pelaksana, PemberiTugas, Spt, TtdSptSpd


def _normalize_optional_document_number(value):
    value = (value or "").strip()
    return value


def _get_formset_prefix_from_data(data, default="pelaksana"):
    for key in data.keys():
        if key.endswith("-TOTAL_FORMS"):
            return key[:-len("-TOTAL_FORMS")]
    return default


def _get_selected_pelaksana_ids_from_data(data, prefix="pelaksana"):
    try:
        total_forms = int(data.get(f"{prefix}-TOTAL_FORMS") or 0)
    except (TypeError, ValueError):
        return []

    selected_ids = []
    for index in range(total_forms):
        if data.get(f"{prefix}-{index}-DELETE") in {"on", "true", "True", "1"}:
            continue

        pelaksana_id = data.get(f"{prefix}-{index}-nama")
        if pelaksana_id:
            selected_ids.append(pelaksana_id)

    return selected_ids


def _get_pelaksana_schedule_conflicts(
    pelaksana_ids,
    departure_date,
    exclude_spt_id=None,
):
    if not pelaksana_ids or not departure_date:
        return Pelaksana.objects.none()

    conflicts = Pelaksana.objects.select_related(
        "spt",
        "nama",
    ).filter(
        nama_id__in=pelaksana_ids,
        spt__tgl_berangkat__lte=departure_date,
        spt__tgl_kembali__gt=departure_date,
    )

    if exclude_spt_id:
        conflicts = conflicts.exclude(spt_id=exclude_spt_id)

    return conflicts


def _format_pelaksana_schedule_conflict(conflict):
    return (
        f"{conflict.nama.nama} sudah menjadi pelaksana pada "
        f"SPT #{conflict.spt_id} tanggal "
        f"{conflict.spt.tgl_berangkat:%d-%m-%Y} sampai "
        f"{conflict.spt.tgl_kembali:%d-%m-%Y}."
    )


class SptForm(BaseAppModelForm):
    # Layout untuk template generic
    field_layout = {
        "kota_tujuan": 12,
        "kota_tujuan_tambahan": 12,
        "jenis_kegiatan": 7,
        "lama_perjalanan": 5,
        "tgl_berangkat": 4,
        "tgl_kembali": 4,
        "kendaraan": 4,
        "tempat_tujuan": 12,
        "dasar": 12,
        "berita": 12,
    }

    tgl_kembali = forms.DateField(
        required=False,
        input_formats=["%Y-%m-%d", "%d/%m/%Y"],
        widget=forms.DateInput(attrs={
            "class": "form-control",
            "type": "date",
            "readonly": "readonly",
        }, format="%Y-%m-%d")
    )

    class Meta:
        model = Spt
        fields = [
            "dasar",
            "berita",
            "kota_tujuan",
            "kota_tujuan_tambahan",
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

            "kota_tujuan_tambahan": forms.SelectMultiple(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih Kota Tujuan Tambahan (Biarkan Kosong jika tidak ada)",
            }),

            "tempat_tujuan": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3,
                "placeholder": (
                    "Masukkan tempat tujuan. Jika lebih dari satu, "
                    "pisahkan dengan baris baru atau koma."
                )
            }),

            "lama_perjalanan": forms.Select(attrs={
                "class": "form-select",
            }),

            "tgl_berangkat": forms.DateInput(attrs={
                "class": "form-control",
                "type": "date",
            }, format="%Y-%m-%d"),

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
        self.field_layout = self.field_layout.copy()
        
        self.fields["kota_tujuan"].label_from_instance = self.label_lokasi
        self.fields["kota_tujuan_tambahan"].label_from_instance = (
            self.label_lokasi
        )
        self._disable_extra_destinations_if_unmigrated()

        # Isi otomatis tanggal kembali
        self.fields["tgl_kembali"].initial = (
            self._get_calculated_return_date()
        )

        # Urutan field tampil
        self.order_fields([
            "kota_tujuan",
            "kota_tujuan_tambahan",
            "jenis_kegiatan",
            "lama_perjalanan",
            "tgl_berangkat",
            "tgl_kembali",
            "kendaraan",
            "tempat_tujuan",
            "dasar",
            "berita",
        ])

    def clean(self):
        cleaned_data = super().clean()
        departure_date = cleaned_data.get("tgl_berangkat")

        if not self.is_bound or not departure_date:
            return cleaned_data

        formset_prefix = _get_formset_prefix_from_data(self.data)
        selected_pelaksana_ids = _get_selected_pelaksana_ids_from_data(
            self.data,
            prefix=formset_prefix,
        )
        conflict = _get_pelaksana_schedule_conflicts(
            selected_pelaksana_ids,
            departure_date,
            exclude_spt_id=self.instance.pk if self.instance else None,
        ).first()

        if conflict:
            self.add_error(
                "tgl_berangkat",
                (
                    _format_pelaksana_schedule_conflict(conflict)
                    + " Tanggal berangkat SPT baru harus lebih besar atau "
                    "sama dengan tanggal kembali SPT sebelumnya."
                ),
            )

        return cleaned_data

    def _disable_extra_destinations_if_unmigrated(self):
        from .document_utils import _has_spt_extra_destination_table

        if not _has_spt_extra_destination_table():
            self.fields.pop("kota_tujuan_tambahan", None)
            self.field_layout.pop("kota_tujuan_tambahan", None)
    
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
                "data-pelaksana-select": "true",
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
            if is_administrator_request(self.request):
                filters |= Q(eselon__eselon__iexact="II")
            if self.instance and self.instance.nama_id:
                filters |= Q(pk=self.instance.nama_id)
            queryset = queryset.filter(filters).distinct()

        self.fields["nama"].queryset = queryset
        self.fields["nama"].label_from_instance = (
            self._format_pelaksana_label
        )

    @staticmethod
    def _format_pelaksana_label(obj):
        if obj.nip:
            return f"{obj.nama} - {obj.nip} - {obj.jabatan}"
        return f"{obj.nama} - {obj.jabatan}"


class BasePelaksanaInlineFormSet(BaseInlineFormSet):
    minimum_message = (
        "Minimal 1 pelaksana harus dipilih sebelum SPT disimpan."
    )
    duplicate_message = (
        "Pelaksana yang sama tidak boleh dipilih lebih dari satu kali "
        "dalam satu SPT."
    )
    schedule_conflict_message = (
        "Pelaksana tersebut masih terdaftar pada SPT lain di rentang tanggal "
        "yang sama. Tanggal berangkat SPT baru harus lebih besar atau sama "
        "dengan tanggal kembali SPT sebelumnya."
    )

    def clean(self):
        super().clean()

        selected_rows = {}
        blank_rows = []
        has_duplicate = False

        for index, form in enumerate(self.forms, start=1):
            if not hasattr(form, "cleaned_data"):
                continue

            cleaned_data = form.cleaned_data

            if cleaned_data.get("DELETE"):
                continue

            pelaksana = cleaned_data.get("nama")
            if not pelaksana:
                blank_rows.append((index, form))
                continue

            if pelaksana.pk in selected_rows:
                first_index = selected_rows[pelaksana.pk]
                form.add_error(
                    "nama",
                    (
                        f"{pelaksana.nama} sudah dipilih pada "
                        f"Pelaksana {first_index}."
                    ),
                )
                has_duplicate = True
                continue

            selected_rows[pelaksana.pk] = index

        if not selected_rows:
            if blank_rows:
                blank_rows[0][1].add_error(
                    "nama",
                    "Pilih minimal 1 pelaksana.",
                )
            raise forms.ValidationError(self.minimum_message)

        if has_duplicate:
            raise forms.ValidationError(self.duplicate_message)

        self._validate_pelaksana_schedule(selected_rows)

    def _get_parent_departure_date(self):
        if self.is_bound:
            departure_date = parse_date(self.data.get("tgl_berangkat", ""))
            if departure_date:
                return departure_date

            for key in self.data.keys():
                if key.endswith("-tgl_berangkat"):
                    departure_date = parse_date(self.data.get(key, ""))
                    if departure_date:
                        return departure_date

        if self.instance and self.instance.tgl_berangkat:
            return self.instance.tgl_berangkat

        return None

    def _validate_pelaksana_schedule(self, selected_rows):
        departure_date = self._get_parent_departure_date()
        if not departure_date:
            return

        conflicting_pelaksana = _get_pelaksana_schedule_conflicts(
            selected_rows.keys(),
            departure_date,
            exclude_spt_id=self.instance.pk if self.instance else None,
        )

        conflicts_by_pegawai = {
            pelaksana.nama_id: pelaksana
            for pelaksana in conflicting_pelaksana
        }
        if not conflicts_by_pegawai:
            return

        for pegawai_id, row_index in selected_rows.items():
            conflict = conflicts_by_pegawai.get(pegawai_id)
            if not conflict:
                continue

            self.forms[row_index - 1].add_error(
                "nama",
                _format_pelaksana_schedule_conflict(conflict),
            )

        raise forms.ValidationError(self.schedule_conflict_message)


class PemberiTugasForm(BaseAppModelForm):
    TASK_VALIDATION_MESSAGES = {
        "Bupati": (
            "SPT untuk Bupati harus memiliki minimal satu "
            "pelaksana dengan eselon II."
        ),
        "Kepala": (
            "SPT untuk Kepala harus memiliki minimal satu "
            "pelaksana eselon III atau non eselon."
        ),
        "Sekretaris Daerah": (
            "SPT untuk Sekretaris Daerah harus memiliki minimal satu "
            "pelaksana mulai eselon II sampai non eselon."
        ),
        "Wakil Bupati": (
            "SPT untuk Wakil Bupati harus memiliki minimal satu "
            "pelaksana dengan eselon II."
        ),
    }

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
            }, format="%Y-%m-%d"),
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
            exclude_tasks=("PPK",),
        )

        if active_opd_id and self.instance and self.instance.penandatangan_id:
            penandatangan_queryset = Penandatangan.objects.select_related(
                "jenis_jabatan",
                "opd",
            ).filter(
                Q(pk__in=penandatangan_queryset.values("pk")) |
                Q(pk=self.instance.penandatangan_id) |
                Q(tugas__in=get_global_penandatangan_tasks(self.request))
            ).distinct().order_by("nama")

            if self.instance.penandatangan.tugas != "PPK":
                penandatangan_queryset = penandatangan_queryset.exclude(
                    tugas="PPK"
                )

        self.fields["spt"].queryset = spt_queryset
        self.fields["penandatangan"].queryset = penandatangan_queryset
        self.fields["spt"].label_from_instance = self._format_spt_label
        self.order_fields([
            "spt",
            "penandatangan",
            "nomor_spt",
            "nomor_spd",
            "tanggal_spt",
        ])

    @staticmethod
    def _format_spt_label(obj):
        lokasi = obj.kota_tujuan_display or "-"
        tanggal = (
            obj.tgl_berangkat.strftime("%d-%m-%Y")
            if obj.tgl_berangkat else "-"
        )
        return f"SPT #{obj.pk} - {lokasi} - {tanggal}"

    def clean(self):
        cleaned_data = super().clean()
        spt = cleaned_data.get("spt")
        penandatangan = cleaned_data.get("penandatangan")

        for field_name, message in (
            (
                "nomor_spt",
                "Nomor SPT sudah digunakan. Isi nomor SPT yang berbeda.",
            ),
            (
                "nomor_spd",
                "Nomor SPD sudah digunakan. Isi nomor SPD yang berbeda.",
            ),
        ):
            value = _normalize_optional_document_number(
                cleaned_data.get(field_name)
            )
            cleaned_data[field_name] = value

            if not value:
                continue

            if (
                PemberiTugas.objects.exclude(pk=self.instance.pk)
                .filter(**{field_name: value})
                .exists()
            ):
                self.add_error(field_name, message)

        if spt and penandatangan:
            active_opd_id = get_active_opd_id(self.request)
            pelaksana_queryset = spt.pelaksana.select_related(
                "nama",
                "nama__eselon",
            )
            pelaksana_scope = get_spt_pelaksana_scope(
                pelaksana_queryset,
                penandatangan.tugas,
                opd_id=active_opd_id,
            )
            matching_pelaksana = filter_spt_pelaksana(
                pelaksana_scope,
                penandatangan.tugas,
                opd_id=active_opd_id,
                signatory_opd_id=getattr(penandatangan, "opd_id", None),
            )
            validation_message = self.TASK_VALIDATION_MESSAGES.get(
                penandatangan.tugas,
            )

            if validation_message and not matching_pelaksana:
                if (
                    penandatangan.tugas == "Kepala"
                    and is_single_eselon_two_pelaksana(pelaksana_scope)
                ):
                    return cleaned_data
                self.add_error(
                    "spt",
                    validation_message,
                )

        return cleaned_data


PelaksanaFormSet = inlineformset_factory(
    parent_model=Spt,
    model=Pelaksana,
    form=PelaksanaForm,
    formset=BasePelaksanaInlineFormSet,
    extra=1,
    can_delete=True,
)

class TtdSptSpdForm(BaseAppModelForm):
    field_layout = {
        "pemberi_tugas": 6,
        "hardcopy": 6,
    }

    class Meta:
        model = TtdSptSpd
        fields = [
            "pemberi_tugas",
            "hardcopy",
        ]
        labels = {
            "pemberi_tugas": "Pemberi Tugas",
            "hardcopy": "Hard Copy TTD SPT/SPD",
        }
        widgets = {
            "pemberi_tugas": forms.Select(attrs={
                "class": "form-control select2",
                "placeholder": "Masukkan nama pemberi tugas",
            }),
            "hardcopy": forms.ClearableFileInput(attrs={
                "class": "form-control",
            }),
        }
        

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["hardcopy"].help_text = (
            "Upload Hard Copy SPT/SPD yang sudah di tandatangani."
        )
        self.fields["pemberi_tugas"].label_from_instance = self._format_ttdsptspd_label
    
    @staticmethod
    def _format_ttdsptspd_label(obj):
        spt = obj.spt
        lokasi = spt.kota_tujuan_display or "-"
        tanggal = (
            spt.tgl_berangkat.strftime("%d-%m-%Y")
            if spt.tgl_berangkat else "-"
        )
        return f"SPT #{spt.pk} - {obj.penandatangan} - {lokasi} - {tanggal}"
