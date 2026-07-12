import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyUser = 'auth_user';
  static const _keyLanguage = 'app_language';
  static const _keySeenOnboarding = 'seen_onboarding';

  // ==== التوكنات ====
  Future<void> saveTokens({required String accessToken, String? refreshToken}) async {
    await _box.write(_keyAccessToken, accessToken);
    if (refreshToken != null) await _box.write(_keyRefreshToken, refreshToken);
  }

  String? getAccessToken() => _box.read(_keyAccessToken);
  String? getRefreshToken() => _box.read(_keyRefreshToken);
  bool get isLoggedIn => getAccessToken() != null && getAccessToken()!.isNotEmpty;

  // ==== بيانات المستخدم (JSON خام) ====
  Future<void> saveUserRaw(Map<String, dynamic> userJson) =>
      _box.write(_keyUser, jsonEncode(userJson));

  Map<String, dynamic>? getUserRaw() {
    final raw = _box.read(_keyUser);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  // ==== أول مرة يفتح فيها التطبيق (Onboarding) ====
  bool get hasSeenOnboarding => _box.read(_keySeenOnboarding) ?? false;
  Future<void> setSeenOnboarding() => _box.write(_keySeenOnboarding, true);

  // ==== اللغة ====
  Future<void> saveLanguage(String lang) => _box.write(_keyLanguage, lang);
  String getLanguage() => _box.read(_keyLanguage) ?? 'ar';

  // ==== تسجيل الخروج ====
  Future<void> clearSession() async {
    await _box.remove(_keyAccessToken);
    await _box.remove(_keyRefreshToken);
    await _box.remove(_keyUser);
  }
}