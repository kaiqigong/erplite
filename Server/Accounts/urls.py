from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Accounts import views

urlpatterns = patterns('Accounts.views',
	url(r'^$', 'index',name="index"),
	url(r'^index$', 'index',name="accounts_index"),
	url(r'^register$', 'register',name="register"),
	url(r'^login$', 'login',name="login"),
	url(r'^logout$', 'logout',name="logout"),
	url(r'^generate$', 'generate',name="generate"),
)
