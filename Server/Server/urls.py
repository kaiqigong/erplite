from django.conf.urls import patterns, include, url
from django.contrib import admin
admin.autodiscover()


urlpatterns = patterns('',
    (r'^app/(?P<path>.*)','django.views.static.serve',{'document_root':'app'}),
    (r'^mockData/(?P<path>.*)','django.views.static.serve',{'document_root':'mockData'}),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^', include('Contacts.urls')),
    url(r'^accounts/', include('Accounts.urls')),
    url(r'^login/', 'rest_framework.authtoken.views.obtain_auth_token'),
  )
