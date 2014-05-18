from rest_framework import serializers
from Tasks.models import Tasks, TaskTag, TaskLink#, TaskAssignedUserDetail, TaskAssignedGroupDetail
from django.contrib.auth.models import User
from django.contrib.auth.models import Group


class TaskListSerializer(serializers.HyperlinkedModelSerializer):
	owner = serializers.SlugRelatedField(slug_field='username')
	assignedUser = serializers.SlugRelatedField(many=True, slug_field='username')
	assignedGroup = serializers.SlugRelatedField(many=True, slug_field='name')

	class Meta:
		model = Tasks
		fields = ('id','url','name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class TaskDatailSerializer(serializers.ModelSerializer):
	owner = serializers.SlugRelatedField(slug_field='username')
	assignedUser = serializers.SlugRelatedField(many=True, slug_field='username')
	assignedGroup = serializers.SlugRelatedField(many=True, slug_field='name')
	tags = serializers.HyperlinkedRelatedField(many=True,view_name='tasktag-detail')
	links = serializers.HyperlinkedRelatedField(many=True, view_name='tasklink-detail')

	class Meta:
		model = Tasks
		fields = ('id', 'name', 'description', 'due', 'status', 'priority', 'owner', 'assignedUser', 'assignedGroup', 'tags', 'links', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class TaskTagSerializer(serializers.ModelSerializer):
	taskname = serializers.Field(source='task.name')
	class Meta:
		model = TaskTag
		fields = ('task','taskname','tag', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class TaskLinkSerializer(serializers.ModelSerializer):
	taskname = serializers.Field(source='task.name')
	class Meta:
		model = TaskLink
		fields = ('task','taskname','entityType', 'entityId', 'createdDate', 'createdBy', 'modifiedDate', 'modifiedBy')

class UserSerializer(serializers.HyperlinkedModelSerializer):
	tasksBelongToMe = serializers.HyperlinkedRelatedField(many=True, view_name='tasks-detail')
	tasksAssignedToMe = serializers.HyperlinkedRelatedField(many=True, view_name='tasks-detail')

	class Meta:
		model = User
		fields = ('tasksBelongToMe', 'tasksAssignedToMe')

class GroupSerializer(serializers.HyperlinkedModelSerializer):
	tasksAssignedToGroup = serializers.HyperlinkedRelatedField(many=True, view_name='tasks-detail')

	class Meta:
		model = Group
		fields = ('name','tasksAssignedToGroup',)