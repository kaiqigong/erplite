from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Contacts import views

urlpatterns = patterns('Contacts.views',
    url(r'^contacts/$', views.ContactList.as_view(), name='contacts-list'),
    url(r'^contacts/(?P<pk>[0-9]+)/$', views.ContactDetail.as_view(), name='contacts-detail'),
    url(r'^contacttag/$', views.ContactTagList.as_view(), name='contacttag-list'),
    url(r'^contacttag/(?P<pk>[0-9]+)/$', views.ContactTagDetail.as_view(), name='contacttag-detail'),
    url(r'^contactlink/$', views.ContactLinkList.as_view(), name='contactlink-list'),
    url(r'^contactlink/(?P<pk>[0-9]+)/$', views.ContactLinkDetail.as_view(), name='contactlink-detail'),
    url(r'^contactdata/$', views.ContactDataList.as_view(), name='contactdata-list'),
    url(r'^contactdata/(?P<pk>[0-9]+)/$', views.ContactDataDetail.as_view(), name='contactdata-detail'),
)

urlpatterns = format_suffix_patterns(urlpatterns)