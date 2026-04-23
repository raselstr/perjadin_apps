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