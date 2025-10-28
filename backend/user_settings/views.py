# user_settings/views.py
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import UserSettings, Locale
from .serializers import UserSettingsSerializer

@api_view(['GET', 'PUT', 'POST'])
@permission_classes([IsAuthenticated])
def user_settings_api(request):
    """
    GET: Return current user settings
    PUT: Update user's locale (manual selection)
    POST: Initialise locale from OS if not yet set
    """
    user_settings, _ = UserSettings.objects.get_or_create(user=request.user)

    if request.method == 'GET':
        serializer = UserSettingsSerializer(user_settings)
        return Response(serializer.data)

    elif request.method == 'PUT':
        locale_id = request.data.get('ui_locale_id')
        if not locale_id:
            return Response({'error': 'Missing ui_locale_id'}, status=400)

        try:
            locale = Locale.objects.get(id=locale_id)
            user_settings.ui_locale = locale
            user_settings.save()
            serializer = UserSettingsSerializer(user_settings)
            return Response(serializer.data)
        except Locale.DoesNotExist:
            return Response({'error': 'Invalid locale'}, status=400)

    elif request.method == 'POST':
            # If the user already has a locale, do nothing.
            if user_settings.ui_locale:
                serializer = UserSettingsSerializer(user_settings)
                return Response(serializer.data)

            os_locale = request.data.get('os_locale')
            if not os_locale:
                return Response({'error': 'Missing os_locale'}, status=400)

            # Parse the OS locale (e.g. "en_GB" or "de")
            parts = os_locale.split('_')
            language_code = parts[0]
            country_code = parts[1] if len(parts) > 1 else None

            # Try to find the matching Locale
            locale = (
                Locale.objects.filter(
                    language__iso_639_1=language_code,
                    country__iso_3166_1=country_code if country_code else None,
                ).first()
            )

            # Fallback to English if not found
            if not locale:
                locale = Locale.objects.filter(language__iso_639_1='en').first()

            # Save the locale
            user_settings.ui_locale = locale
            user_settings.save()

            serializer = UserSettingsSerializer(user_settings)
            return Response(serializer.data)