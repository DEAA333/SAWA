import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  void sendCode() {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.toNamed(AppRoutes.OTP);
      // Get.toNamed(AppRoutes.OTP);
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}