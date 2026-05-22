import os
from pathlib import Path
import environ

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

env = environ.Env(
    DEBUG=(bool, False)
)

# Optional: hanya dipakai kalau ada file .env (dev)
env_file = BASE_DIR / '.env'
if env_file.exists():
    environ.Env.read_env(env_file)
    
    
def read_secret(name):
    path = f'/run/secrets/{name}'
    if os.path.exists(path):
        with open(path) as f:
            return f.read().strip()
    return None
    


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/6.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = read_secret('secret_key') or env('SECRET_KEY', default=None)

if not SECRET_KEY:
    raise Exception("SECRET_KEY not found in secrets or .env!")

DEBUG = env.bool('DEBUG', default=False)

ALLOWED_HOSTS = env.list('ALLOWED_HOSTS', default=['127.0.0.1', 'localhost'])
USE_HTTPS = env.bool('USE_HTTPS', default=False)


# Application definition

INSTALLED_APPS = [
    'admin_berry',
    'django_htmx',
    'django_tables2',
    "unfold",
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",

    'profiles.apps.ProfilesConfig',
    "menus",
    "dashboard",
    'umum',
    'core',
    'spd',
    'perintah',
    'spj',
]

# 🔥 LETAKKAN DI SINI
UNFOLD = {
    "SITE_TITLE": "Perjadin Apps",
    "SITE_HEADER": "Dashboard Perjadin",
    "SITE_SYMBOL": "dashboard",

    "NAVIGATION": [
        {
            "title": "Manajemen",
            "items": [
                {
                    "title": "OPD",
                    "icon": "apartment",
                    "link": "/admin/profiles/opd/",
                },
                {
                    "title": "Role",
                    "icon": "group",
                    "link": "/admin/profiles/role/",
                },
                {
                    "title": "Menu",
                    "icon": "menu",
                    "link": "/admin/menus/menu/",
                },
            ],
        },
    ],
}

MIDDLEWARE = [
    'django_htmx.middleware.HtmxMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'core.middleware.SessionSecurityMiddleware',
    'core.middleware.SecurityHeadersMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'config.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],  # 👈 INI PENTING
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'profiles.context_processors.menu_context',
            ],
        },
    },
]
WSGI_APPLICATION = 'config.wsgi.application'


# Database
# https://docs.djangoproject.com/en/6.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': read_secret('db_name') or env('DB_NAME'),
        'USER': read_secret('db_user') or env('DB_USER'),
        'PASSWORD': read_secret('db_password') or env('DB_PASSWORD'),
        'HOST': os.getenv('DB_HOST', 'localhost'),
        'PORT': os.getenv('DB_PORT', '5432'),
    }
}

if not read_secret('db_name') and not env('DB_NAME', default=None):
    raise Exception("Database config not found!")


# Password validation
# https://docs.djangoproject.com/en/6.0/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/6.0/topics/i18n/

LANGUAGE_CODE = 'id-id'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = False

USE_TZ = True

DATE_INPUT_FORMATS = [
    "%Y-%m-%d",
    "%d/%m/%Y",
]


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/6.0/howto/static-files/
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# TAMBAHKAN INI 👇
STATICFILES_DIRS = [
    BASE_DIR / 'static',
]
CSRF_TRUSTED_ORIGINS = env.list('CSRF_TRUSTED_ORIGINS', default=[])

IDLE_TIMEOUT_SECONDS = 1800
SESSION_COOKIE_AGE = IDLE_TIMEOUT_SECONDS
SESSION_SAVE_EVERY_REQUEST = True
SESSION_EXPIRE_AT_BROWSER_CLOSE = True
SESSION_COOKIE_HTTPONLY = True
SESSION_COOKIE_SAMESITE = 'Lax'
SESSION_COOKIE_SECURE = USE_HTTPS

CSRF_COOKIE_HTTPONLY = True
CSRF_COOKIE_SAMESITE = 'Lax'
CSRF_COOKIE_SECURE = USE_HTTPS

SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_REFERRER_POLICY = 'same-origin'
SECURE_CROSS_ORIGIN_OPENER_POLICY = 'same-origin'
SECURE_CROSS_ORIGIN_RESOURCE_POLICY = 'same-origin'
X_FRAME_OPTIONS = 'DENY'
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
SECURE_SSL_REDIRECT = env.bool('SECURE_SSL_REDIRECT', default=False)
SECURE_HSTS_SECONDS = env.int(
    'SECURE_HSTS_SECONDS',
    default=31536000 if USE_HTTPS else 0,
)
SECURE_HSTS_INCLUDE_SUBDOMAINS = USE_HTTPS
SECURE_HSTS_PRELOAD = USE_HTTPS

LOGIN_URL = '/profiles/masuk/'
LOGIN_REDIRECT_URL = '/dashboard/'
LOGOUT_REDIRECT_URL = LOGIN_URL
