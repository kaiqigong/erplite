from django.db import models

# Create your models here.
class Events(models.Model):
	name = models.CharField(max_length=255)
	description = models.TextField(blank=True)
	location = models.CharField(max_length=255, blank=True)
	start = models.DateTimeField(blank=True, null=True)
	end = models.DateTimeField(blank=True, null=True)
	originator = models.ManyToManyField('auth.User',null=True, blank=True)
	attendee = models.ManyToManyField('auth.User',null=True, blank=True)
	recurrence = models.CharField(max_length=255, blank=True)
	comment = models.TextField(blank=True)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

class EventTags(models.Model):
	event = models.ForeignKey('Events', related_name='tags')
	tag = models.CharField(max_length=100)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % (self.tag)

class EventLink(models.Model):
	event = models.ForeignKey('Events', related_name='links')
	entityType = models.TextField()
	entityId = models.CharField(max_length=255)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s: %s' % (self.entityType, self.entityId)

class EventAttachment(models.Model):
	event = models.ForeignKey('Events', related_name='attachement')
	filename = models.CharField(max_length=255)
	filepath = models.CharField(max_length=255)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)