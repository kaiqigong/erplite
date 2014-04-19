#coding=utf-8
from django import forms
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _

class RegisterForm(forms.Form):
	email=forms.EmailField(label=_(u"邮件"),max_length=30,widget=forms.TextInput(attrs={'size': 30,}))
	password=forms.CharField(label=_(u"密码"),max_length=30,widget=forms.PasswordInput(attrs={'size': 20,}))
	username=forms.CharField(label=_(u"昵称"),max_length=30,widget=forms.TextInput(attrs={'size': 20,}))

	def clean_username(self):
		'''验证重复昵称'''
		users = User.objects.filter(username__iexact=self.cleaned_data["username"])
		if not users:
			return self.cleaned_data["username"]
		raise forms.ValidationError(_(u"该昵称已经被使用请使用其他的昵称"))

	def clean_email(self):
		'''验证重复email'''
		emails = User.objects.filter(email__iexact=self.cleaned_data["email"])
		if not emails:
			return self.cleaned_data["email"]
		raise forms.ValidationError(_(u"该邮箱已经被使用请使用其他的"))

class LoginForm(forms.Form):
	username=forms.CharField(label=_(u"昵称"),max_length=30,widget=forms.TextInput(attrs={'size': 20,}))
	password=forms.CharField(label=_(u"密码"),max_length=30,widget=forms.PasswordInput(attrs={'size': 20,}))


class ChangepwdForm(forms.Form):
	oldpassword = forms.CharField(
		required=True,
		label=u"原密码",
		error_messages={'required': u'请输入原密码'},
		widget=forms.PasswordInput(
			attrs={
				'placeholder':u"原密码",
			}
		),
	)
	newpassword1 = forms.CharField(
		required=True,
		label=u"新密码",
		error_messages={'required': u'请输入新密码'},
		widget=forms.PasswordInput(
			attrs={
				'placeholder':u"新密码",
			}
		),
	)
	newpassword2 = forms.CharField(
		required=True,
		label=u"确认密码",
		error_messages={'required': u'请再次输入新密码'},
		widget=forms.PasswordInput(
			attrs={
				'placeholder':u"确认密码",
			}
		),
	 )
	def clean(self):
		if not self.is_valid():
			raise forms.ValidationError(u"所有项都为必填项")
		elif self.cleaned_data['newpassword1'] <> self.cleaned_data['newpassword2']:
			raise forms.ValidationError(u"两次输入的新密码不一样")
		else:
			cleaned_data = super(ChangepwdForm, self).clean()
		return cleaned_data

