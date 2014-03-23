# from rest_framework import serializers
# from Contacts.models import *

# class ContactsSerializer(serializers.ModelSerializer):
# 	class meta:
# 		model = Contacts
# 		field = ('name', 'avator', 'description', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

# class ContactTagSerializer(serializers.ModelSerializer):
# 	contactname = serializers.Field(contact.name)
# 	class meta:
# 		model = ContactTag
# 		field = ('contactname','tag', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

# class ContactDataSerializer(serializers.ModelSerializer):
# 	contactname = serializers.Field(contact.name)
# 	class meta:
# 		model = ContactData
# 		field = ('contactname','key', 'value', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 

# class ContactLinkSerializer(serializers.ModelSerializer):
# 	contactname = serializers.Field(contact.name)
# 	class meta:
# 		model = ContactLink
# 		field = ('contactname','entityType', 'entity', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy') 