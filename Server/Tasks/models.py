from django.db import models
# from django.contrib.auth.models import User

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
	owner = models.ManyToManyField('auth.User', related_name='task_owner', null=True, blank=True)
	assignedUser = models.ManyToManyField('auth.User',related_name='task_user', null=True, blank=True)
	assignedGroup = models.ManyToManyField('auth.Group', related_name='task_group', null=True, blank=True)
	createdDate = models.DateTimeField(auto_now_add=True)
	createdBy = models.CharField(max_length=100)
	modifiedDate = models.DateTimeField(auto_now=True)
	modifiedBy = models.CharField(max_length=100)

	def __unicode__(self):
		return '%s' % (self.name)

# class User(User):
# 	def __unicode__(self):
# 		return '%s' % (self.username)