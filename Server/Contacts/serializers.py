from rest_framework import serializers
from Contacts.models import Contacts, ContactTag, ContactData, ContactLink

class ContactsListSerializer(serializers.HyperlinkedModelSerializer):
	tags = serializers.RelatedField(many=True)
	class Meta:
		model = Contacts
		fields = ('id','url', 'name', 'avator', 'tags', 'description', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class ContactsDetailSerializer(serializers.HyperlinkedModelSerializer):
	tags = serializers.HyperlinkedRelatedField(many=True,view_name='contacttag-detail')
	data = serializers.HyperlinkedRelatedField(many=True, view_name='contactdata-detail')
	links = serializers.HyperlinkedRelatedField(many=True, view_name='contactlink-detail')
	class Meta:
		model = Contacts
		fields = ('id', 'name', 'avator', 'tags', 'data', 'links', 'description', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class ContactTagSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='contact.name')
	class Meta:
		model = ContactTag
		fields = ('contact','contactname','tag', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

class ContactDataSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='contact.name')
	class Meta:
		model = ContactData
		fields = ('contact','contactname','keyPair', 'valuePair', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

class ContactLinkSerializer(serializers.ModelSerializer):
	contactname = serializers.Field(source='contact.name')
	entityname = serializers.Field(source='entity.name')
	class Meta:
		model = ContactLink
		fields = ('contact','contactname','entityType', 'entity','entityname', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 