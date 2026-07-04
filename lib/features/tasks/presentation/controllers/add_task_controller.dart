import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/features/home/presentation/controllers/home_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
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

  void selectAssignee(String id, String name) {
    selectedAssigneeId.value = id;
    selectedAssigneeName.value = name;
  }

  void selectPriority(String priority) {
    selectedPriority.value = priority;
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

      // إنشاء المهمة الجديدة محلياً
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: titleController.text,
        assigneeName: selectedAssigneeName.value,
        points: 0,
        status: 'pending',
        category: 'task',
       );

      // ⬅️ أضفها مباشرة على قائمة الـ Home
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().addTask(newTask);
      }

      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
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
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 16),
              const Text(
                'تم إنشاء المهمة 🎉',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'تم إرسال إشعار إلى ${selectedAssigneeName.value} لقبول المهمة',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // أغلق الـ dialog
                    Get.back(); // ارجع للمهام
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'العودة للمهام',
                    style: TextStyle(color: Colors.white),
                  ),
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
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}