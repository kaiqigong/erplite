from django.db import models

# Create your models here.
class Contacts(models.Model):
	name = models.CharField(max_length=255)
	avator = models.URLField(blank=True)
	description = models.TextField(blank=True)
	createdDate = models.DateField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

class ContactTag(models.Model):
	contact = models.ForeignKey('Contacts')
	tag = models.CharField(max_length=100)
	createdDate = models.DateField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

class ContactData(models.Model):
	contact = models.ForeignKey('Contacts')
	key = models.TextField()
	value = models.TextField()
	createdDate = models.DateField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

class ContactLink(models.Model):
	contact = models.ForeignKey('Contacts')
	entityType = models.TextField()
	entity = models.ForeignKey('Entity')
	createdDate = models.DateField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

# class ContactComment(models.Model):
# 	contact = ForeignKey('Contacts')
# 	comment = TextField()
# 	author = ManyToManyField()
# 	createdDate = models.DateField(auto_now_add=True)
# 	createdBy = models.CharField(max_length=100)
# 	modifiedDate = models.DateField(auto_now=True)
# 	modifiedBy = models.CharField(max_length=100)



class Entity(models.Model):
	name = models.TextField()
	createdDate = models.DateField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)
