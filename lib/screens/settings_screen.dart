import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, dynamic>> _locales = [];
  int? _selectedLocaleId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLocales();
    });
  }

  Future<void> _fetchLocales([AppLocalizations? localizations]) async {
    localizations ??= AppLocalizations.of(context)!;

    try {
      final currentLocaleCode = await ApiService.getCurrentLocale();
      final locales = await ApiService.getSupportedLocales(
        uiLanguage: currentLocaleCode.split('_')[0],
      );

      // Match current locale code to locale ID
      final currentLocale = locales.firstWhere(
            (l) => l['code'] == currentLocaleCode,
        orElse: () => locales.isNotEmpty ? locales[0] : {},
      );
      final currentId = currentLocale.isNotEmpty ? currentLocale['id'] : null;

      if (!mounted) return; // <--- ensure widget is still in tree
      setState(() {
        _locales = locales;
        _selectedLocaleId = currentId;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return; // <--- same safety check before using context
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.msgFailedToFetchLocales(e.toString()))),
      );
    }
  }


  Future<void> _updateLocale(int localeId) async {
    final localizations = AppLocalizations.of(context)!;
    try {
      final success = await ApiService.updateUserLocale(localeId, context);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? localizations.msgLocaleUpdated
                : localizations.msgFailedToUpdateLocale,
          ),
        ),
      );

      if (success) {
        setState(() => _selectedLocaleId = localeId);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.msgErrorUpdatingLocale(e.toString()),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations.tooltip_settings)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(localizations.tooltip_settings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.label_ui_language, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButton<int>(
              value: _selectedLocaleId,
              items: _locales.map((locale) {
                return DropdownMenuItem<int>(
                  value: locale['id'],
                  child: Text(locale['display_name']),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _updateLocale(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
