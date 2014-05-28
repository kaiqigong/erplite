from django.contrib.auth.models import User
from django.contrib.auth.models import Group

class UserSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = User

class GroupSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Group
