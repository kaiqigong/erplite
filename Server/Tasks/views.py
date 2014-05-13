from django.shortcuts import render

from Tasks.models import Tasks
from Tasks.serializers import TaskListSerializer, TaskDatailSerializer

from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication, OAuth2Authentication
from rest_framework.permissions import IsAuthenticated

from rest_framework import viewsets
from rest_framework_extensions.mixins import DetailSerializerMixin

class TaskViewSet(DetailSerializerMixin, viewsets.ModelViewSet):
	authentication_classes = (OAuth2Authentication,SessionAuthentication)#(SessionAuthentication, TokenAuthentication, BasicAuthentication)
	permission_classes = (IsAuthenticated,)# TokenHasReadWriteScope)

	queryset = Tasks.objects.all()
	serializer_class = TaskListSerializer
	serializer_detail_class = TaskDatailSerializer