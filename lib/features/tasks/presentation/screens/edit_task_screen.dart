import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/edit_task_controller.dart';

class EditTaskScreen extends GetView<EditTaskController> {
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 24),

                // العنوان + سهم رجوع
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'تعديل المهمة',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingS),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.paddingL),

                // عنوان المهمة
                _buildLabel('عنوان المهمة'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.titleController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  decoration: _inputDecoration('مثال: غسيل الملابس'),
                  validator: (v) =>
                  v == null || v.isEmpty ? 'عنوان المهمة مطلوب' : null,
                ),

                const SizedBox(height: AppSizes.paddingL),

                // الوصف
                _buildLabel('الوصف'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.descriptionController,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  maxLines: 3,
                  decoration: _inputDecoration('أضف تفاصيل إضافية عن المهمة...'),
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

                // الوقت
                _buildLabel('الوقت'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.timeController,
                  readOnly: true,
                  textAlign: TextAlign.right,
                  onTap: () => controller.pickTime(context),
                  decoration: _inputDecoration('اختر الوقت').copyWith(
                    suffixIcon: const Icon(Icons.access_time),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingL),

                // التاريخ
                _buildLabel('التاريخ'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.dateController,
                  readOnly: true,
                  textAlign: TextAlign.right,
                  onTap: () => controller.pickDate(context),
                  decoration: _inputDecoration('اختر التاريخ').copyWith(
                    suffixIcon: const Icon(Icons.calendar_today_outlined),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingL),

                // الأولوية
                _buildLabel('الأولوية'),
                const SizedBox(height: 8),
                Obx(
                      () => Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.end,
                    children: controller.priorityOptions.map((priority) {
                      final active = controller.selectedPriority.value == priority;
                      return GestureDetector(
                        onTap: () => controller.selectPriority(priority),
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
                            priority,
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

                const SizedBox(height: AppSizes.paddingXL),

                // زر تعديل المهمة
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                      controller.isLoading.value ? null : controller.saveChanges,
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
                        'تعديل المهمة',
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