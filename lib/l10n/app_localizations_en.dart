// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get header_welcome => 'Welcome!';

  @override
  String get label_ui_locale => 'Current UI locale';

  @override
  String get label_ui_language => 'UI Language';

  @override
  String get tooltip_settings => 'Settings';

  @override
  String get header_settings => 'Settings';

  @override
  String get dropdown_ui_locale => 'UI locale';

  @override
  String get text_choose_language => 'Select a language';

  @override
  String msgFailedToFetchLocales(Object error) {
    return 'Failed to fetch locales: $error';
  }

  @override
  String msgFailedToLoadLocale(Object error) {
    return 'Failed to load locale: $error';
  }

  @override
  String get msgFailedToUpdateLocale => 'Failed to update locale';

  @override
  String msgCurrentUiLocale(Object locale) {
    return 'Current UI locale: $locale';
  }

  @override
  String get msgLocaleUpdated => 'Locale successfully updated';

  @override
  String msgErrorUpdatingLocale(Object error) {
    return 'Error updating locale: $error';
  }

  @override
  String get snapshotUnknown => 'unknown';

  @override
  String msgErrorFetchUserLocale(Object body, Object status) {
    return 'Failed to fetch user locale: $status $body';
  }

  @override
  String msgErrorFallbackLocale(Object error) {
    return 'Failed to determine OS fallback locale: $error';
  }

  @override
  String msgErrorUpdateLocale(Object status) {
    return 'Failed to update locale: $status';
  }

  @override
  String get msgErrorFetchUserSettings => 'Failed to fetch user settings';

  @override
  String msgErrorInitLocale(Object error) {
    return 'Failed to initialize locale from OS: $error';
  }
}

/// The translations for English, as used in the United States (`en_US`).
class AppLocalizationsEnUs extends AppLocalizationsEn {
  AppLocalizationsEnUs(): super('en_US');

  @override
  String get tooltip_settings => 'User preferences';

  @override
  String get header_settings => 'Preferences';
}
