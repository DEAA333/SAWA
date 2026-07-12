import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/widgets/app_dialogs.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class AddPurchaseController extends GetxController {
  final priceController = TextEditingController();
  final noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final categories = ['طعام', 'تنظيف', 'فواتير', 'صحة', 'أخرى'];
  final selectedCategory = 'طعام'.obs;

  final familyMembers = [
    {'id': '1', 'name': 'عمر', 'avatar': '👨'},
    {'id': '2', 'name': 'ليان', 'avatar': '👧'},
    {'id': '3', 'name': 'أحمد', 'avatar': '👦'},
    {'id': '4', 'name': 'سارة', 'avatar': '👩'},
  ];
  final selectedAssigneeId = ''.obs;
  final selectedAssigneeName = ''.obs;

  final isLoading = false.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectAssignee(String id, String name) {
    selectedAssigneeId.value = id;
    selectedAssigneeName.value = name;
  }

  void confirmPurchase() {
    if (!formKey.currentState!.validate()) return;
    if (selectedAssigneeId.value.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'الرجاء اختيار الشخص المسؤول',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    // TODO (API): await addPurchaseUseCase(...)
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;

      final newPurchase = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: noteController.text.trim().isEmpty
            ? selectedCategory.value
            : noteController.text.trim(),
        description: noteController.text.trim(),
        assigneeId: selectedAssigneeId.value,
        assigneeName: selectedAssigneeName.value,
        status: 'pending',
        category: selectedCategory.value,
        points: int.tryParse(priceController.text) ?? 0,
      );

      // ✅ التعديل الأساسي: بنستدعي الدالة الموحّدة بدل ما نلعب بالقوائم مباشرة
      if (Get.isRegistered<ActivitiesController>()) {
        Get.find<ActivitiesController>().addPurchase(newPurchase);
      }

      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    AppDialogs.showSuccess(
      title: 'تمت الإضافة 🎉',
      message: 'سيتلقى ${selectedAssigneeName.value} إشعاراً بالعنصر الجديد',
      buttonText: 'العودة للقائمة',
      onPressed: () {
        Get.back(); // أغلق الـ dialog
        Get.back(); // ارجع للقائمة
      },
    );
  }

  @override
  void onClose() {
    priceController.dispose();
    noteController.dispose();
    super.onClose();
  }
}