import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/core/widgets/app_dialogs.dart';
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
      AppDialogs.showSuccess(
        title: 'تم قبول المهمة',
        message: 'رائع! يمكنك البدء الآن.',
        buttonText: 'العودة للمهام',
        onPressed: () {
          Get.back(); // أغلق الـ dialog
          Get.back(); // ارجع للأنشطة
        },
      );
    });
  }

  // ==============================
  // رفض المهمة (يفتح حقل السبب أولاً)
  // ==============================
  void showRejectSheet() {
    AppDialogs.showReject(
      title: 'تم رفض المهمة',
      message: 'من فضلك زودنا بسبب الرفض',
      controller: rejectionReasonController,
      onPressed: rejectTask,
    );
  }

  void rejectTask() {
    Get.back(); // أغلق الـ dialog

    // TODO (API): await updateTaskStatusUseCase(
    //   id: task.id, status: 'rejected', rejectionReason: rejectionReasonController.text);

    _updateTaskInHome('rejected');
    AppDialogs.showError(
      title: 'تم رفض المهمة',
      message: 'من فضلك زودنا بسبب الرفض',
      buttonText: 'العودة للمهام',
      onPressed: () {
        Get.back(); // أغلق الـ dialog
        Get.back(); // ارجع للأنشطة
      },
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

    AppDialogs.showAchievement(
      title: 'أحسنت!',
      message: 'تم إنجاز المهمة وزيادة التقدم اليومي.',
      buttonText: 'العودة للمهام',
      onPressed: () {
        Get.back(); // أغلق الـ dialog
        Get.back(); // ارجع للأنشطة
      },
    );
  }

  // ==============================
  // حذف المهمة
  // ==============================
  void showDeleteDialog() {
    AppDialogs.showConfirm(
      title: 'حذف المهمة؟',
      message: 'لا يمكن التراجع عن هذا الإجراء. سيتم حذف المهمة بشكل دائم.',
      buttonText: 'حذف',
      onPressed: deleteTask,
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

  @override
  void onClose() {
    rejectionReasonController.dispose();
    completionNoteController.dispose();
    super.onClose();
  }
}
