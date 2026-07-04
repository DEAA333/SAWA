import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/features/home/presentation/controllers/home_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class TaskDetailsController extends GetxController {
  late Task task;

  final rejectionReasonController = TextEditingController();
  final completionNoteController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    task = Get.arguments as Task;
  }

  // ==============================
  // قبول المهمة
  // ==============================
  void acceptTask() {
    isLoading.value = true;

    // TODO (API): await updateTaskStatusUseCase(id: task.id, status: 'accepted');

    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
      _updateTaskInHome('accepted');
      _showResultDialog(
        icon: Icons.check,
        iconColor: const Color(0xFF22C55E),
        title: 'تم قبول المهمة',
        subtitle: 'رائع! يمكنك البدء الآن.',
      );
    });
  }

  // ==============================
  // رفض المهمة (يفتح حقل السبب أولاً)
  // ==============================
  void showRejectSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'تم رفض المهمة',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'من فضلك زودنا بسبب الرفض',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('سبب الرفض', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: rejectionReasonController,
              maxLines: 3,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'أضف تفاصيل الرفض',
                hintTextDirection: TextDirection.rtl,
                fillColor: Colors.grey.shade100,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: rejectTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تأكيد الرفض',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void rejectTask() {
    Get.back(); // أغلق الـ bottom sheet

    // TODO (API): await updateTaskStatusUseCase(
    //   id: task.id, status: 'rejected', rejectionReason: rejectionReasonController.text);

    _updateTaskInHome('rejected');
    _showResultDialog(
      icon: Icons.close,
      iconColor: const Color(0xFFEF4444),
      title: 'تم رفض المهمة',
      subtitle: 'من فضلك زودنا بسبب الرفض',
    );
  }

  // ==============================
  // إنجاز المهمة
  // ==============================
  void goToCompleteTask() {
    Get.toNamed(AppRoutes.COMPLETE_TASK, arguments: task);
  }

  void completeTask() {
    if (completionNoteController.text.isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء إضافة ملاحظة الإنجاز');
      return;
    }

    // TODO (API): await updateTaskStatusUseCase(
    //   id: task.id, status: 'completed', completionNote: completionNoteController.text);

    _updateTaskInHome('completed');
    Get.back(); // ارجع لتفاصيل المهمة

    _showResultDialog(
      icon: Icons.local_fire_department,
      iconColor: Colors.orange,
      title: 'أحسنت!',
      subtitle: 'تم إنجاز المهمة وزيادة التقدم اليومي.',
    );
  }

  // ==============================
  // حذف المهمة
  // ==============================
  void showDeleteDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 16),
              const Text(
                'حذف المهمة؟',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'لا يمكن التراجع عن هذا الإجراء. سيتم حذف المهمة بشكل دائم.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('إلغاء', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: deleteTask,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('حذف', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    Get.back(); // أغلق الـ dialog
    Get.back(); // ارجع للأنشطة

    // TODO (API): await deleteTaskUseCase(task.id);

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().tasksList.removeWhere((t) => t.id == task.id);
      Get.find<HomeController>().updateStatistics();
    }
  }

  // ==============================
  // Helpers
  // ==============================
  void _updateTaskInHome(String status) {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().updateTaskStatus(task.id, status);
    }
  }

  void _showResultDialog({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 16),
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // أغلق الـ dialog
                    Get.back(); // ارجع للأنشطة
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('العودة للمهام', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    rejectionReasonController.dispose();
    completionNoteController.dispose();
    super.onClose();
  }
}