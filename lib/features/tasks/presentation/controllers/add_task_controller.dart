import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/widgets/app_dialogs.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final priorityOptions = ['منخفضة', 'متوسطة', 'عالية'];
  final selectedPriority = 'متوسطة'.obs;

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
    // ✅ افتراضيًا المهمة الجديدة تكون مستحقة اليوم، لحتى فلتر "اليوم" يشتغل مباشرة
    dateController.text = _formatDate(DateTime.now());
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void selectAssignee(String id, String name) {
    selectedAssigneeId.value = id;
    selectedAssigneeName.value = name;
  }

  void selectPriority(String priority) {
    selectedPriority.value = priority;
  }

  Future<void> pickDate(BuildContext context) async {
    final initial = DateTime.tryParse(dateController.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      dateController.text = _formatDate(picked);
    }
  }

  void addTask() {
    if (!formKey.currentState!.validate()) return;
    if (selectedAssigneeId.value.isEmpty) {
      Get.snackbar('تنبيه', 'الرجاء اختيار الشخص المسؤول');
      return;
    }

    isLoading.value = true;

    // TODO (API): استبدل هاد الجزء بنداء usecase حقيقي
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;

      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: titleController.text,
        description: descriptionController.text.trim(),
        assigneeId: selectedAssigneeId.value,
        assigneeName: selectedAssigneeName.value,
        points: 0,
        status: 'pending',
        category: 'task',
        priority: TaskPriority.fromArabic(selectedPriority.value), // ✅ تخزين صحيح
        dueDate: dateController.text, // ✅ تاريخ حقيقي
      );

      if (Get.isRegistered<ActivitiesController>()) {
        Get.find<ActivitiesController>().addTask(newTask);
      }

      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    AppDialogs.showSuccess(
      title: 'تم إنشاء المهمة 🎉',
      message: 'تم إرسال إشعار إلى ${selectedAssigneeName.value} لقبول المهمة',
      buttonText: 'العودة للمهام',
      onPressed: () {
        Get.back();
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.onClose();
  }
}