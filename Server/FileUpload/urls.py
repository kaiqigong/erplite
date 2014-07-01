from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from Accounts import views

urlpatterns = patterns('FileUpload.views',
	url(r'^upload/$', 'upload_file',name="upload_file"),
	url(r'^uploadToken/$', 'get_qiniu_uptoken',name="get_qiniu_uptoken"),
	url(r'^downloadToken/$','get_qiniu_dntoken',name='get_qiniu_dntoken'),
	url(r'^getSignedUrl/$','get_signed_7n_url',name='get_signed_7n_url')

)
