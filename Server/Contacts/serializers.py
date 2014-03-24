from rest_framework import serializers
from Contacts.models import Contacts, ContactTag, ContactData, ContactLink

class ContactsSerializer(serializers.ModelSerializer):
	class Meta:
		model = Contacts
		fields = ('name', 'avator', 'description', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class ContactTagSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='name')
	class Meta:
		model = ContactTag
		fields = ('contactname','tag', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

class ContactDataSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='name')
	class Meta:
		model = ContactData
		fields = ('contactname','key', 'value', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

class ContactLinkSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='name')
	class Meta:
		model = ContactLink
		fields = ('contactname','entityType', 'entity', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 