import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/onboarding/presentation/controllers/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(AppSizes.paddingM),
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    'تخطي',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: AppSizes.fontL,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 62),

            // Spacer(),
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.items.length,
                reverse: true,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingL,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(item.image, height: 300, fit: BoxFit.cover),
                        SizedBox(height: AppSizes.paddingL),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: AppSizes.fontXXL,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppSizes.paddingS),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Text(
                            item.description,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: AppSizes.fontS,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizes.paddingS),
                      ],
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: AppSizes.paddingL),
            Obx(
              () => Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    controller.items.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: controller.currentPage.value == index ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Spacer(),
            const SizedBox(height: 154),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingM,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLastPage
                        ? controller.goToLogin
                        : controller.nextPage,
                    // onPressed: controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      ),
                      elevation: 0,
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text(
                      'التالي',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        color: Colors.white,
                        fontSize: AppSizes.fontL,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.paddingL),
          ],
        ),
      ),
    );
  }
}
