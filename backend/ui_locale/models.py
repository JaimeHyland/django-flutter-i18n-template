from django.db import models

class Language(models.Model):
    iso_639_1 = models.CharField(
        max_length=2,
        unique=True,
        help_text="ISO 639-1 code, e.g. 'en', 'de'"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['iso_639_1']
        verbose_name = "Language"
        verbose_name_plural = "Languages"

    def __str__(self):
        return self.iso_639_1


class Country(models.Model):
    iso_3166_1 = models.CharField(
        max_length=10,
        unique=True,
        help_text="ISO 3166-1 code, e.g. 'DE', 'IE'")

    class Meta:
        ordering = ['iso_3166_1']
        verbose_name = "Country"
        verbose_name_plural = "Countries"


    def __str__(self):
        return self.iso_3166_1

class LanguageName(models.Model):
    language_named = models.ForeignKey(
        Language,
        on_delete=models.CASCADE,
        related_name='names',
        help_text="The language being named (e.g. 'en')"
    )
    naming_language = models.ForeignKey(
        Language,
        on_delete=models.CASCADE,
        related_name='naming',
        help_text="The language used for naming (e.g. 'de')"
    )
    language_name = models.CharField(
        max_length=100,
        help_text="The name of the language as expressed in the naming language"
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['language_named', 'naming_language'], name='unique_language_name')
        ]
        ordering = ['language_named__iso_639_1']
        verbose_name = "Language Name"
        verbose_name_plural = "Language Names"

    def __str__(self):
        return f"{self.language_name} ({self.naming_language.iso_639_1} for {self.language_named.iso_639_1})"


class CountryName(models.Model):
    country_named = models.ForeignKey(
        Country,
        on_delete=models.CASCADE,
        related_name='names',
        help_text="The country being named (e.g. 'DE')"
    )
    naming_language = models.ForeignKey(
        Language,
        on_delete=models.CASCADE,
        related_name='country_naming',
        help_text="The language used for naming (e.g. 'es')"
    )
    country_name = models.CharField(
        max_length=100,
        help_text="The name of the country as expressed in the naming language (e.g. 'Alemania')"
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['country_named', 'naming_language'], name='unique_country_name')
        ]
        ordering = ['country_named__iso_3166_1']
        verbose_name = "Country Name"
        verbose_name_plural = "Country Names"

    def __str__(self):
        return f"{self.country_name} ({self.naming_language.iso_639_1} for {self.country_named.iso_3166_1})"


class Locale(models.Model):
    language = models.ForeignKey(Language, on_delete=models.CASCADE)
    country = models.ForeignKey(Country, on_delete=models.CASCADE, null=True, blank=True)
    ui_supported = models.BooleanField(default=False)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['language', 'country'], name='unique_locale')
        ]

    def __str__(self):
        if self.country:
            return f"{self.language.iso_639_1}_{self.country.iso_3166_1}"
        return self.language.iso_639_1


    def get_display_name(self, ui_language: str = 'en'):
        """Return language (+ country) name in the requested UI language."""
        # Language name
        lang_name_obj = self.language.names.filter(
            naming_language__iso_639_1=ui_language
        ).first()
        lang_display = lang_name_obj.language_name if lang_name_obj else self.language.iso_639_1

        # Country name if applicable
        if self.country:
            country_name_obj = self.country.names.filter(
                naming_language__iso_639_1=ui_language
            ).first()
            country_display = country_name_obj.country_name if country_name_obj else self.country.iso_3166_1
            return f"{lang_display} ({country_display})"

        return lang_display

    class Meta:
        verbose_name = "Locale"
        verbose_name_plural = "Locales"
        constraints = [
            models.UniqueConstraint(fields=['language', 'country'], name='unique_locale')
        ]