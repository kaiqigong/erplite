from django.db import models

# Create your models here.
class Contacts(models.Model):
	name = models.CharField(max_length=255)
	avator = models.URLField(blank=True)
	description = models.TextField(blank=True)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % (self.name)

class ContactTag(models.Model):
	contact = models.ForeignKey('Contacts', related_name='tags')
	tag = models.CharField(max_length=100)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % (self.tag)

class ContactData(models.Model):
	contact = models.ForeignKey('Contacts', related_name='data')
	keyPair = models.TextField()
	valuePair = models.TextField()
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s: %s' % (self.keyPair, self.valuePair)

class ContactLink(models.Model):
	contact = models.ForeignKey('Contacts', related_name='links')
	entityType = models.TextField()
	entity = models.ForeignKey('Entity')
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s: %s' % (self.entityType, self.entity)


# class ContactComment(models.Model):
# 	contact = ForeignKey('Contacts')
# 	comment = TextField()
# 	author = ManyToManyField()
# 	createdDate = models.DateTimeField(auto_now_add=True)
# 	createdBy = models.CharField(max_length=100)
# 	modifiedDate = models.DateTimeField(auto_now=True)
# 	modifiedBy = models.CharField(max_length=100)



class Entity(models.Model):
	name = models.TextField()
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % self.name
