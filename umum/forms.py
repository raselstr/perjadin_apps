from django import forms
from .models import Pegawai, Penandatangan, Pangkat, JenisJabatan, StatusASN, Tingkat

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
        }

class PegawaiForm(forms.ModelForm):
    class Meta:
        model = Pegawai
        fields = '__all__'
        widgets = {
            'nip': forms.TextInput(attrs={'class': 'form-control'}),
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'pangkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Pangkat'}),
            'jabatan': forms.TextInput(attrs={'class': 'form-control'}),
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


        