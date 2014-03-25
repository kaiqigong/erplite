from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Contacts import views

urlpatterns = patterns('Contacts.views',
    url(r'^contacts/$', views.ContactList.as_view()),
    url(r'^contacts/(?P<pk>[0-9]+)/$', views.ContactDetail.as_view()),
    url(r'^contacttag/$', views.ContactTagList.as_view()),
    url(r'^contacttag/(?P<pk>[0-9]+)/$', views.ContactTagDetail.as_view()),
    url(r'^contactlink/$', views.ContactLinkList.as_view()),
    url(r'^contactlink/(?P<pk>[0-9]+)/$', views.ContactLinkDetail.as_view()),
    url(r'^contactdata/$', views.ContactDataList.as_view()),
    url(r'^contactdata/(?P<pk>[0-9]+)/$', views.ContactDataDetail.as_view()),
)

urlpatterns = format_suffix_patterns(urlpatterns)