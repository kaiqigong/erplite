# Create your views here.
# from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics
from rest_framework.reverse import reverse

from Contacts.models import Contacts, ContactTag, ContactData, ContactLink
from Contacts.serializers import ContactsListSerializer, ContactsDetailSerializer, ContactTagSerializer, ContactDataSerializer, ContactLinkSerializer
from Contacts.filters import ContactsFilter

from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets

from rest_framework_extensions.mixins import DetailSerializerMixin

@api_view(('GET',))
def api_root(request, format=None):
	return Response({
		'contact': reverse('contacts-list', request=request, format=format),
		'contacttag': reverse('contacttag-list', request=request, format=format),
		'contactdata': reverse('contactdata-list', request=request, format=format),
		'contactlink': reverse('contactlink-list', request=request, format=format),
	})


class ContactViewSet(DetailSerializerMixin, viewsets.ModelViewSet):
	authentication_classes = (SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = Contacts.objects.all()
	serializer_class = ContactsListSerializer
	serializer_detail_class = ContactsDetailSerializer

class ContactTagViewSet(viewsets.ModelViewSet):
	authentication_classes = (SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = ContactTag.objects.all()
	serializer_class = ContactTagSerializer

	def get_queryset(self):
		contact_id = self.kwargs.get('contact_pk', None)
		print contact_id
		if contact_id:
			return ContactTag.objects.filter(contact=contact_id)
		return super(ContactTagViewSet, self).get_queryset()

class ContactDataViewSet(viewsets.ModelViewSet):
	authentication_classes = (SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = ContactData.objects.all()
	serializer_class = ContactDataSerializer

	def get_queryset(self):
		contact_id = self.kwargs.get('contact_pk', None)
		print contact_id
		if contact_id:
			return ContactData.objects.filter(contact=contact_id)
		return super(ContactDataViewSet, self).get_queryset()

class ContactLinkViewSet(viewsets.ModelViewSet):
	authentication_classes = (SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = ContactLink.objects.all()
	serializer_class = ContactLinkSerializer
