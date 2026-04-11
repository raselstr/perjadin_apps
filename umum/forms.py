from django import forms
from .models import Pegawai, Penandatangan

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
        