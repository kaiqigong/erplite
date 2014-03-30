import django_filters
from Contacts.models import Contacts,ContactTag,ContactData,ContactLink

class ContactsFilter(django_filters.FilterSet):
	name = django_filters.CharFilter(name='name', lookup_type='icontains')
	description = django_filters.CharFilter(name='description', lookup_type='icontains')
	createdDate = django_filters.DateTimeFilter(name='createdDate')
	createdBy = django_filters.CharFilter(name='createdBy', lookup_type='icontains')
	modifiedDate = django_filters.DateTimeFilter(name='modifiedDate')
	modifiedBy = django_filters.CharFilter(name='modifiedBy', lookup_type='icontains')
	class Meta:
		model = Contacts
		fields = ('name','description','createdDate','createdBy','modifiedDate','modifiedBy',)

class ContactTagFilter(django_filters.FilterSet):
	contact = django_filters.CharFilter(name='contact__name', lookup_type='icontains')
	tag = django_filters.CharFilter(name='tag', lookup_type='icontains')
	createdDate = django_filters.DateTimeFilter(name='createdDate')
	createdBy = django_filters.CharFilter(name='createdBy', lookup_type='icontains')
	modifiedDate = django_filters.DateTimeFilter(name='modifiedDate')
	modifiedBy = django_filters.CharFilter(name='modifiedBy', lookup_type='icontains')
	class Meta:
		model = ContactTag
		fields = ('contact','tag','createdDate','createdBy','modifiedDate','modifiedBy',)

class ContactDataFilter(django_filters.FilterSet):
	contact = django_filters.CharFilter(name='contact__name', lookup_type='icontains')
	keyPair = django_filters.CharFilter(name='keyPair', lookup_type='icontains')
	valuePair = django_filters.CharFilter(name='valuePair', lookup_type='icontains')
	createdDate = django_filters.DateTimeFilter(name='createdDate')
	createdBy = django_filters.CharFilter(name='createdBy', lookup_type='icontains')
	modifiedDate = django_filters.DateTimeFilter(name='modifiedDate')
	modifiedBy = django_filters.CharFilter(name='modifiedBy', lookup_type='icontains')
	class Meta:
		model = ContactData
		fields = ('contact','keyPair','valuePair','createdDate','createdBy','modifiedDate','modifiedBy',)

class ContactLinkFilter(django_filters.FilterSet):
	contact = django_filters.CharFilter(name='contact__name', lookup_type='icontains')
	entityType = django_filters.CharFilter(name='entityType')
	entity = django_filters.CharFilter(name='entity', lookup_type='icontains')
	createdDate = django_filters.DateTimeFilter(name='createdDate')
	createdBy = django_filters.CharFilter(name='createdBy', lookup_type='icontains')
	modifiedDate = django_filters.DateTimeFilter(name='modifiedDate')
	modifiedBy = django_filters.CharFilter(name='modifiedBy', lookup_type='icontains')
	class Meta:
		model = ContactLink
		fields = ('contact','entityType','entity','createdDate','createdBy','modifiedDate','modifiedBy',)