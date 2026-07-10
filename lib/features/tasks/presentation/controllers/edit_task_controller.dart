import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class EditTaskController extends GetxController {
  late Task originalTask;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
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
    originalTask = Get.arguments as Task;

    // تعبئة الحقول ببيانات المهمة الحالية
    titleController.text = originalTask.name;
    descriptionController.text = originalTask.description;
    timeController.text = originalTask.dueTime;
    dateController.text = originalTask.dueDate;
    selectedPriority.value = TaskPriority.toArabic(originalTask.priority);

    final matchedMember = familyMembers.firstWhereOrNull(
          (m) => m['name'] == originalTask.assigneeName,
    );
    if (matchedMember != null) {
      selectedAssigneeId.value = matchedMember['id']!;
      selectedAssigneeName.value = matchedMember['name']!;
    } else if (originalTask.assigneeName.isNotEmpty) {
      selectedAssigneeName.value = originalTask.assigneeName;
    }
  }

  void selectAssignee(String id, String name) {
    selectedAssigneeId.value = id;
    selectedAssigneeName.value = name;
  }

  void selectPriority(String priority) {
    selectedPriority.value = priority;
  }

  Future<void> pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      dateController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  void saveChanges() {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    // TODO (API): await updateTaskUseCase(...)
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;

      final updatedTask = originalTask.copyWith(
        name: titleController.text.trim(),
        description: descriptionController.text.trim(),
        assigneeId: selectedAssigneeId.value,
        assigneeName: selectedAssigneeName.value,
        priority: TaskPriority.fromArabic(selectedPriority.value),
        dueTime: timeController.text,
        dueDate: dateController.text,
      );

      if (Get.isRegistered<ActivitiesController>()) {
        Get.find<ActivitiesController>().updateTask(updatedTask);
      }

      Get.back(); // ارجع لتفاصيل/قائمة المهام
      Get.snackbar(
        'تم التعديل',
        'تم حفظ التغييرات على المهمة بنجاح',
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.onClose();
  }
}