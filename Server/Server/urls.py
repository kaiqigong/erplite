from django.conf.urls import patterns, include, url
from django.contrib import admin
from Contacts import views as contactView
from Tasks import views as taskView
from rest_framework.routers import DefaultRouter
from rest_framework_nested import routers

admin.autodiscover()

# router = routers.SimpleRouter()

router = DefaultRouter()
router.register(r'contacts', contactView.ContactViewSet)
router.register(r'contacttag', contactView.ContactTagViewSet)
router.register(r'contactdata', contactView.ContactDataViewSet)
router.register(r'contactlink', contactView.ContactLinkViewSet)
router.register(r'tasks',taskView.TaskViewSet)
router.register(r'users', taskView.UserViewSet)

contacts_router = routers.NestedSimpleRouter(router, r'contacts', lookup='contact')
contacts_router.register(r'contactdata', contactView.ContactDataViewSet)
contacts_router.register(r'contacttag', contactView.ContactTagViewSet)


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
