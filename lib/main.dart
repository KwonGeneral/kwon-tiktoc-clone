import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/di/providers.dart';
import 'core/services/device_id_service.dart';
import 'core/utils/random_nickname_generator.dart';
import 'data/datasource/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final localStorageService = LocalStorageService(prefs);
  final deviceIdService = DeviceIdService(prefs);

  // 최초 실행 시 랜덤 닉네임/username 자동 생성
  if (localStorageService.getProfileNickname().isEmpty) {
    await localStorageService.saveProfileNickname(
      RandomNicknameGenerator.generateNickname(),
    );
  }
  if (localStorageService.getProfileUsername().isEmpty) {
    await localStorageService.saveProfileUsername(
      RandomNicknameGenerator.generateUsername(),
    );
  }

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
