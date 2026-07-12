import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: controller.userName.value);
    final emailController = TextEditingController(text: controller.userEmail.value);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_forward),
                    style: IconButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  ),
                  Text(
                    'تعديل الملف الشخصي',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),

              const SizedBox(height: AppSizes.paddingL),

              // الأفاتار
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade50),
                      child: const Icon(Icons.person, size: 55, color: Colors.blueGrey),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.edit, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              _buildLabel('الاسم'),
              const SizedBox(height: 8),
              _buildField(nameController, 'أدخل الاسم', Icons.person_outline),

              const SizedBox(height: AppSizes.paddingM),

              _buildLabel('البريد الإلكتروني'),
              const SizedBox(height: 8),
              _buildField(emailController, 'أدخل البريد الإلكتروني', Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress),

              const SizedBox(height: AppSizes.paddingXL),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    controller.userName.value = nameController.text;
                    controller.userEmail.value = emailController.text;
                    // TODO (API): await updateProfileUseCase(...)
                    Get.back();
                    Get.snackbar('تم', 'تم حفظ التعديلات بنجاح');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('حفظ التعديلات',
                      style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white, fontSize: 15)),
                ),
              ),
              const SizedBox(height: AppSizes.paddingL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Align(
    alignment: Alignment.centerRight,
    child: Text(text, style: AppTextStyles.splashSubtitle.copyWith(
        fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
  );

  Widget _buildField(TextEditingController ctrl, String hint, IconData icon,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        suffixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
        fillColor: Colors.grey.shade50,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        contentPadding: const EdgeInsets.all(14),
      ),
    );
  }
}