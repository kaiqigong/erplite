# Create your views here.
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from Contacts.models import Contacts
from Contacts.serializers import ContactsSerializer

@api_view(['GET', 'POST'])
def contact_list(request, format=None):
	if request.method == 'GET':
		contacts = Contacts.objects.all()
		serializer = ContactsSerializer(contacts, many=True)
		return Response(serializer.data)
	elif request.method == 'POST':
		serializer = ContactsSerializer(data=request.DATA)
		if serializer.is_valid():
			serializer.save()
			return Response(serializer.data, status=status.HTTP_201_CREATED)
		return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET', 'PUT', 'DELETE'])
def contact_detail(request, pk, format=None):
	try:
		contacts = Contacts.objects.get(pk=pk)
	except Contacts.DoesNotExist:
		return Response(status=status.HTTP_404_NOT_FOUND)

	if request.method == 'GET':
		serializer = ContactsSerializer(contacts)
		return Response(serializer.data)

	elif request.method == 'PUT':
		serializer = ContactsSerializer(contacts, data=request.DATA)
		if serializer.is_valid():
			serializer.save()
			return Response(serializer.data)
		return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

	elif request.method == 'DELETE':
		Contacts.delete()
		return Response(status=status.HTTP_204_NO_CONTENT)