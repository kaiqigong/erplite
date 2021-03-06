# Create your views here.
# from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics
from rest_framework.reverse import reverse

from Contacts.models import Contacts, ContactTag, ContactData, ContactLink
from Contacts.serializers import ContactsListSerializer, ContactsDetailSerializer, ContactTagSerializer, ContactDataSerializer, ContactLinkSerializer

from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication, OAuth2Authentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets

from rest_framework_extensions.mixins import DetailSerializerMixin

from rest_framework import filters

# from oauth2_provider.ext.rest_framework import TokenHasReadWriteScope, TokenHasScope

# @api_view(('GET',))
# def api_root(request, format=None):
# 	return Response({
# 		'contact': reverse('contacts-list', request=request, format=format),
# 		'contacttag': reverse('contacttag-list', request=request, format=format),
# 		'contactdata': reverse('contactdata-list', request=request, format=format),
# 		'contactlink': reverse('contactlink-list', request=request, format=format),
# 	})


class ContactViewSet(DetailSerializerMixin, viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)# TokenHasReadWriteScope)

	queryset = Contacts.objects.all()
	serializer_class = ContactsListSerializer
	serializer_detail_class = ContactsDetailSerializer
	# filter_class = ContactsFilter
	filter_backends = (filters.OrderingFilter, filters.SearchFilter,)
	ordering_fields = ('name')
	search_fields = ('name', 'description')

class ContactTagViewSet(viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)#, TokenHasReadWriteScope)

	queryset = ContactTag.objects.all()
	serializer_class = ContactTagSerializer

	filter_backends = (filters.SearchFilter,)
	search_fields = ('tag',)

	def get_queryset(self):
		contact_id = self.kwargs.get('contact_pk', None)
		if contact_id:
			return ContactTag.objects.filter(contact=contact_id)
		return super(ContactTagViewSet, self).get_queryset()

class ContactDataViewSet(viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)#, TokenHasReadWriteScope)

	queryset = ContactData.objects.all()
	serializer_class = ContactDataSerializer
	# serializer_detail_class = ContactDataDetailSerializer

	filter_backends = (filters.SearchFilter,)
	search_fields = ('surname','givenname','department','title','company')

	def get_queryset(self, is_for_detail=False):
		contact_id = self.kwargs.get('contact_pk', None)
		if contact_id:
			return ContactData.objects.filter(contact=contact_id)
		return super(ContactDataViewSet, self).get_queryset()

class ContactLinkViewSet(viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)#, TokenHasReadWriteScope)

	queryset = ContactLink.objects.all()
	serializer_class = ContactLinkSerializer
