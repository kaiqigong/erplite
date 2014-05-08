from django.conf.urls import patterns, include, url
from django.contrib import admin
from Contacts import views
from rest_framework.routers import DefaultRouter
from rest_framework_nested import routers

admin.autodiscover()

# router = routers.SimpleRouter()

router = DefaultRouter()
router.register(r'contacts', views.ContactViewSet)
router.register(r'contacttag', views.ContactTagViewSet)
router.register(r'contactdata', views.ContactDataViewSet)
router.register(r'contactlink', views.ContactLinkViewSet)

contacts_router = routers.NestedSimpleRouter(router, r'contacts', lookup='contact')
contacts_router.register(r'contactdata', views.ContactDataViewSet)
contacts_router.register(r'contacttag', views.ContactTagViewSet)


urlpatterns = patterns('',
    (r'^app/(?P<path>.*)','django.views.static.serve',{'document_root':'app'}),
    (r'^media/(?P<path>.*)','django.views.static.serve',{'document_root':'media'}),
    (r'^mockData/(?P<path>.*)','django.views.static.serve',{'document_root':'mockData'}),
    url(r'^admin/', include(admin.site.urls)),
    # url(r'^', include('Contacts.urls')),
    url(r'^', include(router.urls)),
    url(r'^', include(contacts_router.urls)),
    url(r'^accounts/', include('Accounts.urls')),
    url(r'^files/', include('FileUpload.urls')),
    # url(r'^login/', 'rest_framework.authtoken.views.obtain_auth_token'),
    url(r'^login/', include('provider.oauth2.urls', namespace = 'oauth2')),
    # url(r'^login/', include('oauth2_provider.urls', namespace='oauth2_provider')),
  )
