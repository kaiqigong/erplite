from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Accounts import views

urlpatterns = patterns('FileUpload.views',
	url(r'^upload/$', 'upload_file',name="upload_file"),
	url(r'^uploadToken/$', 'get_qiniu_uptoken',name="get_qiniu_uptoken")
)
