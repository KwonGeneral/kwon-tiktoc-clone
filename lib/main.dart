import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/di/providers.dart';
import 'core/services/device_id_service.dart';
import 'data/datasource/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final localStorageService = LocalStorageService(prefs);
  final deviceIdService = DeviceIdService(prefs);

  runApp(
    ProviderScope(
      overrides: [
        localStorageRepositoryProvider.overrideWithValue(localStorageService),
        deviceIdServiceProvider.overrideWithValue(deviceIdService),
      ],
      child: const App(),
    ),
  );
}
