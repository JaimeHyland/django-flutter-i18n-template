// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get header_welcome => 'Willkommen!';

  @override
  String get label_ui_locale => 'Aktuelle Sprache';

  @override
  String get label_ui_language => 'UI Sprache';

  @override
  String get tooltip_settings => 'Einstellungen';

  @override
  String get header_settings => 'Einstellungen';

  @override
  String get dropdown_ui_locale => 'Sprache der App';

  @override
  String get text_choose_language => 'Sprache wählen';

  @override
  String msgFailedToFetchLocales(Object error) {
    return 'Fehler beim abrufen der Sprache: $error';
  }

  @override
  String msgFailedToLoadLocale(Object error) {
    return 'Fehler beim laden der Sprache : $error';
  }

  @override
  String get msgFailedToUpdateLocale => 'Fehler beim wechseln der Sprache';

  @override
  String msgCurrentUiLocale(Object locale) {
    return 'Sprache aktuell: $locale';
  }

  @override
  String get msgLocaleUpdated => 'Sprache erfolgreich gewechselt';

  @override
  String msgErrorUpdatingLocale(Object error) {
    return 'Fehler beim wechseln der Sprache: $error';
  }

  @override
  String get snapshotUnknown => 'unbekannt';

  @override
  String msgErrorFetchUserLocale(Object body, Object status) {
    return 'Benutzersprache konnte nicht abgerufen werden: $status $body';
  }

  @override
  String msgErrorFallbackLocale(Object error) {
    return 'Betriebssystem-Ausweichsprache konnte nicht ermittelt werden: $error';
  }

  @override
  String msgErrorUpdateLocale(Object status) {
    return 'Sprache konnte nicht aktualisiert werden: $status';
  }

  @override
  String get msgErrorFetchUserSettings => 'Benutzereinstellungen konnten nicht abgerufen werden';

  @override
  String msgErrorInitLocale(Object error) {
    return 'Sprache konnte nicht vom Betriebssystem initialisiert werden: $error';
  }
}
