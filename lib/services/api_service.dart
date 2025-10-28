import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '../l10n/app_localizations.dart';
import '../constants/bootstrap_messages.dart';
import 'package:flutter/material.dart';


class ApiService {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  static final String authToken = dotenv.env['API_AUTH_TOKEN'] ?? '';

  /// Get list of supported locales
  static Future<List<Map<String, dynamic>>> getSupportedLocales({String? uiLanguage}) async {
    final uri = Uri.parse('$baseUrl/locales/').replace(
      queryParameters: uiLanguage != null ? {'ui_language': uiLanguage} : null,
    );
    final response = await http.get(uri, headers: {
      'Authorization': 'Token $authToken',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('BootstrapMessages.msgFailedToFetchSupportedLocales: ${response.statusCode}');
    }
  }

  /// Get current user's UI locale, falling back to OS locale if DB has none
  static Future<String> getCurrentLocale() async {
    final url = Uri.parse('$baseUrl/user-settings/');
    final response = await http.get(url, headers: {
      'Authorization': 'Token $authToken',
      'Accept': 'application/json',
    });

    if (response.statusCode != 200) {
      throw Exception('BootstrapMessages.msgFailedToFetchUserLocale: ${response.statusCode} ${response.body}');
    }

    final data = json.decode(response.body);
    final uiLocaleData = data['ui_locale'];

    if (uiLocaleData != null && uiLocaleData['language'] != null) {
      return uiLocaleData['language'];
    }

    // DB has no locale → detect OS locale
    final osLocale = ui.PlatformDispatcher.instance.locale.toString();

    try {
      final supportedLocales = await getSupportedLocales();
      Map<String, dynamic>? matchedLocale = supportedLocales.firstWhere(
            (l) => l['code'] == osLocale,
        orElse: () => {},
      );

      if (matchedLocale.isEmpty) {
        final languageOnly = osLocale.split('_')[0];
        matchedLocale = supportedLocales.firstWhere(
              (l) => l['code'] == languageOnly,
          orElse: () => {},
        );
      }

      if (matchedLocale.isNotEmpty) {
        final localeId = matchedLocale['id'];
        await setUserLocaleBootstrap(localeId);
        return matchedLocale['code'];
      } else {
        return 'en';
      }
    } catch (e) {
      // Fallback to English if anything fails
      return 'en';
    }
  }

  // Monolingual bootstrap version — used during startup, no context
  static Future<bool> setUserLocaleBootstrap(int localeId) async {
    final url = Uri.parse('$baseUrl/user-settings/');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'ui_locale_id': localeId}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      // Use monolingual bootstrap message
      throw Exception(
        '${BootstrapMessages.msgFailedToSetUserLocale}: ${response.statusCode}',
      );
    }
  }

  /// Update current user's locale
  static Future<bool> updateUserLocale(int localeId, BuildContext context) async {
    final url = Uri.parse('$baseUrl/user-settings/');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'ui_locale_id': localeId}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final localizations = AppLocalizations.of(context)!;
      // Throw a plain exception — widget can decide how to localize
      throw Exception(localizations.msgErrorUpdateLocale(
        response.statusCode.toString(),
      ));
    }
  }


  /// Initialize user locale based on the OS locale if none is set
  static Future<void> initLocaleFromOS(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;

    try {
      final url = Uri.parse('$baseUrl/user-settings/');
      final response = await http.get(url, headers: {
        'Authorization': 'Token $authToken',
        'Accept': 'application/json',
      });

      if (response.statusCode != 200) {
        throw Exception(localizations.msgErrorFetchUserSettings);
      }

      final data = json.decode(response.body);
      final uiLocaleData = data['ui_locale'];

      if (uiLocaleData != null && uiLocaleData['language'] != null) {
        return; // locale already set
      }

      final osLocale = ui.PlatformDispatcher.instance.locale.toString();
      final supportedLocales = await getSupportedLocales();

      Map<String, dynamic>? matchedLocale = supportedLocales.firstWhere(
            (l) => l['code'] == osLocale,
        orElse: () => {},
      );

      if (matchedLocale.isEmpty) {
        final languageOnly = osLocale.split('_')[0];
        matchedLocale = supportedLocales.firstWhere(
              (l) => l['code'] == languageOnly,
          orElse: () => {},
        );
      }

      if (matchedLocale.isNotEmpty) {
        final localeId = matchedLocale['id'];
        await updateUserLocale(localeId, context);
      }
    } catch (e) {
      throw Exception(localizations.msgErrorInitLocale(e.toString()));
    }
  }
}
