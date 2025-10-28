// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get header_welcome => '¡Bienvenido!';

  @override
  String get label_ui_locale => 'Región (país) actual';

  @override
  String get label_ui_language => 'Idioma de la interfaz';

  @override
  String get tooltip_settings => 'Opciones';

  @override
  String get header_settings => 'Opciones';

  @override
  String get dropdown_ui_locale => 'Región (país) de la UI';

  @override
  String get text_choose_language => 'Elije un idioma';

  @override
  String msgFailedToFetchLocales(Object error) {
    return 'Error al obtener idiomas: $error';
  }

  @override
  String msgFailedToLoadLocale(Object error) {
    return 'Error al cargar idioma: $error';
  }

  @override
  String get msgFailedToUpdateLocale => 'Error al actualizar idioma (país)';

  @override
  String msgCurrentUiLocale(Object locale) {
    return 'Idioma (país) actual: $locale';
  }

  @override
  String get msgLocaleUpdated => 'Idioma (país) actualizada';

  @override
  String msgErrorUpdatingLocale(Object error) {
    return 'Error al actualizar idioma (país): $error';
  }

  @override
  String get snapshotUnknown => 'desconocido';

  @override
  String msgErrorFetchUserLocale(Object body, Object status) {
    return 'No se pudo obtener el idioma (país) de usuario: $status $body';
  }

  @override
  String msgErrorFallbackLocale(Object error) {
    return 'No se pudo detectar idioma (páis) alternativa del sistema: $error';
  }

  @override
  String msgErrorUpdateLocale(Object status) {
    return 'No se pudo actualizar el idioma (país): $status';
  }

  @override
  String get msgErrorFetchUserSettings => 'No se pudo obtener las opciones del usuario';

  @override
  String msgErrorInitLocale(Object error) {
    return 'No se pudo iniciar idioma (país) desde el sistema operario: $error';
  }
}
