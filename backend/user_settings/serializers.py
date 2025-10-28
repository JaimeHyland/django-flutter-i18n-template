from rest_framework import serializers
from .models import UserSettings
from ui_locale.models import Locale


class LocaleSerializer(serializers.ModelSerializer):
    language = serializers.CharField(source='language.iso_639_1')
    country = serializers.CharField(source='country.iso_3166_1', allow_null=True)

    class Meta:
        model = Locale
        fields = ['id', 'language', 'country', 'ui_supported']

class UserSettingsSerializer(serializers.ModelSerializer):
    ui_locale = LocaleSerializer()

    class Meta:
        model = UserSettings
        fields = ['ui_locale']
