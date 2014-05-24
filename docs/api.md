1. For AccessControl:  
	"get access_token": http://localhost:8000/login/access_token/

2. For Accounts Model(web):  
	"index": "http://localhost:8000/accounts/"  
	"login": "http://localhost:8000/accounts/login"  
	"register": "http://localhost:8000/accounts/register"  
	“change password”: "http://localhost:8000/accounts/changepwd"  
	
3. For Contacts Model:  
	^contacts/$ [name='contacts-list']  
	^contacts?order=-name  
	^contacts?page=  
	^contacts/\.(?P<format>[a-z0-9]+)$ [name='contacts-list']  
	^contacts/(?P<pk>[^/]+)/$ [name='contacts-detail']  
	^contacts/(?P<pk>[^/]+)/\.(?P<format>[a-z0-9]+)$ [name='contacts-detail']    
	^contacts/(?P<contact_pk>[^/]+)/contactdata/1/  
	^contacts/(?P<contact_pk>[^/]+)/contacttag/$ [name='contacttag-list']  
	^contacts/(?P<contact_pk>[^/]+)/contacttag/(?P<pk>[^/]+)/$ [name='contacttag-detail']  
	^contacts/(?P<contact_pk>[^/]+)/contactlink/$ [name='contactlink-list']  
	^contacts/(?P<contact_pk>[^/]+)/contactlink/(?P<pk>[^/]+)/$ [name='contactlink-detail']  

	filter:  
	^contacttag?search=  
	^contactdata?search=  

4. For Tasks Model:  
	^tasks/$ [name='tasks-list']  
	^tasks/\.(?P<format>[a-z0-9]+)$ [name='tasks-list']  
	^tasks/(?P<pk>[^/]+)/$ [name='tasks-detail']  
	^tasks/(?P<pk>[^/]+)/\.(?P<format>[a-z0-9]+)$ [name='tasks-detail']  
	^tasktag/$ [name='tasktag-list']  
	^tasktag/\.(?P<format>[a-z0-9]+)$ [name='tasktag-list']  
	^tasktag/(?P<pk>[^/]+)/$ [name='tasktag-detail']  
	^tasktag/(?P<pk>[^/]+)/\.(?P<format>[a-z0-9]+)$ [name='tasktag-detail']  
	^tasklink/$ [name='tasklink-list']  
	^tasklink/\.(?P<format>[a-z0-9]+)$ [name='tasklink-list']  
	^tasklink/(?P<pk>[^/]+)/$ [name='tasklink-detail']  
	^tasklink/(?P<pk>[^/]+)/\.(?P<format>[a-z0-9]+)$ [name='tasklink-detail']  

5. For User and Group:  
	^users/$ [name='user-list']  
	^users/\.(?P<format>[a-z0-9]+)$ [name='user-list']  
	^users/(?P<pk>[^/]+)/$ [name='user-detail']  
	^users/(?P<pk>[^/]+)/\.(?P<format>[a-z0-9]+)$ [name='user-detail']  
	^groups/$ [name='group-list']  
	^groups/\.(?P<format>[a-z0-9]+)$ [name='group-list']  
	^groups/(?P<pk>[^/]+)/$ [name='group-detail']  
	^groups/(?P<pk>[^/]+)/\.(?P<format>[a-z0-9]+)$ [name='group-detail']  