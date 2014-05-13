from rest_framework import serializers
from Tasks.models import Tasks
from django.contrib.auth.models import User

# class TrackListingField(serializers.RelatedField):
# 	def to_native(self, value):
# 		return '%s'%value.username

class TaskListSerializer(serializers.ModelSerializer):
	# owner = TrackListingField(many=True)
	# assignedUser = TrackListingField(many=True)
	# owner = serializers.Field(source='owner')
	class Meta:
		model = Tasks
		fields = ('name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class TaskDatailSerializer(serializers.ModelSerializer):
	class Meta:
		model = Tasks
		fields = ('name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')