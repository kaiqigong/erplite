from django.shortcuts import render
from django.contrib.auth.models import User
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.response import Response
from rest_framework.authentication import OAuth2Authentication
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import authenticate

from provider.oauth2 import models as oauth2


@api_view(['POST'])
def register(request):
	username=request.DATA.get('username', '')
	email=request.DATA.get('email', '')
	password=request.DATA.get('password', '')
	users = User.objects.filter(username__iexact=username)
	emails = User.objects.filter(email__iexact=email)
	if users:
		content = {'status_code':'409', 'detail': 'Username Existed'}
		return Response(content, status=status.HTTP_409_CONFLICT)
	if emails:
		content = {'status_code':'409', 'detail': 'Email Existed'}
		return Response(content, status=status.HTTP_409_CONFLICT)
	user=User.objects.create_user(username,email,password)
	if user:
		user.save()
		content = {'status_code':'201', 'detail': 'Registered Success!'}
		return Response(content, status=status.HTTP_201_CREATED)
	content = {'status_code':'400', 'detail': 'Registered Failed!'}
	return Response(content, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@authentication_classes((OAuth2Authentication,))
@permission_classes((IsAuthenticated,))
def changePwd(request):
	username = request.user.username
	oldpassword = request.DATA.get('oldpassword', '')
	print username
	user = authenticate(username=username, password=oldpassword)
	if user is not None and user.is_active:
		newpassword = request.POST.get('newpassword', '')
		user.set_password(newpassword)
		user.save()
		access_token = oauth2.AccessToken.objects.filter(user=user)
		access_token.delete()
		content = {'status_code':'201', 'detail': 'Change Password Success!'}
		return Response(content, status=status.HTTP_201_CREATED)
	content = {'status_code':'400', 'detail': 'Change Password Failed!'}
	return Response(content, status=status.HTTP_400_BAD_REQUEST)