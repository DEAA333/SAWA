import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';
import '../controllers/task_details_controller.dart';

class TaskDetailsScreen extends GetView<TaskDetailsController> {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = controller.task;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
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
                      'تفاصيل المهمة',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 20,
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

              const SizedBox(height: AppSizes.paddingM),

              // بطاقة المهمة العلوية
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: task.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            task.name,
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9EFFD),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time_outlined, size: 12, color: AppColors.primary),
                                    const SizedBox(width: 4),
                                    Text('اليوم', style: TextStyle(fontSize: 11, color: AppColors.primary)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('مقبولة', style: TextStyle(fontSize: 11, color: Colors.green)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              // عنوان المهمة
              _buildLabel('عنوان المهمة'),
              const SizedBox(height: 8),
              _buildReadOnlyField(task.name),

              const SizedBox(height: AppSizes.paddingL),

              // الوصف
              _buildLabel('الوصف'),
              const SizedBox(height: 8),
              _buildReadOnlyField(
                task.description.isEmpty ? 'لا يوجد وصف' : task.description,
                maxLines: 3,
              ),

              const SizedBox(height: AppSizes.paddingL),

              // الشخص المسؤول
              _buildInfoRow('الشخص المسؤول', task.assigneeName),
              _buildInfoRow('الأولوية', task.priority),
              _buildInfoRow('الحالة', task.statusLabel, isStatus: true),

              const Spacer(),

              // أزرار قبول / رفض
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.acceptTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
                  ),
                  child: Text('قبول', style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: controller.showRejectSheet,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusM)),
                  ),
                  child: Text('رفض', style: AppTextStyles.splashSubtitle.copyWith(color: Colors.red)),
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),
            ],
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
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String text, {int maxLines = 1}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        textAlign: TextAlign.right,
        maxLines: maxLines,
        style: AppTextStyles.splashSubtitle.copyWith(fontSize: 14, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.splashSubtitle.copyWith(fontSize: 13, color: Colors.grey)),
          Row(
            children: [
              if (isStatus)
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(left: 6),
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                ),
              Text(
                value,
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}