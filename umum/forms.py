from django import forms
from django.db.models import Q

from core.forms import BaseAppModelForm
from profiles.models import OPD
from profiles.utils import get_active_opd_id

from .models import (
    Eselon,
    KopSurat,
    Pegawai,
    Pemda,
    Penandatangan,
    Pangkat,
    JenisJabatan,
    StatusASN,
    Tingkat,
)


def _build_limited_opd_queryset(active_opd_id, instance_opd_id=None):
    queryset = OPD.objects.all()

    if not active_opd_id:
        return queryset

    filters = Q(pk=active_opd_id)
    if instance_opd_id:
        filters |= Q(pk=instance_opd_id)

    return queryset.filter(filters).distinct()

class PangkatForm(forms.ModelForm):
    class Meta:
        model = Pangkat
        fields = '__all__'
        widgets = {
            'pangkat': forms.TextInput(attrs={'class': 'form-control'}),
            'golongan': forms.TextInput(attrs={'class': 'form-control'}),
            'ruang': forms.TextInput(attrs={'class': 'form-control'}),
        }


class JenisJabatanForm(forms.ModelForm):
    class Meta:
        model = JenisJabatan
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'keterangan': forms.TextInput(attrs={'class': 'form-control'}),
            'fungsi': forms.TextInput(attrs={'class': 'form-control'}),
        }

class EselonForm(forms.ModelForm):
    class Meta:
        model = Eselon
        fields = '__all__'
        widgets = {
            'eselon': forms.TextInput(attrs={'class': 'form-control'}),
            'keterangan': forms.TextInput(attrs={'class': 'form-control'}),
        }


class StatusASNForm(forms.ModelForm):
    class Meta:
        model = StatusASN
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
        }

class TingkatForm(forms.ModelForm):
    class Meta:
        model = Tingkat
        fields = '__all__'
        widgets = {
            'tingkat': forms.TextInput(attrs={'class': 'form-control'}),
            'ket': forms.TextInput(attrs={'class': 'form-control'}),
            'pesawat': forms.TextInput(attrs={'class': 'form-control'}),
            'kapal': forms.TextInput(attrs={'class': 'form-control'}),
            'keretaapian': forms.TextInput(attrs={'class': 'form-control'}),
            'lainnya': forms.TextInput(attrs={'class': 'form-control'}),
        }

class PegawaiForm(BaseAppModelForm):
    field_layout = {
        "nip": 6,
        "nama": 6,
        "pangkat": 6,
        "jabatan": 6,
        "eselon": 4,
        "jenis_jabatan": 4,
        "status": 4,
        "tgl_lahir": 4,
        "foto": 4,
        "tingkat": 6,
        "opd": 12,
    }
    class Meta:
        model = Pegawai
        fields = [
            "nip",
            "nama",
            "pangkat",
            "jabatan",
            "eselon",
            "jenis_jabatan",
            "status",
            "tgl_lahir",
            "foto",
            "tingkat",
            "opd",
        ]
        widgets = {
            'nip': forms.TextInput(attrs={'class': 'form-control'}),
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'pangkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Pangkat'}),
            'jabatan': forms.TextInput(attrs={'class': 'form-control'}),
            'eselon': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Eselon'}),
            'jenis_jabatan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis Jabatan'}),
            'status': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Status'}),
            'tgl_lahir': forms.DateInput(attrs={
                'class': 'form-control',
                'type': 'date'
            }, format="%Y-%m-%d"),
            'foto': forms.ClearableFileInput(attrs={'class': 'form-control'}),
            'opd': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih OPD'}),
            'tingkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Tingkat'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_opd_id = get_active_opd_id(self.request)
        optional_fields = [
            "pangkat",
            "eselon",
            "jenis_jabatan",
            "status",
            "tgl_lahir",
            "tingkat",
            "opd",
        ]

        for field_name in optional_fields:
            self.fields[field_name].required = False

        if active_opd_id:
            self.fields["opd"].queryset = _build_limited_opd_queryset(
                active_opd_id,
                instance_opd_id=self.instance.opd_id,
            )
            self.fields["opd"].initial = (
                self.instance.opd_id or active_opd_id
            )

    def clean(self):
        cleaned_data = super().clean()
        active_opd_id = get_active_opd_id(self.request)

        if active_opd_id and not cleaned_data.get("opd"):
            cleaned_data["opd"] = OPD.objects.filter(
                pk=active_opd_id
            ).first()

        return cleaned_data
        
class PenandatanganForm(forms.ModelForm):
    accepts_request = True

    class Meta:
        model = Penandatangan
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'nip': forms.TextInput(attrs={'class': 'form-control'}),
            'pangkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Pangkat'}),
            'tugas': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Tugas'}),
            'jenis_jabatan': forms.Select(attrs={'class': 'form-select select2','data-placeholder':'Jenis Jabatan'}),
            'opd': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih OPD'}),
        }

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop("request", None)
        super().__init__(*args, **kwargs)
        active_opd_id = get_active_opd_id(self.request)
        optional_fields = ["nip", "pangkat", "jenis_jabatan", "opd"]

        for field_name in optional_fields:
            self.fields[field_name].required = False

        if active_opd_id:
            self.fields["opd"].queryset = _build_limited_opd_queryset(
                active_opd_id,
                instance_opd_id=self.instance.opd_id,
            )
            self.fields["opd"].initial = (
                self.instance.opd_id or active_opd_id
            )

    def clean(self):
        cleaned_data = super().clean()
        active_opd_id = get_active_opd_id(self.request)

        if active_opd_id and not cleaned_data.get("opd"):
            cleaned_data["opd"] = OPD.objects.filter(
                pk=active_opd_id
            ).first()

        return cleaned_data


class KopSuratForm(BaseAppModelForm):
    field_layout = {
        "pemda": 12,
        "font_family": 6,
        "print_scale_percent": 6,
        "region_font_size_pt": 6,
        "office_font_size_pt": 6,
        "address_font_size_pt": 6,
        "contact_font_size_pt": 6,
        "logo_width_px": 6,
        "logo_height_px": 6,
        "margin_top_mm": 6,
        "margin_bottom_mm": 6,
        "margin_left_mm": 6,
        "margin_right_mm": 6,
        "header_text": 12,
        "header_font_size_pt": 12,
        "header_alignment": 12,
        "footer_text": 12,
        "footer_font_size_pt": 12,
        "footer_alignment": 12,
        "default_spt_number_format": 12,
        "default_spd_number_format": 12,
        
    }

    class Meta:
        model = KopSurat
        fields = [
            "pemda",
            "font_family",
            "print_scale_percent",
            "region_font_size_pt",
            "office_font_size_pt",
            "address_font_size_pt",
            "contact_font_size_pt",
            "logo_width_px",
            "logo_height_px",
            "margin_top_mm",
            "margin_bottom_mm",
            "margin_left_mm",
            "margin_right_mm",
            "default_spt_number_format",
            "default_spd_number_format",
        ]
        widgets = {
            "pemda": forms.Select(attrs={
                "class": "form-select select2",
                "data-placeholder": "Pilih identitas Pemda",
            }),
            "font_family": forms.Select(attrs={
                "class": "form-select",
            }),
            "print_scale_percent": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 75,
                "max": 120,
            }),
            "region_font_size_pt": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 8,
                "max": 32,
            }),
            "office_font_size_pt": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 8,
                "max": 36,
            }),
            "address_font_size_pt": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 8,
                "max": 20,
            }),
            "contact_font_size_pt": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 8,
                "max": 20,
            }),
            "logo_width_px": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 40,
                "max": 180,
            }),
            "logo_height_px": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 40,
                "max": 180,
            }),
            "margin_top_mm": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 0,
                "max": 50,
            }),
            "margin_bottom_mm": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 0,
                "max": 50,
            }),
            "margin_left_mm": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 0,
                "max": 50,
            }),
            "margin_right_mm": forms.NumberInput(attrs={
                "class": "form-control",
                "min": 0,
                "max": 50,
            }),
            "default_spt_number_format": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Contoh: {nomor_urut}/{kode_pemda}/{bulan}/{tahun}",
            }),
            "default_spd_number_format": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Contoh: {nomor_urut}/{kode_pemda}/{bulan}/{tahun}",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        active_opd_id = get_active_opd_id(self.request)
        instance_pemda_id = self.instance.pemda_id

        pemda_queryset = Pemda.objects.select_related(
            "nama_dinas"
        ).order_by("nama_pemda")

        if active_opd_id:
            pemda_queryset = pemda_queryset.filter(
                Q(nama_dinas_id=active_opd_id) |
                Q(pk=instance_pemda_id)
            )

        if not self.instance.pk:
            pemda_queryset = pemda_queryset.filter(kop_surat__isnull=True)

        self.fields["pemda"].queryset = pemda_queryset.distinct()
        self.fields["pemda"].label_from_instance = self._format_pemda_label
        self.fields["print_scale_percent"].help_text = (
            "Hanya memengaruhi isi surat. KOP tidak ikut berubah."
        )

    @staticmethod
    def _format_pemda_label(obj):
        dinas = obj.nama_dinas.nama if obj.nama_dinas else "-"
        return f"{obj.nama_pemda} - {dinas}"


class PemdaForm(BaseAppModelForm):
    field_layout = {
        "nama_pemda": 12,
        "nama_dinas": 12,
        "nama_kabupaten": 6,  
        "ibukota": 6,
        "alamat": 12,
        "telepon": 4,
        "email": 4,
        "website": 4,
        "password_standar": 6,
        "logo": 6,
    }

    class Meta:
        model = Pemda
        fields = [
            "nama_pemda",
            "nama_dinas",
            "nama_kabupaten",
            "ibukota",
            "alamat",
            "telepon",
            "email",
            "website",
            "password_standar",
            "logo",
        ]
        labels = {
            "nama_pemda": "Nama Pemda",
            "nama_dinas": "Nama Dinas/Badan/Kantor",
        }
        widgets = {
            "nama_pemda": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nama pemerintah daerah",
            }),
            "nama_dinas": forms.Select(attrs={
                "class": "form-control select2",
                "placeholder": "Masukkan nama dinas/badan/kantor",
            }),
            "nama_kabupaten":forms.TextInput(attrs={
                "class":"form-control",
                "placeholder":"Masukkan Nama Kabupaten Termasuk Kata 'Kabupatebn'"
            }),
            "ibukota": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nama ibukota Lokasi Penandatangan",
            }),
            "alamat": forms.Textarea(attrs={
                "class": "form-control",
                "rows": 3,
                "placeholder": "Masukkan alamat lengkap",
            }),
            "telepon": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nomor telepon",
            }),
            "email": forms.EmailInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan alamat email",
            }),
            "website": forms.URLInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan alamat website",
            }),
            "password_standar": forms.PasswordInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan password standar pegawai",
                "autocomplete": "new-password",
            }, render_value=True),
            "logo": forms.ClearableFileInput(attrs={
                "class": "form-control",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["logo"].help_text = (
            "Upload logo resmi jika ingin dipakai pada kop surat."
        )
        active_opd_id = get_active_opd_id(self.request)

        if active_opd_id:
            self.fields["nama_dinas"].queryset = _build_limited_opd_queryset(
                active_opd_id,
                instance_opd_id=self.instance.nama_dinas_id,
            )
            self.fields["nama_dinas"].initial = (
                self.instance.nama_dinas_id or active_opd_id
            )


        
