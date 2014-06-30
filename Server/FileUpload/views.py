from django import forms

class UploadFileForm(forms.Form):
	file  = forms.FileField()

from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse, HttpResponseNotAllowed, HttpResponseServerError

# Imaginary function to handle an uploaded file.

@csrf_exempt
def upload_file(request):
	if request.method != 'POST':
		return HttpResponseNotAllowed('Only POST here')

	form = UploadFileForm(request.POST, request.FILES)
	if not form.is_valid():
		return HttpResponseServerError("Invalid call")

	newPath=handle_uploaded_file(request.FILES['file'])
	return HttpResponse(newPath)

import os

def handle_uploaded_file(f):
	randomFolderName = id_generator()
	path = 'media/files/'+randomFolderName+'/'+f.name
	directory = os.path.dirname(path)
	if not os.path.exists(directory):
		os.makedirs(directory)
	with open(path, 'wb+') as destination:
		for chunk in f.chunks():
			destination.write(chunk)
	return path

import string
import random
def id_generator(size=8,chars=string.ascii_uppercase + string.digits):
	return ''.join(random.choice(chars) for _ in range(size))

# qiniu uploadToken
import qiniu.conf

qiniu.conf.ACCESS_KEY = "PR0t5xIyMRIWCLgeLFbtOND57bnTIpp7CGRMWMCI"
qiniu.conf.SECRET_KEY = "DsWayvJtPhFyg-NzJNKFnOuEO5I67ZCZyG8NOyYJ"

import qiniu.rs
def get_qiniu_uptoken(request):
	policy = qiniu.rs.PutPolicy('erplite')
	uptoken = policy.token()
	return HttpResponse(uptoken, content_type="application/json")

