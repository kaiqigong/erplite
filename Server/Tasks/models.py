from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group

STATUS_OPEN = 'open'
STATUS_CLOSED = 'closed'

PRIORITY_HIGH = 'high'
PRIORITY_MEDIUM = 'medium'
PRIORITY_LOW = 'low'

STATUS = [(STATUS_OPEN,'open'),(STATUS_CLOSED,'closed')]
PRIORITY = [(PRIORITY_HIGH,'high'),(PRIORITY_MEDIUM,'medium'),(PRIORITY_LOW,'low')]

class Tasks(models.Model):
	name = models.CharField(max_length=255)
	description = models.TextField(blank=True)
	due = models.DateField(null=True, blank=True)
	status = models.CharField(choices=STATUS,
							default='open',
							max_length=100)
	priority = models.CharField(choices=PRIORITY,
								default='low',
								max_length=100)
	owner = models.ForeignKey('auth.User', related_name='tasksBelongToMe',null=True, blank=True)
	assignedUser = models.ManyToManyField('auth.User', related_name='tasksAssignedToMe', null=True, blank=True)#,through='TaskAssignedUserDetail',
	assignedGroup = models.ManyToManyField('auth.Group', related_name='tasksAssignedToGroup', null=True, blank=True)# through='TaskAssignedGroupDetail',
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % (self.name)

class TaskTag(models.Model):
	task = models.ForeignKey('Tasks', related_name='tags')
	tag = models.CharField(max_length=100)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % (self.tag)

class TaskLink(models.Model):
	task = models.ForeignKey('Tasks', related_name='links')
	entityType = models.TextField()
	entityId = models.CharField(max_length=255)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s: %s' % (self.entityType, self.entityId)

# class TaskAssignedUserDetail(models.Model):
# 	task = models.ForeignKey(Tasks)
# 	assignedUser = models.ForeignKey(User)
# 	createdDate = models.DateTimeField(auto_now_add=True)
# 	createdBy = models.CharField(max_length=100)
# 	modifiedDate = models.DateTimeField(auto_now=True)
# 	modifiedBy = models.CharField(max_length=100)

# class TaskAssignedGroupDetail(models.Model):
# 	task = models.ForeignKey(Tasks)
# 	assignedGroup = models.ForeignKey(Group)
# 	createdDate = models.DateTimeField(auto_now_add=True)
# 	createdBy = models.CharField(max_length=100)
# 	modifiedDate = models.DateTimeField(auto_now=True)
# 	modifiedBy = models.CharField(max_length=100)
