from django.conf.urls import patterns, include, url
# from django.contrib.auth.models import User, Group
# from rest_framework import routers
# from Contacts import views

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

# router = routers.DefaultRouter()
# router.register(r'contacts', views.ContactListViewSet)
# router.register(r'contacttag', views.ContactTagViewSet)
# router.register(r'contactdata', views.ContactDataViewSet)
# router.register(r'contactlink', views.ContactLinkViewSet)


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Server.views.home', name='home'),
    # url(r'^Server/', include('Server.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    (r'^app/(?P<path>.*)','django.views.static.serve',{'document_root':'app'}),
    (r'^mockData/(?P<path>.*)','django.views.static.serve',{'document_root':'mockData'}),
    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^', include('Contacts.urls')),
    # url(r'^', include(router.urls)),
    # url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
  )
