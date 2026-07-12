// forgot_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/network/api_exception.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final _authRepository = Get.find<AuthRepository>();

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await _authRepository.forgotPassword(emailController.text.trim());
      Get.toNamed(AppRoutes.OTP, arguments: {'email': emailController.text.trim()});
      // ⚠️ ملاحظة: الـ API بيرسل "resetToken" غالبًا عبر إيميل مباشرة (رابط)
      // مش عبر كود OTP بالتطبيق. لازم نتأكد كيف بالضبط بيوصل الـ token
      // (إيميل فيه رابط؟ أو كود رقمي؟) قبل ما نكمل شاشة "كلمة مرور جديدة".
    } on ApiException catch (e) {
      Get.snackbar('خطأ', e.message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}