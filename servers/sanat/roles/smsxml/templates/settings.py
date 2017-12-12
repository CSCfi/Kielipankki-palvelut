"""
Django settings for saami project.

For more information on this file, see
https://docs.djangoproject.com/en/1.7/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.7/ref/settings/
"""

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.7/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '{{ webdomain_sanat | to_uuid }}'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = {{sms_xml.debug}}

TEMPLATE_DEBUG = {{sms_xml.debug}}

ALLOWED_HOSTS = [u'{{ webdomain_sanat }}']


# Application definition

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'tietokanta'
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'APP_DIRS': True,
    },
]

ROOT_URLCONF = 'saame.urls'

WSGI_APPLICATION = 'saame.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.7/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'saame.sqlite3'),
    }
}

PASSWORD_HASHERS = (
    'django.contrib.auth.hashers.BCryptSHA256PasswordHasher',
    'django.contrib.auth.hashers.BCryptPasswordHasher',
)

# Internationalization
# https://docs.djangoproject.com/en/1.7/topics/i18n/

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format' : "[%(asctime)s] %(levelname)s [%(name)s:%(lineno)s] %(message)s",
            'datefmt' : "%d/%b/%Y %H:%M:%S"
        }
    },
    'handlers': {
        'file': {
            'level': 'ERROR',
            'class': 'logging.FileHandler',
            'filename': os.path.join(BASE_DIR, 'error.log'),
            'formatter': 'standard'
        },
    },
    'loggers': {
        '': {
            'handlers': ['file'],
            'level': 'ERROR',
            'propagate': True,
        },
    },
}


LANGUAGE_CODE = 'fi-fi'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.7/howto/static-files/

STATIC_URL = '/static/'
URL_PREFIX = ""

WIKI_URL = "https://{{ webdomain_sanat }}/w/"
WIKI_JS_URL = "https://{{ webdomain_sanat }}/js/sms_edit.js"
WIKI_USERNAME = "{{sms_xml.wiki_username}}"
WIKI_PASSWORD = "{{sms_xml.wiki_password}}"
GIT_DIR_SMS = "/www/smsxml/xmls/sms/"
GIT_DIR_IZH = "/www/smsxml/xmls/izh/"
CURRENT_URL = "https://{{ webdomain_sanat }}/smsxml/"
