from django.urls import path
from . import views

urlpatterns = [
    path('locales/', views.supported_locales, name='supported_locales'),
    path('user-settings/', views.user_ui_locale, name='user_ui_locale'),
]
