from django.contrib.auth.forms import ReadOnlyPasswordHashWidget
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Users
from django import forms

class CustomUserForm(forms.ModelForm):
    fname = forms.CharField(widget=forms.TextInput(attrs={'class':'form-control', 'placeholder':'First Name'}))
    e_mail = forms.CharField(widget=forms.TextInput(attrs={'class':'form-control', 'placeholder':'Email'}))
    userpassword = forms.CharField(widget=forms.PasswordInput(attrs={'class':'form-control', 'placeholder':'Password'}))
    userpassword2 = forms.CharField(widget=forms.PasswordInput(attrs={'class':'form-control', 'placeholder':'Confirm Password'}))
    class Meta:
        model = Users
        fields = ('fname', 'e_mail', 'userpassword', 'userpassword2')
    def clean_userpassword2(self):
        # Check that the two password entries match
        password1 = self.cleaned_data.get("userpassword")
        password2 = self.cleaned_data.get("userpassword2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords don't match")
        return password2
    def save(self, commit=True):
        # Save the provided password in hashed format
        user = super(CustomUserForm, self).save(commit=False)
        user.set_password(self.cleaned_data["userpassword"])
        if commit:
            user.save()
        return user
    # is_valid() is called when the form is submitted. super object should have the attribute is_valid()
    def is_valid(self):
        return super(CustomUserForm, self).is_valid()
    
