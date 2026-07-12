import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/core/widgets/app_dialogs.dart';

class JoinFamilyController extends GetxController {
  final codeController = TextEditingController();
  final isLoading = false.obs;

  void joinFamily() {
    if (codeController.text.length < 4) return;

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;

      // TODO: لما يجهز الـ API
      // مؤقتاً: لو الكود صح نطلع نجاح، لو غلط نطلع خطأ
      if (codeController.text == '1A9C') {
        _showSuccessDialog();
      } else {
        _showErrorDialog();
      }
    });
  }

  void _showErrorDialog() {
    AppDialogs.showError(
      title: 'الرمز غير صحيح',
      message: 'من فضلك تأكد من الرمز وأعد المحاولة',
      buttonText: 'إعادة المحاولة',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'هل أنت مالك هذه العائلة؟',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.toNamed(AppRoutes.RECOVER_CODE);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'إستعادة الرمز',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    AppDialogs.showSuccess(
      title: 'تم الإنضمام للعائلة',
      message: 'رائع! يمكنك البدء الآن.',
      buttonText: 'المتابعة إلى الرئيسية',
      onPressed: () => Get.offAllNamed(AppRoutes.HOME),
    );
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
