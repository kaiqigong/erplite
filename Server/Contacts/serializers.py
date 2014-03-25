from rest_framework import serializers
from Contacts.models import Contacts, ContactTag, ContactData, ContactLink

class ContactsSerializer(serializers.ModelSerializer):
	tags = serializers.RelatedField(many=True)
	data = serializers.RelatedField(many=True)
	links = serializers.RelatedField(many=True)
	class Meta:
		model = Contacts
		fields = ('name', 'avator', 'tags', 'data', 'links', 'description', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class ContactTagSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='name')
	class Meta:
		model = ContactTag
		fields = ('contact','tag', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

class ContactDataSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='name')
	class Meta:
		model = ContactData
		fields = ('contact','key', 'value', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

class ContactLinkSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='name')
	class Meta:
		model = ContactLink
		fields = ('contact','entityType', 'entity', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 