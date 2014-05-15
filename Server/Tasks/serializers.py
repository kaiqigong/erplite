from rest_framework import serializers
from Tasks.models import Tasks#, TaskAssignedUserDetail, TaskAssignedGroupDetail
from django.contrib.auth.models import User

# class AssignedUserSerializer(serializers.ModelSerializer):
# 	assignedUser = serializers.Field(source='User.username')
# 	class Meta:
# 		model = TaskAssignedUserDetail
# 		fields = ('assignedUser',)

class TaskListSerializer(serializers.HyperlinkedModelSerializer):
	# assignedUser = AssignedUserSerializer(source='Tasks',many=True)
	# assignedUser = serializers.RelatedField(many=True)
	class Meta:
		model = Tasks
		# fields = ('name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

# class TaskDatailSerializer(serializers.ModelSerializer):
# 	class Meta:
# 		model = Tasks
# 		fields = ('name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')


class UserSerializer(serializers.HyperlinkedModelSerializer):

	class Meta:
		model = User