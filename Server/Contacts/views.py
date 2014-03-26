# Create your views here.
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from Contacts.models import Contacts, ContactTag, ContactData, ContactLink
from Contacts.serializers import ContactsListSerializer, ContactsDetailSerializer, ContactTagSerializer, ContactDataSerializer, ContactLinkSerializer
from rest_framework import generics

class ContactList(generics.ListCreateAPIView):
	queryset = Contacts.objects.all()
	serializer_class = ContactsListSerializer

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










