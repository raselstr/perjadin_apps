from django import forms
from django.contrib.auth.models import User
from umum.models import Pegawai
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
            'foto': forms.ClearableFileInput(attrs={
                'class': 'form-control',
                'accept': 'image/*',
                'capture': 'environment',
            }),
        }


class AccountSettingsForm(forms.Form):
    first_name = forms.CharField(label="Nama Depan", required=False, widget=forms.TextInput(attrs={"class": "form-control"}))
    last_name = forms.CharField(label="Nama Belakang", required=False, widget=forms.TextInput(attrs={"class": "form-control"}))
    email = forms.EmailField(label="Email", required=False, widget=forms.EmailInput(attrs={"class": "form-control"}))
    foto_user = forms.ImageField(label="Foto User", required=False, widget=forms.ClearableFileInput(attrs={"class": "form-control", "accept": "image/*", "capture": "environment"}))
    nama = forms.CharField(label="Nama Pegawai", required=False, widget=forms.TextInput(attrs={"class": "form-control"}))
    jabatan = forms.CharField(label="Jabatan", required=False, widget=forms.TextInput(attrs={"class": "form-control"}))
    tgl_lahir = forms.DateField(label="Tanggal Lahir", required=False, widget=forms.DateInput(attrs={"class": "form-control", "type": "date"}))
    foto_pegawai = forms.ImageField(label="Foto Pegawai", required=False, widget=forms.ClearableFileInput(attrs={"class": "form-control", "accept": "image/*", "capture": "environment"}))

    def __init__(self, *args, **kwargs):
        self.user = kwargs.pop("user")
        super().__init__(*args, **kwargs)
        self.pegawai = Pegawai.objects.filter(nip=self.user.username).first()
        if not self.is_bound:
            self.fields["first_name"].initial = self.user.first_name
            self.fields["last_name"].initial = self.user.last_name
            self.fields["email"].initial = self.user.email
            if self.pegawai:
                self.fields["nama"].initial = self.pegawai.nama
                self.fields["jabatan"].initial = self.pegawai.jabatan
                self.fields["tgl_lahir"].initial = self.pegawai.tgl_lahir

    def save(self):
        user = self.user
        user.first_name = self.cleaned_data.get("first_name", "")
        user.last_name = self.cleaned_data.get("last_name", "")
        user.email = self.cleaned_data.get("email", "")
        user.save()

        profile, _ = UserProfile.objects.get_or_create(user=user)
        if self.cleaned_data.get("foto_user"):
            profile.foto = self.cleaned_data["foto_user"]
            profile.save()

        if self.pegawai:
            self.pegawai.nama = self.cleaned_data.get("nama") or self.pegawai.nama
            self.pegawai.jabatan = self.cleaned_data.get("jabatan") or self.pegawai.jabatan
            self.pegawai.tgl_lahir = self.cleaned_data.get("tgl_lahir")
            if self.cleaned_data.get("foto_pegawai"):
                self.pegawai.foto = self.cleaned_data["foto_pegawai"]
            self.pegawai.save()


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
