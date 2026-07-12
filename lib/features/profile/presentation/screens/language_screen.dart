import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/profile_controller.dart';

class LanguageScreen extends GetView<ProfileController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = ['العربية', 'الإنجليزية', 'الإيطالية', 'الفرنسية'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_forward),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  ),
                  Text('اللغات', style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.paddingL),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Obx(() => Column(
                  children: languages.asMap().entries.map((entry) {
                    final lang = entry.value;
                    final isLast = entry.key == languages.length - 1;
                    final selected = controller.selectedLanguage.value == lang;
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            controller.selectedLanguage.value = lang;
                            // TODO: Get.updateLocale(Locale(...))
                          },
                          leading: selected
                              ? const Icon(Icons.circle, color: AppColors.primary, size: 12)
                              : const Icon(Icons.circle_outlined, color: Colors.grey, size: 12),
                          title: Text(lang, textAlign: TextAlign.end,
                              style: AppTextStyles.splashSubtitle.copyWith(
                                fontSize: 14,
                                color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                              )),
                        ),
                        if (!isLast) Divider(height: 1, color: Colors.grey.shade100),
                      ],
                    );
                  }).toList(),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingL),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('حفظ التعديلات',
                      style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}