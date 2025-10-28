# ui_locale/management/commands/populate_initial_data.py
from django.core.management.base import BaseCommand
from ui_locale.models import Language, Country, LanguageName, CountryName, Locale

class Command(BaseCommand):
    help = 'Populate initial languages, countries, locales, and names'

    def handle(self, *args, **options):
        # --- Languages ---
        en = Language.objects.get_or_create(iso_639_1='en')[0]
        de = Language.objects.get_or_create(iso_639_1='de')[0]
        es = Language.objects.get_or_create(iso_639_1='es')[0]

        # --- Countries ---
        us = Country.objects.get_or_create(iso_3166_1='US')[0]
        gb = Country.objects.get_or_create(iso_3166_1='GB')[0]
        de_country = Country.objects.get_or_create(iso_3166_1='DE')[0]
        es_country = Country.objects.get_or_create(iso_3166_1='ES')[0]

        # --- Language Names ---
        LanguageName.objects.get_or_create(language_named=en, naming_language=en, language_name='English')
        LanguageName.objects.get_or_create(language_named=en, naming_language=de, language_name='Englisch')
        LanguageName.objects.get_or_create(language_named=en, naming_language=es, language_name='Inglés')

        LanguageName.objects.get_or_create(language_named=de, naming_language=en, language_name='German')
        LanguageName.objects.get_or_create(language_named=de, naming_language=de, language_name='Deutsch')
        LanguageName.objects.get_or_create(language_named=de, naming_language=es, language_name='Alemán')

        LanguageName.objects.get_or_create(language_named=es, naming_language=en, language_name='Spanish')
        LanguageName.objects.get_or_create(language_named=es, naming_language=de, language_name='Spanisch')
        LanguageName.objects.get_or_create(language_named=es, naming_language=es, language_name='Español')

        # --- Country Names ---
        CountryName.objects.get_or_create(country_named=us, naming_language=en, country_name='USA')
        CountryName.objects.get_or_create(country_named=us, naming_language=de, country_name='USA')
        CountryName.objects.get_or_create(country_named=us, naming_language=es, country_name='EE. UU.')

        CountryName.objects.get_or_create(country_named=gb, naming_language=en, country_name='UK')
        CountryName.objects.get_or_create(country_named=gb, naming_language=de, country_name='Großbritannien')
        CountryName.objects.get_or_create(country_named=gb, naming_language=es, country_name='Gran Bretaña')

        CountryName.objects.get_or_create(country_named=de_country, naming_language=en, country_name='Germany')
        CountryName.objects.get_or_create(country_named=de_country, naming_language=de, country_name='Deutschland')
        CountryName.objects.get_or_create(country_named=de_country, naming_language=es, country_name='Alemania')

        CountryName.objects.get_or_create(country_named=es_country, naming_language=en, country_name='Spain')
        CountryName.objects.get_or_create(country_named=es_country, naming_language=de, country_name='Spanien')
        CountryName.objects.get_or_create(country_named=es_country, naming_language=es, country_name='España')

        # --- Locales ---
        Locale.objects.get_or_create(language=en, country=None, ui_supported=True)
        Locale.objects.get_or_create(language=en, country=us, ui_supported=True)
        Locale.objects.get_or_create(language=en, country=gb, ui_supported=True)

        Locale.objects.get_or_create(language=de, country=None, ui_supported=True)
        Locale.objects.get_or_create(language=de, country=de_country, ui_supported=True)

        Locale.objects.get_or_create(language=es, country=None, ui_supported=True)
        Locale.objects.get_or_create(language=es, country=es_country, ui_supported=True)

        self.stdout.write(self.style.SUCCESS('Successfully populated initial languages, countries, and locales'))
