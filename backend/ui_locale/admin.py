from django.contrib import admin
from .models import Language, Country, LanguageName, CountryName, Locale


@admin.register(Language)
class LanguageAdmin(admin.ModelAdmin):
    list_display = ('iso_639_1', 'created_at', 'updated_at')
    search_fields = ('iso_639_1',)


@admin.register(Country)
class CountryAdmin(admin.ModelAdmin):
    list_display = ('iso_3166_1',)
    search_fields = ('iso_3166_1',)


@admin.register(LanguageName)
class LanguageNameAdmin(admin.ModelAdmin):
    list_display = ('language_named', 'naming_language', 'language_name')
    list_filter = ('naming_language',)
    search_fields = ('language_name',)


@admin.register(CountryName)
class CountryNameAdmin(admin.ModelAdmin):
    list_display = ('country_named', 'naming_language', 'country_name')
    list_filter = ('naming_language',)
    search_fields = ('country_name',)


@admin.register(Locale)
class LocaleAdmin(admin.ModelAdmin):
    list_display = ('language', 'country', 'ui_supported', 'get_display')
    list_filter = ('ui_supported',)
    search_fields = ('language__iso_639_1', 'country__iso_3166_1')

    def get_display(self, obj):
        return obj.get_display_name("en")
    get_display.short_description = "Display Name"

