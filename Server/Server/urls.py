from django.conf.urls import patterns, include, url
from django.contrib import admin
from Contacts import views
from rest_framework.routers import DefaultRouter

admin.autodiscover()

router = DefaultRouter()
router.register(r'contacts', views.ContactViewSet)
router.register(r'contacttag', views.ContactTagViewSet)
router.register(r'ContactData', views.ContactDataViewSet)
router.register(r'ContactLink', views.ContactLinkViewSet)

urlpatterns = patterns('',
    (r'^app/(?P<path>.*)','django.views.static.serve',{'document_root':'app'}),
    (r'^media/(?P<path>.*)','django.views.static.serve',{'document_root':'media'}),
    (r'^mockData/(?P<path>.*)','django.views.static.serve',{'document_root':'mockData'}),
    url(r'^admin/', include(admin.site.urls)),
    # url(r'^', include('Contacts.urls')),
    url(r'^', include(router.urls)),
    url(r'^accounts/', include('Accounts.urls')),
    url(r'^files/', include('FileUpload.urls')),
    url(r'^login/', 'rest_framework.authtoken.views.obtain_auth_token'),
  )
