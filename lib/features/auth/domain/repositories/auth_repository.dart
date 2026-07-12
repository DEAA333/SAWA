import 'package:sawa_app/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String dateOfBirth,
  });

  Future<UserModel> login({required String email, required String password});

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({required String token, required String newPassword});

  Future<void> logout();
}