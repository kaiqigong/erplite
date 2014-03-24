from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns

urlpatterns = patterns('Contacts.views',
    url(r'^contacts/$', 'contact_list'),
    url(r'^contacts/(?P<pk>[0-9]+)/$', 'contact_detail'),
)

urlpatterns = format_suffix_patterns(urlpatterns)