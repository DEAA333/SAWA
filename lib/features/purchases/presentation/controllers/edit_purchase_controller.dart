import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class EditPurchaseController extends GetxController {
  late Task originalPurchase;

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

  @override
  void onInit() {
    super.onInit();
    originalPurchase = Get.arguments as Task;

    // تعبئة الحقول ببيانات المشترى الحالي
    priceController.text = originalPurchase.points.toString();
    noteController.text = originalPurchase.description;
    selectedCategory.value = categories.contains(originalPurchase.category)
        ? originalPurchase.category
        : 'طعام';

    final matchedMember = familyMembers.firstWhereOrNull(
          (m) => m['id'] == originalPurchase.assigneeId ||
          m['name'] == originalPurchase.assigneeName,
    );
    if (matchedMember != null) {
      selectedAssigneeId.value = matchedMember['id']!;
      selectedAssigneeName.value = matchedMember['name']!;
    } else if (originalPurchase.assigneeName.isNotEmpty) {
      selectedAssigneeName.value = originalPurchase.assigneeName;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void selectAssignee(String id, String name) {
    selectedAssigneeId.value = id;
    selectedAssigneeName.value = name;
  }

  void saveChanges() {
    if (!formKey.currentState!.validate()) return;
    if (selectedAssigneeId.value.isEmpty && selectedAssigneeName.value.isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء اختيار الشخص المسؤول');
      return;
    }

    isLoading.value = true;

    // TODO (API): await updatePurchaseUseCase(...)
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;

      final updatedPurchase = originalPurchase.copyWith(
        name: noteController.text.trim().isEmpty
            ? selectedCategory.value
            : noteController.text.trim(),
        description: noteController.text.trim(),
        assigneeId: selectedAssigneeId.value,
        assigneeName: selectedAssigneeName.value,
        category: selectedCategory.value,
        points: int.tryParse(priceController.text) ?? originalPurchase.points,
      );

      if (Get.isRegistered<ActivitiesController>()) {
        Get.find<ActivitiesController>().updatePurchase(updatedPurchase);
      }

      Get.back();
      Get.snackbar(
        'تم التعديل',
        'تم حفظ التغييرات على المشترى بنجاح',
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  @override
  void onClose() {
    priceController.dispose();
    noteController.dispose();
    super.onClose();
  }
}