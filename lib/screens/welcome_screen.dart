import 'package:flutter/material.dart';
import 'settings_screen.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Future<String> _fetchCurrentLocale(BuildContext context) async {
    // Pass context so ApiService can use localized error messages
    return await ApiService.getCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.header_welcome),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: localizations.tooltip_settings,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _fetchCurrentLocale(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              // Use localized error message
              return Text(
                localizations.msgFailedToLoadLocale(
                    snapshot.error.toString()),
                style: const TextStyle(color: Colors.red),
              );
            }

            final locale = snapshot.data ?? localizations.snapshotUnknown;

            return Text(
              localizations.msgCurrentUiLocale(locale),
              style: const TextStyle(fontSize: 20),
            );
          },
        ),
      ),
    );
  }
}
