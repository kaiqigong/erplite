from rest_framework import serializers
from Tasks.models import Tasks#, TaskAssignedUserDetail, TaskAssignedGroupDetail
from django.contrib.auth.models import User
from django.contrib.auth.models import Group

# class AssignedUserSerializer(serializers.ModelSerializer):
# 	assignedUser = serializers.Field(source='User.username')
# 	class Meta:
# 		model = TaskAssignedUserDetail
# 		fields = ('assignedUser',)

class TaskListSerializer(serializers.HyperlinkedModelSerializer):
	# assignedUser = AssignedUserSerializer(source='Tasks',many=True)
	owner = serializers.SlugRelatedField(slug_field='username')
	assignedUser = serializers.SlugRelatedField(many=True, slug_field='username')
	assignedGroup = serializers.SlugRelatedField(many=True, slug_field='name')
	class Meta:
		model = Tasks
		fields = ('id','url','name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

# class TaskDatailSerializer(serializers.ModelSerializer):
# 	class Meta:
# 		model = Tasks
# 		fields = ('name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')


class UserSerializer(serializers.HyperlinkedModelSerializer):
	tasksBelongToMe = serializers.HyperlinkedRelatedField(many=True, view_name='tasks-detail')
	tasksAssignedToMe = serializers.HyperlinkedRelatedField(many=True, view_name='tasks-detail')

	class Meta:
		model = User
		fields = ('tasksBelongToMe', 'tasksAssignedToMe')

class GroupSerializer(serializers.HyperlinkedModelSerializer):
	tasksAssignedToMyGroup = serializers.HyperlinkedRelatedField(many=True, view_name='tasks-detail')

	class Meta:
		model = Group
		fields = ('tasksAssignedToMyGroup',)