from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Contacts import views

urlpatterns = patterns('Contacts.views',
    url(r'^contacts/$', 'contact_list'),
    url(r'^contacts/(?P<pk>[0-9]+)/$', 'contact_detail'),
    url(r'^contacttag/$', views.ContactTagList.as_view()),
    url(r'^contacttag/(?P<pk>[0-9]+)/$', views.ContactTagDetail.as_view()),
)

urlpatterns = format_suffix_patterns(urlpatterns)