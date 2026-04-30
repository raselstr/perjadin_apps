from django import forms
from core.forms import BaseAppModelForm

from .models import (
    Eselon,
    Pegawai,
    Pemda,
    Penandatangan,
    Pangkat,
    JenisJabatan,
    StatusASN,
    Tingkat,
)

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
            'keteraapian': forms.TextInput(attrs={'class': 'form-control'}),
            'lainnya': forms.TextInput(attrs={'class': 'form-control'}),
        }

class PegawaiForm(forms.ModelForm):
    field_layout = {
        "nip": 6,
        "nama": 6,
        "pangkat": 6,
        "jabatan": 6,
        "eselon": 4,
        "jenis_jabatan": 4,
        "status": 4,
        "tgl_lahir": 6,
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
            }),
            'opd': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih OPD'}),
            'tingkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Tingkat'}),
        }
        
class PenandatanganForm(forms.ModelForm):
    class Meta:
        model = Penandatangan
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'nip': forms.TextInput(attrs={'class': 'form-control'}),
            'pangkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Pangkat'}),
            'tugas': forms.TextInput(attrs={'class': 'form-control'}),
            'jenis_jabatan': forms.Select(attrs={'class': 'form-select select2','data-placeholder':'Jenis Jabatan'}),
            'opd': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih OPD'}),
        }


class PemdaForm(BaseAppModelForm):
    field_layout = {
        "nama_pemda": 12,
        "nama_dinas": 12,
        "alamat": 12,
        "telepon": 6,
        "email": 6,
        "jenis_kop": 6,
        "logo": 6,
    }

    class Meta:
        model = Pemda
        fields = [
            "nama_pemda",
            "nama_dinas",
            "alamat",
            "telepon",
            "email",
            "jenis_kop",
            "logo",
        ]
        labels = {
            "nama_pemda": "Nama Pemda",
            "nama_dinas": "Nama Dinas/Badan/Kantor",
            "jenis_kop": "Jenis Kop",
        }
        widgets = {
            "nama_pemda": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nama pemerintah daerah",
            }),
            "nama_dinas": forms.TextInput(attrs={
                "class": "form-control",
                "placeholder": "Masukkan nama dinas/badan/kantor",
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
            "jenis_kop": forms.Select(attrs={
                "class": "form-select",
            }),
            "logo": forms.ClearableFileInput(attrs={
                "class": "form-control",
            }),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields["logo"].help_text = (
            "Upload logo resmi jika ingin dipakai pada kop surat."
        )


        
