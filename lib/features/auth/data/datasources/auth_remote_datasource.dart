import 'package:sawa_app/core/network/api_client.dart';
import 'package:sawa_app/core/storage/storage_service.dart';
import 'package:sawa_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiClient _api;
  final StorageService _storage;

  AuthRemoteDataSource(this._api, this._storage);

  // ✅ يوحّد استخراج البيانات سواء كان الرد {data:{...}} أو {...} مباشرة
  Map<String, dynamic> _unwrap(dynamic responseData) {
    if (responseData is Map<String, dynamic> && responseData['data'] is Map) {
      return responseData['data'];
    }
    return responseData as Map<String, dynamic>;
  }

  Future<UserModel> _handleAuthResponse(dynamic responseData) async {
    final data = _unwrap(responseData);
    final accessToken = data['accessToken'] ?? data['access_token'];
    final refreshToken = data['refreshToken'] ?? data['refresh_token'];
    final userJson = data['user'] ?? data;

    await _storage.saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    final user = UserModel.fromJson(userJson);
    await _storage.saveUserRaw(user.toJson());
    return user;
  }

  Future<UserModel> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String dateOfBirth,
  }) async {
    final response = await _api.post('/auth/signup', data: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
    });
    return _handleAuthResponse(response.data);
  }

  Future<UserModel> login({required String email, required String password}) async {
    final response = await _api.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return _handleAuthResponse(response.data);
  }

  Future<void> forgotPassword(String email) async {
    await _api.post('/auth/forgot-password', data: {'email': email});
  }

  Future<void> resetPassword({required String token, required String newPassword}) async {
    await _api.post('/auth/reset-password', data: {
      'token': token,
      'newPassword': newPassword,
    });
  }

  Future<void> logout() async {
    try {
      final refreshToken = _storage.getRefreshToken();
      await _api.post('/auth/logout', data: {'refreshToken': refreshToken});
    } catch (_) {
      // best-effort: حتى لو فشل نداء تسجيل الخروج بالسيرفر، منمسح الجلسة محليًا
    }
    await _storage.clearSession();
  }
}