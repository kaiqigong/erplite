from django.shortcuts import render

from Tasks.models import Tasks
from django.contrib.auth.models import User
from Tasks.serializers import TaskListSerializer, UserSerializer#, TaskDatailSerializer

from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication, OAuth2Authentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets
from rest_framework_extensions.mixins import DetailSerializerMixin

class TaskViewSet(viewsets.ModelViewSet):#DetailSerializerMixin
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)# TokenHasReadWriteScope)

	queryset = Tasks.objects.all()
	serializer_class = TaskListSerializer
	# serializer_detail_class = TaskDatailSerializer

class UserViewSet(viewsets.ModelViewSet):
	authentication_classes = (SessionAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)

	model = User
	# queryset = User.objects.all()
	serializer_class = UserSerializer

	def get_queryset(self):
		return User.objects.filter(username=self.request.user.username)
