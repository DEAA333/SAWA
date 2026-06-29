// create_family_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/create_family_controller.dart';

class CreateFamilyScreen extends GetView<CreateFamilyController> {
  const CreateFamilyScreen({super.key});

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
              const SizedBox(height: AppSizes.paddingL),

              // العنوان + سهم رجوع
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'إنشاء عائلة جديدة',
                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '.قم بإنشاء عائلة جديدة لتوزيع مهام عائلتك',
                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppSizes.paddingS),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.paddingXL),

              // Form
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        const SizedBox(height: AppSizes.paddingXL),

                        // اسم العائلة
                        Text(
                          'إسم العائلة',

                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: AppSizes.paddingS),

                        TextFormField(
                          controller: controller.familyNameController,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.people_outline,color: Colors.grey,),
                            hintText: 'مثال: عائلة أحمد',
                            hintStyle: AppTextStyles.splashSubtitle.copyWith(
                              color: AppColors.textSecondary.withOpacity(0.5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingM,
                              vertical: AppSizes.paddingM,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'أدخل اسم العائلة';
                            }
                            if (value.length < 3) {
                              return 'اسم العائلة يجب أن يكون 3 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppSizes.paddingXL),

                        TextFormField(
                          controller: controller.familyDescriptionController,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                           decoration: InputDecoration(
                            hintText: 'اختياري',
                            hintStyle: AppTextStyles.splashSubtitle.copyWith(
                              color: AppColors.textSecondary.withOpacity(0.5),
                            ),
                            prefixIcon: Icon(Icons.edit_outlined,color: Colors.grey,),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingM,
                              vertical: AppSizes.paddingM,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            // اختياري - لا يوجد validation مطلوب
                            if (value != null && value.isNotEmpty) {
                              if (value.length < 5) {
                                return 'الوصف يجب أن يكون 5 أحرف على الأقل';
                              }
                              if (value.length > 100) {
                                return 'الوصف يجب أن لا يزيد عن 100 حرف';
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              // زر الإنشاء
              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.createFamily,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      'إنشاء العائلة',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
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