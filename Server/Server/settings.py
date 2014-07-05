# Django settings for Server project.
import os
import datetime

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
	# ('Your Name', 'your_email@example.com'),
)

MANAGERS = ADMINS

DATABASES = {
	'default': {
		'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
		'NAME': 'erplite',                      # Or path to database file if using sqlite3.
		'USER': 'root',                      # Not used with sqlite3.
		'PASSWORD': 'password',                  # Not used with sqlite3.
		'HOST': '',                      # Set to empty string for localhost. Not used with sqlite3.
		'PORT': '',                      # Set to empty string for default. Not used with sqlite3.
	}
}

# Hosts/domain names that are valid for this site; required if DEBUG is False
# See https://docs.djangoproject.com/en/1.4/ref/settings/#allowed-hosts
ALLOWED_HOSTS = ['127.0.0.1']

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# In a Windows environment this must be set to your system time zone.
TIME_ZONE = 'Asia/Shanghai'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale.
USE_L10N = True

# If you set this to False, Django will not use timezone-aware datetimes.
USE_TZ = True

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/home/media/media.lawrence.com/media/"
MEDIA_ROOT = ''

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
MEDIA_URL = ''

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/home/media/media.lawrence.com/static/"
STATIC_ROOT = ''

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

# Additional locations of static files
STATICFILES_DIRS = (
	# Put strings here, like "/home/html/static" or "C:/www/django/static".
	# Always use forward slashes, even on Windows.
	# Don't forget to use absolute paths, not relative paths.
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
	'django.contrib.staticfiles.finders.FileSystemFinder',
	'django.contrib.staticfiles.finders.AppDirectoriesFinder',
#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = '^us45fm@w0v-8ubqz-4eq1&amp;*-+&amp;#e!&amp;lajf3&amp;f#f#l4x!)3711'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
	'django.template.loaders.filesystem.Loader',
	'django.template.loaders.app_directories.Loader',
#     'django.template.loaders.eggs.Loader',
)

MIDDLEWARE_CLASSES = (
	'django.middleware.common.CommonMiddleware',
	'django.contrib.sessions.middleware.SessionMiddleware',
	# 'django.middleware.csrf.CsrfViewMiddleware',
	'django.contrib.auth.middleware.AuthenticationMiddleware',
	'django.contrib.messages.middleware.MessageMiddleware',
	# Uncomment the next line for simple clickjacking protection:
	# 'django.middleware.clickjacking.XFrameOptionsMiddleware',
	'corsheaders.middleware.CorsMiddleware',
)

ROOT_URLCONF = 'Server.urls'

# Python dotted path to the WSGI application used by Django's runserver.
WSGI_APPLICATION = 'Server.wsgi.application'

TEMPLATE_DIRS = (
	# Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
	# Always use forward slashes, even on Windows.
	# Don't forget to use absolute paths, not relative paths.
	os.path.join(os.path.dirname(__file__), 'templates').replace('\\', '/')
)

INSTALLED_APPS = (
	'django.contrib.auth',
	'django.contrib.contenttypes',
	'django.contrib.sessions',
	'django.contrib.sites',
	'django.contrib.messages',
	'django.contrib.staticfiles',
	'south',
	# Uncomment the next line to enable the admin:
	'django.contrib.admin',
	# Uncomment the next line to enable admin documentation:
	# 'django.contrib.admindocs',
	'corsheaders',
	'rest_framework',
	# 'rest_framework.authtoken',
	'Accounts',
	'Contacts',
	'FileUpload',
	'rest_framework_extensions',
	'provider',
	'provider.oauth2',
	# 'oauth2_provider',
	'Tasks',
	'Account',
)

REST_FRAMEWORK = {
	'DEFAULT_AUTHENTICATION_CLASSES': (
		# 'rest_framework.authentication.TokenAuthentication',
		# 'rest_framework.authentication.SessionAuthentication',  # optional
		# 'rest_framework.authentication.OAuth2Authentication',
		# 'oauth2_provider.ext.rest_framework.OAuth2Authentication',
	),

	# Use hyperlinked styles by default.
	# Only used if the `serializer_class` attribute is not set on a view.
	'DEFAULT_MODEL_SERIALIZER_CLASS':
		'rest_framework.serializers.HyperlinkedModelSerializer',

	'DEFAULT_FILTER_BACKENDS':(
		'rest_framework.filters.DjangoFilterBackend',
	),

	'DEFAULT_PERMISSION_CLASSES': (
        # 'rest_framework.permissions.IsAuthenticated',
    ),
    'EXCEPTION_HANDLER': 'Server.utils.custom_exception_handler',
    'PAGINATE_BY': 10,                 # Default to 10
    'PAGINATE_BY_PARAM': 'page_size',  # Allow client to override, using `?page_size=xxx`.
    'MAX_PAGINATE_BY': 100             # Maximum limit allowed when using `?page_size=xxx`.
}

CORS_ORIGIN_ALLOW_ALL = True

CORS_ORIGIN_WHITELIST = ()

#---- Django OAuth Toolkit---------------------------------------------------------------------
# OAUTH2_PROVIDER = {
#     # this is the list of available scopes
#     'SCOPES': {'read': 'Read scope', 'write': 'Write scope'}
# }

#-----django-oauth2-provider-------------------------------------------------------------------
READ = 1 << 1
WRITE = 1 << 2
READ_WRITE = READ | WRITE

OAUTH_SCOPES = (
    (READ_WRITE, 'read+write'),
)

OAUTH_DELETE_EXPIRED = True
OAUTH_EXPIRE_DELTA = datetime.timedelta(seconds=60*60)
# OAUTH_ENFORCE_SECURE = True
# OAUTH_SINGLE_ACCESS_TOKEN = True
#----------------------------------------------------------------------------------------------

#-----qiniu settings------------------------------------------------------------------------
QINIU_ACCESS_KEY = 'PR0t5xIyMRIWCLgeLFbtOND57bnTIpp7CGRMWMCI'
QINIU_SECRET_KEY = 'DsWayvJtPhFyg-NzJNKFnOuEO5I67ZCZyG8NOyYJ'
QINIU_NAME = 'erplite'
QINIU_BASE_URL = 'erplite.qiniudn.com'
#----------------------------------------------------------------------------------------------

# A sample logging configuration. The only tangible logging
# performed by this configuration is to send an email to
# the site admins on every HTTP 500 error when DEBUG=False.
# See http://docs.djangoproject.com/en/dev/topics/logging for
# more details on how to customize your logging configuration.
LOGGING = {
	'version': 1,
	'disable_existing_loggers': False,
	'filters': {
		'require_debug_false': {
			'()': 'django.utils.log.RequireDebugFalse'
		}
	},
	'handlers': {
		'mail_admins': {
			'level': 'ERROR',
			'filters': ['require_debug_false'],
			'class': 'django.utils.log.AdminEmailHandler'
		}
	},
	'loggers': {
		'django.request': {
			'handlers': ['mail_admins'],
			'level': 'ERROR',
			'propagate': True,
		},
	}
}
