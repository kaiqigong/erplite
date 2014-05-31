from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Account import views

urlpatterns = patterns('Account.views',
	url(r'^register$', 'register',name="register"),
	url(r'^changepwd$', 'changePwd', name="changepwd"),
)