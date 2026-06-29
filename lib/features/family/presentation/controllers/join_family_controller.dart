import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

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
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.white,

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
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 16),
              Text(
                'الرمز غير صحيح',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'من فضلك تأكد من الرمز وأعد المحاولة',
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'إعادة المحاولة',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'هل أنت مالك هذه العائلة؟',

                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
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
                    child: Text(
                      'إستعادة الرمز',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        color: Color(0xFF2563EB),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
   backgroundColor: Colors.white,
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
                'تم الإنضمام للعائلة',
                style: AppTextStyles.splashSubtitle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
                Text(
                'رائع! يمكنك البدء الآن.',
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle.copyWith(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // صور الأعضاء (مؤقتاً placeholders)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Transform.translate(
                    offset: Offset(index * -10.0, 0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.grey.shade300,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.offAllNamed(AppRoutes.HOME);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    ),

                  child:  Text(
                    'المتابعة إلى الرئيسية',
                    style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white,fontSize: 16),
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
    codeController.dispose();
    super.onClose();
  }
}
