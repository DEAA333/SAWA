import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/edit_purchase_controller.dart';

class EditPurchaseScreen extends GetView<EditPurchaseController> {
  const EditPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 24),

                  // الهيدر
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                        ),
                      ),
                      Text(
                        'تعديل الشراء',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: AppSizes.paddingL),

                  // السعر
                  _buildLabel('السعر'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.priceController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('٠٠٠').copyWith(
                      suffixText: 'ر.س',
                      suffixStyle: AppTextStyles.splashSubtitle.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    validator: (v) =>
                    v == null || v.isEmpty ? 'السعر مطلوب' : null,
                  ),

                  const SizedBox(height: AppSizes.paddingL),

                  // التصنيف
                  _buildLabel('التصنيف'),
                  const SizedBox(height: 8),
                  Obx(
                        () => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: controller.categories.map((cat) {
                        final active = controller.selectedCategory.value == cat;
                        return GestureDetector(
                          onTap: () => controller.selectCategory(cat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: active ? AppColors.primary : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: active
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              cat,
                              style: AppTextStyles.splashSubtitle.copyWith(
                                fontSize: 13,
                                color: active
                                    ? Colors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: AppSizes.paddingL),

                  // الشخص المسؤول
                  _buildLabel('الشخص المسؤول'),
                  const SizedBox(height: 8),
                  Obx(
                        () => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: controller.familyMembers.map((member) {
                        final active =
                            controller.selectedAssigneeId.value == member['id'];
                        return GestureDetector(
                          onTap: () => controller.selectAssignee(
                              member['id']!, member['name']!),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: active
                                    ? AppColors.primary
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(member['avatar']!,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(width: 6),
                                Text(
                                  member['name']!,
                                  style: AppTextStyles.splashSubtitle.copyWith(
                                    fontSize: 13,
                                    color: active
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                                    fontWeight: active
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: AppSizes.paddingL),

                  // ملاحظة الشراء
                  _buildLabel('ملاحظة الشراء'),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.noteController,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    maxLines: 3,
                    decoration: _inputDecoration('أضف ملاحظة...'),
                  ),

                  const SizedBox(height: AppSizes.paddingXL),

                  // زر حفظ التعديل
                  Obx(
                        () => SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(AppSizes.radiusM),
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
                          'حفظ التعديل',
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
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: AppTextStyles.splashSubtitle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: AppTextStyles.splashSubtitle.copyWith(
        color: Colors.grey.shade400,
      ),
      fillColor: Colors.grey.shade100,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      contentPadding: const EdgeInsets.all(14),
    );
  }
}