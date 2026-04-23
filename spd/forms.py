from django import forms
from .models import DasarPeraturan, JenisSPD, JenisKegiatan, Lokasi, StandardPenginapan

class DasarPeraturanForm(forms.ModelForm):
    class Meta:
        model = DasarPeraturan
        fields = '__all__'
        widgets = {
            'nama_peraturan': forms.TextInput(attrs={'class': 'form-control'}),
            'nomor_peraturan': forms.TextInput(attrs={'class': 'form-control'}),
            'tanggal_peraturan': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'keterangan': forms.Textarea(attrs={'class': 'form-control', 'rows': 3}),
            'aktif': forms.CheckboxInput(attrs={'class': 'form-check-input'}),

        }

class JenisSPDForm(forms.ModelForm):
    class Meta:
        model = JenisSPD
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
        }

class JenisKegiatanForm(forms.ModelForm):
    class Meta:
        model = JenisKegiatan
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
        }

class LokasiForm(forms.ModelForm):
    class Meta:
        model = Lokasi
        fields = '__all__'
        widgets = {
            'lokasi': forms.TextInput(attrs={'class': 'form-control'}),
            'jenis_spd': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis SPD'}),
        }