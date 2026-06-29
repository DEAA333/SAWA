import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/features/family/presentation/controllers/CustomPainter.dart';
import '../controllers/create_family_controller.dart';

class FamilyCodeScreen extends GetView<CreateFamilyController> {
  const FamilyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // العنوان
              Text(
                'تم إنشاء العائلة',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'يمكنك الآن مسح أو مشاركة رمز العائلة الجديدة',
                textAlign: TextAlign.center,
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSizes.paddingXL),

              // QR Code
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  decoration: BoxDecoration(
                    color: Color(0xFFE9EFFD),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QrImageView(
                          data: controller.familyCode.value,
                          version: QrVersions.auto,
                          size: 248,
                          backgroundColor: Colors.white,
                          eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: AppColors.primary,
                          ),
                          dataModuleStyle: const QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: CornerBorderPainter(
                            color: AppColors.primary,
                            strokeWidth: 4,
                            cornerLength: 20,
                            radius: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              // الكود النصي
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingL,
                    vertical: AppSizes.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFE9EFFD),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      // أيقونة نسخ
                      GestureDetector(
                        onTap: () {
                          // TODO: نسخ الكود للـ clipboard
                          Get.snackbar(
                            'تم النسخ',
                            'تم نسخ رمز العائلة',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Icon(
                          Icons.copy_outlined,
                          size: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // الكود
                      Text(
                        controller.familyCode.value,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // زر المتابعة إلى الرئيسية
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.JOIN_FAMILY),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'المتابعة إلى الرئيسية',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),
            ],
          ),
        ),
      ),
    );
  }
}
