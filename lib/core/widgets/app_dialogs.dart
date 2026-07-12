import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';

class AppDialogs {
  AppDialogs._();

  static void showSuccess({
    required String title,
    required String message,
    String buttonText = 'حسناً',
    VoidCallback? onPressed,
  }) {
    _showBaseDialog(
      icon: const Icon(Icons.check_circle, color: Colors.green, size: 60),
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }

  static void showAchievement({
    required String title,
    required String message,
    String buttonText = 'استمرار',
    VoidCallback? onPressed,
  }) {
    _showBaseDialog(
      icon: const Icon(Icons.local_fire_department, color: Colors.orange, size: 60),
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }

  static void showError({
    required String title,
    required String message,
    String buttonText = 'محاولة أخرى',
    VoidCallback? onPressed,
    Widget? child,
  }) {
    _showBaseDialog(
      icon: const Icon(Icons.cancel, color: Colors.red, size: 60),
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      child: child,
    );
  }

  static void showReject({
    required String title,
    required String message,
    required TextEditingController controller,
    String buttonText = 'تأكيد الرفض',
    String secondaryButtonText = 'تراجع',
    required VoidCallback onPressed,
  }) {
    _showBaseDialog(
      icon: const Icon(Icons.cancel, color: Colors.red, size: 60),
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      secondaryButtonText: secondaryButtonText,
      onSecondaryPressed: () => Get.back(),
      child: Column(
        children: [
          const SizedBox(height: AppSizes.paddingM),
          TextField(
            controller: controller,
            maxLines: 3,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'اكتب سبب الرفض هنا...',
              hintStyle: AppTextStyles.splashSubtitle.copyWith(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showConfirm({
    required String title,
    required String message,
    String buttonText = 'حذف',
    String secondaryButtonText = 'إلغاء',
    required VoidCallback onPressed,
  }) {
    _showBaseDialog(
      icon: const Icon(Icons.warning, color: Colors.red, size: 60),
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      secondaryButtonText: secondaryButtonText,
      onSecondaryPressed: () => Get.back(),
      buttonColor: Colors.red,
    );
  }

  static void _showBaseDialog({
    required Widget icon,
    required String title,
    required String message,
    required String buttonText,
    VoidCallback? onPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryPressed,
    Widget? child,
    Color? buttonColor,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: AppSizes.paddingM),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.paddingS),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              if (child != null) child,
              const SizedBox(height: AppSizes.paddingL),
              Row(
                children: [
                  if (secondaryButtonText != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: OutlinedButton(
                          onPressed: onSecondaryPressed ?? () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.radiusM),
                            ),
                          ),
                          child: Text(
                            secondaryButtonText,
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressed ?? () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor ?? AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusM),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
