from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Locale, LanguageName, CountryName
from rest_framework import serializers

# --- Simple serializer ---
class LocaleSerializer(serializers.ModelSerializer):
    display_name = serializers.SerializerMethodField()

    class Meta:
        model = Locale
        fields = ['id', 'language', 'country', 'display_name']

    def get_display_name(self, obj):
        return f"{obj.language.name} ({obj.country.name})" if obj.country else obj.language.name


# --- List all supported locales ---
@api_view(['GET'])
def supported_locales(request):
    ui_language = request.GET.get('ui_language', 'en')
    locales = Locale.objects.all().select_related('language', 'country')
    data = []
    for locale in locales:
        lang_name_obj = LanguageName.objects.filter(
            language_named=locale.language,
            naming_language__iso_639_1=ui_language
        ).first()

        language_display = lang_name_obj.language_name if lang_name_obj else locale.language.iso_639_1

        if locale.country:
            country_name_obj = CountryName.objects.filter(
                country_named=locale.country,
                naming_language__iso_639_1=ui_language
            ).first()
            country_display = country_name_obj.country_name if country_name_obj else locale.country.iso_3166_1
            display_name = f"{language_display} ({country_display})"
        else:
            display_name = language_display

        data.append({
            'id': locale.id,
            'code': f"{locale.language.iso_639_1}{'_' + locale.country.iso_3166_1 if locale.country else ''}",
            'display_name': display_name,
        })

    return Response(data)


@api_view(['GET', 'POST'])
def user_ui_locale(request):
    if request.method == 'GET':
        return Response({'ui_locale': 'en'})
    elif request.method == 'POST':
        locale = request.data.get('ui_locale')
        return Response({'status': 'ok', 'ui_locale': locale})
