import django_filters
from Contacts.models import Contacts,ContactTag,ContactData,ContactLink

class ContactsFilter(django_filters.FilterSet):
	name = django_filters.CharFilter(name='name', lookup_type='icontains')
	description = django_filters.CharFilter(name='description', lookup_type='icontains')
	createdDate = django_filters.DateTimeFilter(name='createdDate')
	createdBy = django_filters.CharFilter(name='createdBy', lookup_type='icontains')
	modifiedDate = django_filters.DateTimeFilter(name='modifiedDate')
	modifiedBy = django_filters.CharFilter(name='modifiedBy', lookup_type='icontains')
	tags = django_filters.CharFilter(name='tags__tag', lookup_type='icontains')
	# surname givenname company department title phone mobile fax origin email address birthday region website qq weibo im 
	surname = django_filters.CharFilter(name='data__surname', lookup_type='icontains')
	givenname = django_filters.CharFilter(name='data__givenname', lookup_type='icontains')
	department = django_filters.CharFilter(name='data__department', lookup_type='icontains')
	title = django_filters.CharFilter(name='data__title', lookup_type='icontains')
	phone = django_filters.CharFilter(name='data__phone', lookup_type='icontains')
	mobile = django_filters.CharFilter(name='data__mobile', lookup_type='icontains')
	fax = django_filters.CharFilter(name='data__fax', lookup_type='icontains')
	origin = django_filters.CharFilter(name='data__origin', lookup_type='icontains')
	email = django_filters.CharFilter(name='data__email', lookup_type='icontains')
	address = django_filters.CharFilter(name='data__address', lookup_type='icontains')
	birthday = django_filters.CharFilter(name='data__birthday', lookup_type='icontains')
	region = django_filters.CharFilter(name='data__region', lookup_type='icontains')
	website = django_filters.CharFilter(name='data__website', lookup_type='icontains')
	qq = django_filters.CharFilter(name='data__qq', lookup_type='icontains')
	weibo = django_filters.CharFilter(name='data__weibo', lookup_type='icontains')
	im = django_filters.CharFilter(name='data__im', lookup_type='icontains')
	class Meta:
		model = Contacts
		fields = ('name','description','tags','createdDate','createdBy','modifiedDate','modifiedBy',)
