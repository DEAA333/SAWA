import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  // Mock أعضاء العائلة — TODO (API): استبدل بـ getFamilyMembersUseCase
  final members = const [
    {'name': 'أبو محمد', 'avatar': '👨'},
    {'name': 'سعيد', 'avatar': '👦'},
    {'name': 'فاطمة', 'avatar': '👩'},
    {'name': 'نورة', 'avatar': '👧'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_forward),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  ),
                  Text('العائلة', style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: AppSizes.paddingXL),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.paddingL),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('تم الإنضمام لعائلة',
                        style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('أنت الآن ضمن عائلة أبو محمد',
                        style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 13, color: AppColors.textSecondary)),
                    const SizedBox(height: AppSizes.paddingM),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: members.map((m) => Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.blue.shade50,
                              child: Text(m['avatar']!, style: const TextStyle(fontSize: 20)),
                            ),
                            const SizedBox(height: 4),
                            Text(m['name']!, style: AppTextStyles.splashSubtitle.copyWith(
                                fontSize: 10, color: AppColors.textSecondary)),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.HOME),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('رؤية الأنشطة',
                      style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white, fontSize: 15)),
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    // TODO (API): await leaveFamily()
                    Get.offAllNamed(AppRoutes.FAMILY_SETUP);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('خروج', style: AppTextStyles.splashSubtitle.copyWith(
                      color: Colors.red, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}