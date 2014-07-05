import string
import random
import json

import qiniu.conf
import qiniu.rs

from django.conf import settings
from django.http import HttpResponse, HttpResponseNotAllowed, HttpResponseServerError

from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.authentication import OAuth2Authentication
from rest_framework.permissions import IsAuthenticated


qiniu.conf.ACCESS_KEY = settings.QINIU_ACCESS_KEY
qiniu.conf.SECRET_KEY = settings.QINIU_SECRET_KEY

def id_generator(size=8,chars=string.ascii_uppercase + string.digits):
	return ''.join(random.choice(chars) for _ in range(size))

@api_view(['GET'])
@authentication_classes((OAuth2Authentication,))
@permission_classes((IsAuthenticated,))
def get_qiniu_uptoken(request):
	policy = qiniu.rs.PutPolicy(settings.QINIU_NAME)
	uptoken = policy.token()
	randomFolderName = id_generator()
	return HttpResponse(json.dumps({"uptoken":uptoken,"randomFolderName":randomFolderName}), content_type="application/json")

@api_view(['GET'])
@authentication_classes((OAuth2Authentication,))
@permission_classes((IsAuthenticated,))
def get_qiniu_dntoken(request):
	key = request.REQUEST['key']
	base_url = qiniu.rs.make_base_url(settings.QINIU_BASE_URL, key)
	policy = qiniu.rs.GetPolicy()
	private_url = policy.make_request(base_url)
	result= {
		"base_url":base_url,
		"private_url":private_url
	}
	return HttpResponse(json.dumps(result), content_type="application/json")

@api_view(['GET'])
@authentication_classes((OAuth2Authentication,))
@permission_classes((IsAuthenticated,))
def get_signed_7n_url(request):
	return HttpResponse(sign_url(request.REQUEST['base_url']), content_type="application/json") 

def sign_url(url):
	policy = qiniu.rs.GetPolicy()
	return policy.make_request(url)



