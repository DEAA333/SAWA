import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/core/widgets/app_dialogs.dart';

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
    AppDialogs.showSuccess(
      title: 'تم تغيير كلمة المرور',
      message: 'يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة',
      buttonText: 'العودة لتسجيل الدخول',
      onPressed: () => Get.offAllNamed(AppRoutes.LOGIN),
    );
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
