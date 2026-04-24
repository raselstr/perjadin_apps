from django import forms
from .models import DasarPeraturan, JenisSPD, JenisKegiatan, JenisTransportasi, Lokasi, StandardPenginapan, StandardPesawat, StandardRepresentasi, StandardTransportasi, StandardUangHarian

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
            'kota': forms.TextInput(attrs={'class': 'form-control'}),
            'jenis_spd': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis SPD'}),
        }

class StandardPenginapanForm(forms.ModelForm):
    class Meta:
        model = StandardPenginapan
        fields = '__all__'
        widgets = {
            'dasar_peraturan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Dasar Peraturan'}),
            'lokasi': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Lokasi'}),
            'tingkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Tingkat'}),
            'satuan': forms.TextInput(attrs={'class': 'form-control'}),
            'biaya': forms.NumberInput(attrs={'class': 'form-control'}),
        }

class StandardPesawatForm(forms.ModelForm):
    class Meta:
        model = StandardPesawat
        fields = '__all__'
        widgets = {
            'dasar_peraturan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Dasar Peraturan'}),
            'kota_asal': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Kota Asal'}),
            'kota_tujuan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Kota Tujuan'}),
            'tingkat': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Tingkat'}),
            'biaya': forms.NumberInput(attrs={'class': 'form-control'}),
        }

class StandardUangHarianForm(forms.ModelForm):
    class Meta:
        model = StandardUangHarian
        fields = '__all__'
        widgets = {
            'dasar_peraturan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Dasar Peraturan'}),
            'lokasi': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Lokasi'}),
            'jenis_kegiatan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis Kegiatan'}),
            'satuan': forms.TextInput(attrs={'class': 'form-control'}),
            'biaya': forms.NumberInput(attrs={'class': 'form-control'}),
        }

class JenisTransportasiForm(forms.ModelForm):
    class Meta:
        model = JenisTransportasi
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
        }

class StandardTransportasiForm(forms.ModelForm):
    class Meta:
        model = StandardTransportasi
        fields = '__all__'
        widgets = {
            'dasar_peraturan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Dasar Peraturan'}),
            'jenis_transportasi': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis Transportasi'}),
            'kota_tujuan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Kota Tujuan'}),
            'satuan': forms.TextInput(attrs={'class': 'form-control'}),
            'biaya': forms.NumberInput(attrs={'class': 'form-control'}),
        }

class StandardRepresentasiForm(forms.ModelForm):
    class Meta:
        model = StandardRepresentasi
        fields = '__all__'
        widgets = {
            'dasar_peraturan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Dasar Peraturan'}),
            'jenis_jabatan': forms.Select(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis Jabatan'}),
            'jenis_spds': forms.SelectMultiple(attrs={'class': 'form-select select2','data-placeholder': 'Pilih Jenis SPD'}),   
            'biaya': forms.NumberInput(attrs={'class': 'form-control'}),
        }

        