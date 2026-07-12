import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

    final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    if (!formKey.currentState!.validate()) return;

    // TODO: لما يجهز الـ API، هون رح نستدعي usecase تسجيل الدخول
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      // مؤقتاً بس نطبع، بدون أي navigation فعلي
      Get.offAllNamed(AppRoutes.FAMILY_SETUP);

    });
  }

  void loginWithGoogle() {
    // TODO: Implement Google Login logic
    Get.snackbar('Google Login', 'Coming soon...');
  }

  void loginWithApple() {
    // TODO: Implement Apple Login logic
    Get.snackbar('Apple Login', 'Coming soon...');
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}