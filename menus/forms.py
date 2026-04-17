from django import forms
from .models import Menu, SubMenu


class MenuForm(forms.ModelForm):
    class Meta:
        model = Menu
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'icon': forms.TextInput(attrs={'class': 'form-control'}),
            'urutan': forms.NumberInput(attrs={'class': 'form-control'}),
        }


class SubMenuForm(forms.ModelForm):
    class Meta:
        model = SubMenu
        fields = '__all__'
        widgets = {
            'menu': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih Menu'}),
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
            'url': forms.TextInput(attrs={'class': 'form-control'}),
            'urutan': forms.NumberInput(attrs={'class': 'form-control'}),
        }
