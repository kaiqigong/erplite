# Create your views here.
# from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics
from rest_framework.reverse import reverse

from Contacts.models import Contacts, ContactTag, ContactData, ContactLink
from Contacts.serializers import ContactsListSerializer, ContactsDetailSerializer, ContactTagSerializer, ContactDataSerializer, ContactLinkSerializer
from Contacts.filters import ContactsFilter

from rest_framework.authentication import TokenAuthentication, BasicAuthentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets

@api_view(('GET',))
def api_root(request, format=None):
    return Response({
        'contact': reverse('contacts-list', request=request, format=format),
        'contacttag': reverse('contacttag-list', request=request, format=format),
        'contactdata': reverse('contactdata-list', request=request, format=format),
        'contactlink': reverse('contactlink-list', request=request, format=format),
    })

# class ContactList(generics.ListCreateAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = Contacts.objects.all()
# 	serializer_class = ContactsListSerializer
# 	filter_class = ContactsFilter

# class ContactDetail(generics.RetrieveUpdateDestroyAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = Contacts.objects.all()
# 	serializer_class = ContactsDetailSerializer

class ContactViewSet(viewsets.ModelViewSet):
	authentication_classes = (TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = Contacts.objects.all()
	serializer_class = ContactsDetailSerializer


# class ContactTagList(generics.ListCreateAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = ContactTag.objects.all()
# 	serializer_class = ContactTagSerializer

# class ContactTagDetail(generics.RetrieveUpdateDestroyAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = ContactTag.objects.all()
# 	serializer_class = ContactTagSerializer

class ContactTagViewSet(viewsets.ModelViewSet):
	authentication_classes = (TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = ContactTag.objects.all()
	serializer_class = ContactTagSerializer

# class ContactDataList(generics.ListCreateAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = ContactData.objects.all()
# 	serializer_class = ContactDataSerializer

# class ContactDataDetail(generics.RetrieveUpdateDestroyAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = ContactData.objects.all()
# 	serializer_class = ContactDataSerializer

class ContactDataViewSet(viewsets.ModelViewSet):
	authentication_classes = (TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	queryset = ContactData.objects.all()
	serializer_class = ContactDataSerializer	

# class ContactLinkList(generics.ListCreateAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)

# 	queryset = ContactLink.objects.all()
# 	serializer_class = ContactLinkSerializer

# class ContactLinkDetail(generics.RetrieveUpdateDestroyAPIView):
# 	authentication_classes = (TokenAuthentication, BasicAuthentication)
# 	permission_classes = (IsAuthenticated,)
	
# 	queryset = ContactLink.objects.all()
# 	serializer_class = ContactLinkSerializer

class ContactLinkViewSet(viewsets.ModelViewSet):
	authentication_classes = (TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)
	
	queryset = ContactLink.objects.all()
	serializer_class = ContactLinkSerializer










