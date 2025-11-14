// lib/services/device_config.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> getApiBaseUrl() async {
  final deviceInfo = DeviceInfoPlugin();

  bool isEmulator = false;

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    isEmulator = !androidInfo.isPhysicalDevice;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    isEmulator = !iosInfo.isPhysicalDevice;
  }

  return isEmulator
      ? dotenv.env['API_BASE_URL_EMULATOR'] ?? ''
      : dotenv.env['API_BASE_URL_DEVICE'] ?? '';
}
