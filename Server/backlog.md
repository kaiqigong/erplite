update 2014/03/27

URL List:
^app/(?P<path>.*)
^mockData/(?P<path>.*)
^admin/
^ ^$
^ ^\.(?P<format>[a-z0-9]+)$
^ ^contacts/$ [name='contacts-list']
^ ^contacts/\.(?P<format>[a-z0-9]+)$ [name='contacts-list']
^ ^contacts/(?P<pk>[0-9]+)/$ [name='contacts-detail']
^ ^contacts/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contacts-detail']
^ ^contacttag/$ [name='contacttag-list']
^ ^contacttag/\.(?P<format>[a-z0-9]+)$ [name='contacttag-list']
^ ^contacttag/(?P<pk>[0-9]+)/$ [name='contacttag-detail']
^ ^contacttag/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contacttag-detail']
^ ^contactlink/$ [name='contactlink-list']
^ ^contactlink/\.(?P<format>[a-z0-9]+)$ [name='contactlink-list']
^ ^contactlink/(?P<pk>[0-9]+)/$ [name='contactlink-detail']
^ ^contactlink/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contactlink-detail']
^ ^contactdata/$ [name='contactdata-list']
^ ^contactdata/\.(?P<format>[a-z0-9]+)$ [name='contactdata-list']
^ ^contactdata/(?P<pk>[0-9]+)/$ [name='contactdata-detail']
^ ^contactdata/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contactdata-detail']