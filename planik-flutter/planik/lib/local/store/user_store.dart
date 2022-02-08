import 'package:planik/local/preference_assistant.dart';

class UserStore {
  const UserStore({
    required PreferenceAssistant preferenceAssistant,
  }) : _preferenceAssistant = preferenceAssistant;

  static const String _keyUid = 'uid';
  static const String _keyId = 'id';
  static const String _keyCurrentPlanId = 'current_plan_id';
  static const String _keyHasPlan = 'has_plan';

  final PreferenceAssistant _preferenceAssistant;

  String? getUid() {
    return _preferenceAssistant.read(key: _keyUid);
  }

  Future<void> putUid({required String uid}) async {
    await _preferenceAssistant.write(key: _keyUid, value: uid);
  }

  int? getId() {
    return _preferenceAssistant.read<int>(key: _keyId);
  }

  Future<void> putId({required int id}) async {
    await _preferenceAssistant.write(key: _keyId, value: id);
  }

  bool getHasPlan() {
    return _preferenceAssistant.read<bool>(key: _keyHasPlan) == true;
  }

  Future<void> putHasPlan({required bool hasPlan}) async {
    await _preferenceAssistant.write(key: _keyHasPlan, value: hasPlan);
  }

  int? getCurrentPlanId() {
    return _preferenceAssistant.read<int>(key: _keyCurrentPlanId);
  }

  Future<void> putCurrentPlanId({required int id}) async {
    await _preferenceAssistant.write(key: _keyCurrentPlanId, value: id);
  }
}
