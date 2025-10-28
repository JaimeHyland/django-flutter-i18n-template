# user_settings/urls.py
from django.urls import path
from .views import user_settings_api

urlpatterns = [
    path('user-settings/', user_settings_api, name='user-settings'),
]
