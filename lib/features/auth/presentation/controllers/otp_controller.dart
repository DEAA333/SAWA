import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class OtpController extends GetxController {
  final otpController = TextEditingController();
  final isLoading = false.obs;
  final secondsRemaining = 60.obs;
  final canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    secondsRemaining.value = 60;
    canResend.value = false;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
        return true;
      }
      canResend.value = true;
      return false;
    });
  }

  void verifyOtp() {
    if (otpController.text.length < 4) return;

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.toNamed(AppRoutes.NEW_PASSWORD);
    });
  }

  void resendCode() {
    if (!canResend.value) return;
    startTimer();
    // TODO: ربط API إعادة إرسال الرمز
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}