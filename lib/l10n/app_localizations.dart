import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('en', 'US'),
    Locale('es')
  ];

  /// No description provided for @header_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get header_welcome;

  /// No description provided for @label_ui_locale.
  ///
  /// In en, this message translates to:
  /// **'Current UI locale'**
  String get label_ui_locale;

  /// No description provided for @label_ui_language.
  ///
  /// In en, this message translates to:
  /// **'UI Language'**
  String get label_ui_language;

  /// No description provided for @tooltip_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tooltip_settings;

  /// No description provided for @header_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get header_settings;

  /// No description provided for @dropdown_ui_locale.
  ///
  /// In en, this message translates to:
  /// **'UI locale'**
  String get dropdown_ui_locale;

  /// No description provided for @text_choose_language.
  ///
  /// In en, this message translates to:
  /// **'Select a language'**
  String get text_choose_language;

  /// No description provided for @msgFailedToFetchLocales.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch locales: {error}'**
  String msgFailedToFetchLocales(Object error);

  /// No description provided for @msgFailedToLoadLocale.
  ///
  /// In en, this message translates to:
  /// **'Failed to load locale: {error}'**
  String msgFailedToLoadLocale(Object error);

  /// No description provided for @msgFailedToUpdateLocale.
  ///
  /// In en, this message translates to:
  /// **'Failed to update locale'**
  String get msgFailedToUpdateLocale;

  /// No description provided for @msgCurrentUiLocale.
  ///
  /// In en, this message translates to:
  /// **'Current UI locale: {locale}'**
  String msgCurrentUiLocale(Object locale);

  /// No description provided for @msgLocaleUpdated.
  ///
  /// In en, this message translates to:
  /// **'Locale successfully updated'**
  String get msgLocaleUpdated;

  /// No description provided for @msgErrorUpdatingLocale.
  ///
  /// In en, this message translates to:
  /// **'Error updating locale: {error}'**
  String msgErrorUpdatingLocale(Object error);

  /// No description provided for @snapshotUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get snapshotUnknown;

  /// No description provided for @msgErrorFetchUserLocale.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch user locale: {status} {body}'**
  String msgErrorFetchUserLocale(Object body, Object status);

  /// No description provided for @msgErrorFallbackLocale.
  ///
  /// In en, this message translates to:
  /// **'Failed to determine OS fallback locale: {error}'**
  String msgErrorFallbackLocale(Object error);

  /// No description provided for @msgErrorUpdateLocale.
  ///
  /// In en, this message translates to:
  /// **'Failed to update locale: {status}'**
  String msgErrorUpdateLocale(Object status);

  /// No description provided for @msgErrorFetchUserSettings.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch user settings'**
  String get msgErrorFetchUserSettings;

  /// No description provided for @msgErrorInitLocale.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize locale from OS: {error}'**
  String msgErrorInitLocale(Object error);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'en': {
  switch (locale.countryCode) {
    case 'US': return AppLocalizationsEnUs();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
