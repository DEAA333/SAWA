import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isNewPasswordHidden = true.obs;
  final isConfirmNewPasswordHidden = true.obs;
  final isLoading = false.obs;

  // شروط كلمة المرور
  final hasMinLength = false.obs;

  final hasUpperAndLower = false.obs;
  final hasNumberAndSymbol = false.obs;

  bool get isPasswordValid =>
      hasMinLength.value && hasUpperAndLower.value && hasNumberAndSymbol.value;

  void onPasswordChanged(String value) {
    hasMinLength.value = value.length >= 8;
    hasUpperAndLower.value =
        value.contains(RegExp(r'[A-Z]')) && value.contains(RegExp(r'[a-z]'));
    hasNumberAndSymbol.value =
        value.contains(RegExp(r'[0-9]')) &&
        value.contains(RegExp(r'[!@#\$&*~%^()_\-+=\[\]{};:,.<>?/\\|`]'));
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }

  void toggleConfirmNewPasswordVisibility() =>
      isConfirmNewPasswordHidden.value = !isConfirmNewPasswordHidden.value;

  void changePassWord() {
    if (!formKey.currentState!.validate()) return;
    if (!isPasswordValid) return;

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 16),
                Text(
                'تم تغيير كلمة المرور',
                style: AppTextStyles.splashSubtitle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
                Text(
                'يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة',
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle.copyWith(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // أغلق الـ dialog
                    Get.offAllNamed(AppRoutes.LOGIN); // روح للـ Login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:   Text(
                    'العودة لتسجيل الدخول',
                    style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white,fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
