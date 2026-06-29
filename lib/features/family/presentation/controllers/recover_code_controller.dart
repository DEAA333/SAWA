import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class RecoverCodeController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  void sendCode() {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      // TODO: ربط API
      Get.snackbar(
        'تم الإرسال',
        'تم إرسال رمز العائلة إلى بريدك الإلكتروني',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF22C55E),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        onTap: (_) {},

      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.offNamed(AppRoutes.JOIN_FAMILY);
      });
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}