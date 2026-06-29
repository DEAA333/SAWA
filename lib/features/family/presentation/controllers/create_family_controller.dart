// create_family_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class CreateFamilyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final familyNameController = TextEditingController();
  final familyDescriptionController = TextEditingController();

  final isLoading = false.obs;

  final familyCode = '444'.obs;

  void createFamily() {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      // هنا بتنادي API لإنشاء العائلة
      familyCode.value = _generateCode();

      Get.offAllNamed(AppRoutes.FAMILY_CODE);
    });
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
      4,
      (i) =>
          chars[(DateTime.now().millisecondsSinceEpoch + i * 7) % chars.length],
    ).join();
  }

  @override
  void onClose() {
    familyNameController.dispose();
    familyDescriptionController.dispose();
    super.onClose();
  }
}
