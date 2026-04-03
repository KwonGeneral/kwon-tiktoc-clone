import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  static const _key = 'device_uuid';

  final SharedPreferences _prefs;

  DeviceIdService(this._prefs);

  String getDeviceId() {
    final stored = _prefs.getString(_key);
    if (stored != null && stored.isNotEmpty) return stored;

    final id = const Uuid().v4();
    _prefs.setString(_key, id);
    return id;
  }
}
