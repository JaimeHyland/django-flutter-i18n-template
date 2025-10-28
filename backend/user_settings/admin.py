from django.contrib import admin
from .models import UserSettings


@admin.register(UserSettings)
class UserSettingsAdmin(admin.ModelAdmin):
    list_display = ('user', 'ui_locale')
    search_fields = ('user__username', 'ui_locale__language__iso_639_1', 'ui_locale__country__iso_3166_1')
