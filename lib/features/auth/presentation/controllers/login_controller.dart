import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/network/api_exception.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/features/auth/domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  final _authRepository = Get.find<AuthRepository>();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      // TODO (Phase 3): نتحقق هون إذا عنده عائلة فعلاً (GET /families/myFamily)
      // ولو ما عنده، نوديه FAMILY_SETUP، ولو عنده نوديه HOME مباشرة
      Get.offAllNamed(AppRoutes.FAMILY_SETUP);
    } on ApiException catch (e) {
      Get.snackbar('خطأ', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void loginWithGoogle() {
    Get.snackbar('Google Login', 'Coming soon...');
  }

  void loginWithApple() {
    Get.snackbar('Apple Login', 'Coming soon...');
  }

  void goToForgotPassword() => Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  void goToRegister() => Get.toNamed(AppRoutes.REGISTER);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}