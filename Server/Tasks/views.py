from django.shortcuts import render

from Tasks.models import Tasks, TaskTag, TaskLink
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from Tasks.serializers import TaskListSerializer, UserSerializer, GroupSerializer, TaskDatailSerializer, TaskTagSerializer, TaskLinkSerializer

from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication, OAuth2Authentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets
from rest_framework_extensions.mixins import DetailSerializerMixin

class TaskViewSet(DetailSerializerMixin, viewsets.ModelViewSet):#
	authentication_classes = (OAuth2Authentication,)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)# TokenHasReadWriteScope)

	queryset = Tasks.objects.all()
	serializer_class = TaskListSerializer
	serializer_detail_class = TaskDatailSerializer

class TaskTagViewSet(viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)#, TokenHasReadWriteScope)

	queryset = TaskTag.objects.all()
	serializer_class = TaskTagSerializer

	def get_queryset(self):
		task_id = self.kwargs.get('task_pk', None)
		if task_id:
			return TaskTag.objects.filter(task=task_id)
		return super(TaskTagViewSet, self).get_queryset()

class TaskLinkViewSet(viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)#, TokenHasReadWriteScope)

	queryset = TaskLink.objects.all()
	serializer_class = TaskLinkSerializer

class UserViewSet(viewsets.ReadOnlyModelViewSet):
	authentication_classes = (OAuth2Authentication,)
	permission_classes = (IsAuthenticated,)

	model = User
	serializer_class = UserSerializer

	def get_queryset(self):
		return User.objects.filter(username=self.request.user.username)

class GroupViewSet(viewsets.ReadOnlyModelViewSet):
	authentication_classes = (OAuth2Authentication,)
	permission_classes = (IsAuthenticated,)

	model = Group
	serializer_class = GroupSerializer

	def get_queryset(self): 
		return self.request.user.groups.all()