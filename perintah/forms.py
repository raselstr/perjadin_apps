from django import forms
from .models import Spt, Pelaksana

class SptForm(forms.ModelForm):
    class Meta:
        model = Spt
        fields = '__all__'
        widgets = {
            'nomor_spt': forms.TextInput(attrs={'class': 'form-control'}),
            'tanggal_spt': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'dasar': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'berita': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'kota_tujuan': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih Kota Tujuan'}),
            'lama_perjalanan': forms.Select(attrs={'class': 'form-select'}),
            'tgl_berangkat': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'tgl_kembali': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'jenis_kegiatan': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih Jenis Kegiatan'}),
            'kendaraan': forms.Select(attrs={'class': 'form-select'}),
        }

class PelaksanaForm(forms.ModelForm):
    class Meta:
        model = Pelaksana
        fields = '__all__'
        widgets = {
            'spt': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih SPT'}),
            'nama': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih Nama Pelaksana'}),
        }

