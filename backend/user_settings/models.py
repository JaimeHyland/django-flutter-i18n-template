# ui_locale/models.py (or a separate app if you prefer)
from django.conf import settings
from django.db import models
from ui_locale.models import Locale
import locale as py_locale

class UserSettings(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='settings'
    )
    ui_locale = models.ForeignKey(
        Locale,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        help_text="Preferred UI locale"
    )

    def __str__(self):
        return f"{self.user.username} settings"

    def get_ui_locale(self):
        """
        Determine the UI locale to use:
        1. User-set locale
        2. OS locale (with countryless fallback)
        3. Default 'en' locale
        """
        # 1️⃣ Use user-set locale if valid
        if self.ui_locale and self.ui_locale.ui_supported:
            return self.ui_locale

        # 2️⃣ Check OS locale
        try:
            os_lang, os_country = py_locale.getdefaultlocale()[0].split('_')
        except Exception:
            os_lang, os_country = 'en', None

        # Try full locale
        full_locale = Locale.objects.filter(
            language__iso_639_1=os_lang,
            country__iso_3166_1=os_country,
            ui_supported=True
        ).first()
        if full_locale:
            return full_locale

        # Try language-only locale
        lang_only_locale = Locale.objects.filter(
            language__iso_639_1=os_lang,
            country__isnull=True,
            ui_supported=True
        ).first()
        if lang_only_locale:
            return lang_only_locale

        # 3️⃣ Fallback to English
        return Locale.objects.filter(
            language__iso_639_1='en',
            country__isnull=True,
            ui_supported=True
        ).first()

    class Meta:
        verbose_name = "User settings"
        verbose_name_plural = "User settings"
