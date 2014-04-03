# Create your views here.
# from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics
from rest_framework.reverse import reverse

from Contacts.models import Contacts, ContactTag, ContactData, ContactLink
from Contacts.serializers import ContactsListSerializer, ContactsDetailSerializer, ContactTagSerializer, ContactDataSerializer, ContactLinkSerializer
from Contacts.filters import ContactsFilter
# from rest_framework import viewsets

@api_view(('GET',))
def api_root(request, format=None):
    return Response({
        'contact': reverse('contacts-list', request=request, format=format),
        'contacttag': reverse('contacttag-list', request=request, format=format),
        'contactdata': reverse('contactdata-list', request=request, format=format),
        'contactlink': reverse('contactlink-list', request=request, format=format),
    })

class ContactList(generics.ListCreateAPIView):
	queryset = Contacts.objects.all()
	serializer_class = ContactsListSerializer
	filter_class = ContactsFilter

class ContactDetail(generics.RetrieveUpdateDestroyAPIView):
	queryset = Contacts.objects.all()
	serializer_class = ContactsDetailSerializer

class ContactTagList(generics.ListCreateAPIView):
	queryset = ContactTag.objects.all()
	serializer_class = ContactTagSerializer

class ContactTagDetail(generics.RetrieveUpdateDestroyAPIView):
	queryset = ContactTag.objects.all()
	serializer_class = ContactTagSerializer

class ContactDataList(generics.ListCreateAPIView):
	queryset = ContactData.objects.all()
	serializer_class = ContactDataSerializer

class ContactDataDetail(generics.RetrieveUpdateDestroyAPIView):
	queryset = ContactData.objects.all()
	serializer_class = ContactDataSerializer

class ContactLinkList(generics.ListCreateAPIView):
	queryset = ContactLink.objects.all()
	serializer_class = ContactLinkSerializer

class ContactLinkDetail(generics.RetrieveUpdateDestroyAPIView):
	queryset = ContactLink.objects.all()
	serializer_class = ContactLinkSerializer










