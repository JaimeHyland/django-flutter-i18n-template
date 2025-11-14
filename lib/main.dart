import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'services/api_service.dart';
import 'services/device_config.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "assets/config/.env");

  final apiBaseUrl = await getApiBaseUrl();
  print('DEBUG: Using API base URL: $apiBaseUrl');


  ApiService.baseUrl = apiBaseUrl;

  final localeCode = await ApiService.getCurrentLocale();
  final parts = localeCode.split('_');
  final initialLocale = parts.length > 1
      ? Locale(parts[0], parts[1])
      : Locale(parts[0]);

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  const MyApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i18n template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
      locale: initialLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
