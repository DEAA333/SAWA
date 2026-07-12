import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/add_purchase_controller.dart';

class AddPurchaseItemScreen extends GetView<AddPurchaseController> {
  const AddPurchaseItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                // الهيدر
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        'إضافة غرض جديد',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.paddingXL),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('اسم الغرض'),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: controller.noteController,
                          textAlign: TextAlign.right,
                          decoration: _inputDecoration('مثلاً: حليب، خبز...'),
                          validator: (v) => v == null || v.isEmpty ? 'يرجى إدخال اسم الغرض' : null,
                        ),
                        
                        const SizedBox(height: AppSizes.paddingL),
                        
                        _buildLabel('التصنيف'),
                        const SizedBox(height: 8),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.categories.map((cat) {
                              final active = controller.selectedCategory.value == cat;
                              return GestureDetector(
                                onTap: () => controller.selectCategory(cat),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: active ? AppColors.primary : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: active ? AppColors.primary : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Text(
                                    cat,
                                    style: AppTextStyles.splashSubtitle.copyWith(
                                      fontSize: 13,
                                      color: active ? Colors.white : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: AppSizes.paddingL),

                        _buildLabel('الشخص المسؤول'),
                        const SizedBox(height: 8),
                        Obx(
                          () => Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.familyMembers.map((member) {
                              final active = controller.selectedAssigneeId.value == member['id'];
                              return GestureDetector(
                                onTap: () => controller.selectAssignee(member['id']!, member['name']!),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: active ? AppColors.primary.withOpacity(0.1) : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: active ? AppColors.primary : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(member['avatar']!, style: const TextStyle(fontSize: 16)),
                                      const SizedBox(width: 6),
                                      Text(
                                        member['name']!,
                                        style: AppTextStyles.splashSubtitle.copyWith(
                                          fontSize: 13,
                                          color: active ? AppColors.primary : AppColors.textSecondary,
                                          fontWeight: active ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // زر الإضافة
                Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingL),
                  child: Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.confirmPurchase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.radiusM),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'إضافة للقائمة',
                                style: AppTextStyles.splashSubtitle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.splashSubtitle.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.splashSubtitle.copyWith(color: Colors.grey.shade400, fontSize: 14),
      fillColor: Colors.grey.shade100,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
