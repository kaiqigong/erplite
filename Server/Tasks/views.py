from django.shortcuts import render

from Tasks.models import Tasks
from django.contrib.auth.models import User
from django.contrib.auth.models import Group
from Tasks.serializers import TaskListSerializer, UserSerializer, GroupSerializer#, TaskDatailSerializer

from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication, OAuth2Authentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets
from rest_framework_extensions.mixins import DetailSerializerMixin

class TaskViewSet(viewsets.ModelViewSet):#DetailSerializerMixin
	authentication_classes = (OAuth2Authentication,)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)# TokenHasReadWriteScope)

	queryset = Tasks.objects.all()
	serializer_class = TaskListSerializer
	# serializer_detail_class = TaskDatailSerializer

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