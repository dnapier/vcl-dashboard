"""
Django settings for the local machine. This file is imported by vcl.settings.base.
If it contains mustaches, then it is still a template file.
"""

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '{{ django_secret_key }}'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

CAS_SERVER_URL = '{{ cas_url }}'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '{{ db_name }}',
        'USER': '{{ db_user }}',
        'PASSWORD': '{{ db_password }}',
        'HOST': '',
        }
    }
