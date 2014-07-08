from django.db import models
from audit_log.models.managers import AuditLog

# Create your models here.
class Contacts(models.Model):
	name = models.CharField(max_length=255)
	avatar = models.CharField(max_length=255, blank=True)
	thumbnail = models.CharField(max_length=255, blank=True)
	description = models.TextField(blank=True)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	audit_log = AuditLog()

	class Meta:
		ordering = ['name']

	def __unicode__(self):
		return '%s' % (self.name)

class ContactTag(models.Model):
	contact = models.ForeignKey('Contacts', related_name='tags')
	tag = models.CharField(max_length=100)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	audit_log = AuditLog()

	def __unicode__(self):
		return '%s' % (self.tag)

class ContactData(models.Model):
	# surname givenname company department title phone mobile fax origin email address birthday region website qq weibo im
	contact = models.ForeignKey('Contacts', related_name='data', unique=True)
	surname = models.CharField(max_length=255, blank=True)
	givenname = models.CharField(max_length=255, blank=True)
	company = models.CharField(max_length=100, blank=True)
	department = models.CharField(max_length=100, blank=True)
	title = models.CharField(max_length=100, blank=True)
	phone = models.CharField(max_length=100, blank=True)
	mobile = models.CharField(max_length=100, blank=True)
	fax = models.CharField(max_length=100, blank=True)
	origin = models.CharField(max_length=100, blank=True)
	email = models.EmailField(blank=True)
	address = models.CharField(max_length=100, blank=True)
	birthday = models.DateField(null=True, blank=True)
	region = models.CharField(max_length=100, blank=True)
	website = models.URLField(blank=True)
	qq = models.CharField(max_length=100, blank=True)
	weibo = models.CharField(max_length=100, blank=True)
	im =models.CharField(max_length=100, blank=True)

	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	audit_log = AuditLog()

class ContactLink(models.Model):
	contact = models.ForeignKey('Contacts', related_name='links')
	entityType = models.TextField()
	entityId = models.CharField(max_length=255)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	audit_log = AuditLog()

	def __unicode__(self):
		return '%s: %s' % (self.entityType, self.entityId)


# class ContactComment(models.Model):
# 	contact = ForeignKey('Contacts')
# 	comment = TextField()
# 	author = ManyToManyField()
# 	createdDate = models.DateTimeField(auto_now_add=True)
# 	createdBy = models.CharField(max_length=100)
# 	modifiedDate = models.DateTimeField(auto_now=True)
# 	modifiedBy = models.CharField(max_length=100)



# class Entity(models.Model):
# 	name = models.TextField()
# 	createdDate = models.DateTimeField(auto_now_add=True)
# 	createdBy = models.CharField(max_length=100)
# 	modifiedDate = models.DateTimeField(auto_now=True)
# 	modifiedBy = models.CharField(max_length=100)

# 	def __unicode__(self):
# 		return '%s' % self.name
