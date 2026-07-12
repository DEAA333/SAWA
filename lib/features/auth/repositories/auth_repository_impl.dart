import 'package:sawa_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:sawa_app/features/auth/data/models/user_model.dart';
import 'package:sawa_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  AuthRepositoryImpl(this._remote);

  @override
  Future<UserModel> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String dateOfBirth,
  }) {
    return _remote.signup(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      dateOfBirth: dateOfBirth,
    );
  }

  @override
  Future<UserModel> login({required String email, required String password}) {
    return _remote.login(email: email, password: password);
  }

  @override
  Future<void> forgotPassword(String email) => _remote.forgotPassword(email);

  @override
  Future<void> resetPassword({required String token, required String newPassword}) {
    return _remote.resetPassword(token: token, newPassword: newPassword);
  }

  @override
  Future<void> logout() => _remote.logout();
}