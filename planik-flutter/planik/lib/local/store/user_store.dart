import 'package:planik/local/preference_assistant.dart';

class UserStore {
  UserStore({
    required PreferenceAssistant secureStorage,
  }) : _secureStorage = secureStorage;

  static const String _keyUid = 'uid';
  static const String _keyId = 'id';
  static const String _keyHasPlan = 'has_plan';

  final PreferenceAssistant _secureStorage;

  String? getUid() {
    return _secureStorage.read(key: _keyUid);
  }

  Future<void> putUid({required String uid}) async {
    await _secureStorage.write(key: _keyUid, value: uid);
  }

  int? getId() {
    return _secureStorage.read(key: _keyId);
  }

  Future<void> putId({required int id}) async {
    await _secureStorage.write(key: _keyId, value: id);
  }

  bool getHasPlan() {
    return _secureStorage.read(key: _keyHasPlan) == true;
  }

  Future<void> putHasPlan({required bool hasPlan}) async {
    await _secureStorage.write(key: _keyHasPlan, value: hasPlan);
  }
}
