from django import forms
from django.contrib.auth.models import User
from .models import OPD, Role, UserProfile


class OPDForm(forms.ModelForm):
    class Meta:
        model = OPD
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
        }


class RoleForm(forms.ModelForm):
    class Meta:
        model = Role
        fields = '__all__'
        widgets = {
            'nama': forms.TextInput(attrs={'class': 'form-control'}),
        }


class UserProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = '__all__'
        widgets = {
            'user': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih User'}),
            'opd': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih OPD'}),
            'role': forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih Role'}),
        }


class UserWithProfileForm(forms.Form):
    username = forms.CharField(max_length=150, widget=forms.TextInput(attrs={'class': 'form-control'}))
    email = forms.EmailField(widget=forms.EmailInput(attrs={'class': 'form-control'}))
    password1 = forms.CharField(label='Password', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    password2 = forms.CharField(label='Konfirmasi Password', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    opd = forms.ModelChoiceField(queryset=OPD.objects.all(), required=False, widget=forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih OPD'}))
    role = forms.ModelChoiceField(queryset=Role.objects.all(), required=False, widget=forms.Select(attrs={'class': 'form-select select2', 'data-placeholder': 'Pilih Role'}))

    def clean(self):
        cleaned_data = super().clean()
        password1 = cleaned_data.get('password1')
        password2 = cleaned_data.get('password2')

        if password1 and password2 and password1 != password2:
            raise forms.ValidationError('Password tidak cocok')

        username = cleaned_data.get('username')
        if User.objects.filter(username=username).exists():
            raise forms.ValidationError('Username sudah digunakan')

        return cleaned_data

    def save(self):
        username = self.cleaned_data['username']
        email = self.cleaned_data['email']
        password = self.cleaned_data['password1']
        opd = self.cleaned_data.get('opd')
        role = self.cleaned_data.get('role')

        user = User.objects.create_user(username=username, email=email, password=password)
        # UserProfile is created automatically by signal, so update it
        user_profile, created = UserProfile.objects.get_or_create(user=user, defaults={'opd': opd, 'role': role})
        if not created:
            user_profile.opd = opd
            user_profile.role = role
            user_profile.save()

        return user_profile
