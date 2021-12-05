import 'package:shared_preferences/shared_preferences.dart';

class PreferenceAssistant {
  PreferenceAssistant({SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences? _sharedPreferences;

  Future<bool> write<T>({required String key, required T value}) async {
    if (value is String) {
      return await _sharedPreferences?.setString(key, value) ?? false;
    } else if (value is bool) {
      return await _sharedPreferences?.setBool(key, value) ?? false;
    } else if (value is int) {
      return await _sharedPreferences?.setInt(key, value) ?? false;
    }
    return false;
  }

  T? read<T>({required String key}) {
    if (!(_sharedPreferences?.containsKey(key) ?? false)) {
      return null;
    }
    if (T == String) {
      // ignore: avoid_as
      return _sharedPreferences?.getString(key) as T;
    } else if (T == bool) {
      // ignore: avoid_as
      return _sharedPreferences?.getBool(key) as T;
    } else if (T == int) {
      // ignore: avoid_as
      return _sharedPreferences?.getInt(key) as T;
    }
    return null;
  }

  Future<bool> deleteAll() async => await _sharedPreferences?.clear() ?? false;
}
