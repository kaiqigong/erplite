update 2014/03/27

URL List:<br>
^app/(?P<path>.*)<br>
^mockData/(?P<path>.*)<br>
^admin/<br>
^ ^$<br>
^ ^\.(?P<format>[a-z0-9]+)$<br>
^ ^contacts/$ [name='contacts-list']<br>
^ ^contacts/\.(?P<format>[a-z0-9]+)$ [name='contacts-list']<br>
^ ^contacts/(?P<pk>[0-9]+)/$ [name='contacts-detail']<br>
^ ^contacts/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contacts-detail']<br>
^ ^contacttag/$ [name='contacttag-list']<br>
^ ^contacttag/\.(?P<format>[a-z0-9]+)$ [name='contacttag-list']<br>
^ ^contacttag/(?P<pk>[0-9]+)/$ [name='contacttag-detail']<br>
^ ^contacttag/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contacttag-detail']<br>
^ ^contactlink/$ [name='contactlink-list']<br>
^ ^contactlink/\.(?P<format>[a-z0-9]+)$ [name='contactlink-list']<br>
^ ^contactlink/(?P<pk>[0-9]+)/$ [name='contactlink-detail']<br>
^ ^contactlink/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contactlink-detail']<br>
^ ^contactdata/$ [name='contactdata-list']<br>
^ ^contactdata/\.(?P<format>[a-z0-9]+)$ [name='contactdata-list']<br>
^ ^contactdata/(?P<pk>[0-9]+)/$ [name='contactdata-detail']<br>
^ ^contactdata/(?P<pk>[0-9]+)/\.(?P<format>[a-z0-9]+)$ [name='contactdata-detail']<br>