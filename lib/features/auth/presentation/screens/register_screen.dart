import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/auth/presentation/controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingS),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 32),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'إنشاء حساب جديد',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height:8),
                          Text(
                            'انضم لعائلتك أو ابدأ عائلتك الخاصة على سوا',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width:16),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                _buildLabel('الاسم الكامل'),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.fullNameController,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'مثال: محمد المحمد',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: AppSizes.fontM,
                      color: Colors.grey.shade400,
                    ),

                    hintMaxLines: 1,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    // OutlineInputBorder
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.textPrimary),
                    ),
                    // OutlineInputBorder
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ), // BorderSide
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'الاسم مطلوب' : null,
                ),
                SizedBox(height: 32),
                _buildLabel('البريد الإلكتروني'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.center,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'name@email.com',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: AppSizes.fontM,
                      color: Colors.grey.shade400,
                    ),

                    hintMaxLines: 1,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    // OutlineInputBorder
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.textPrimary),
                    ),
                    // OutlineInputBorder
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ), // BorderSide
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.red.shade200,
                      ), // BorderSide
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.red.shade800,
                      ), // BorderSide
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'البريد مطلوب';
                    if (!v.contains('@')) return 'صيغة البريد غير صحيحة';
                    return null;
                  },
                ),
                SizedBox(height: 32),
                _buildLabel('كلمة المرور'),
                const SizedBox(height: 8),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    textDirection: TextDirection.rtl,

                    decoration: InputDecoration(
                      hintText: '٨ أحرف على الأقل',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: AppTextStyles.splashSubtitle.copyWith(
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: controller.togglePassword,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Colors.grey.shade400,
                      ),
                      hintMaxLines: 1,

                      fillColor: Colors.grey.shade200,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      // OutlineInputBorder
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.textPrimary),
                      ),
                      // OutlineInputBorder
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ), // BorderSide
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red.shade200,
                        ), // BorderSide
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red.shade800,
                        ), // BorderSide
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'كلمة المرور مطلوبة';
                      if (v.length < 8) return 'أقل ٨ أحرف';
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'استخدم مزيج من الأحرف والأرقام والرموز',
                    style: AppTextStyles.splashSubtitle.copyWith(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('تأكيد كلمة المرور'),
                const SizedBox(height: 8),
                Obx(
                      () => TextFormField(
                    controller: controller.confirmPasswordController,
                    obscureText: controller.isConfirmPasswordHidden.value,
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.center,
                    textDirection: TextDirection.rtl,

                    decoration: InputDecoration(
                      hintText: '٨ أحرف على الأقل',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: AppTextStyles.splashSubtitle.copyWith(
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: controller.toggleConfirmPassword,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: Colors.grey.shade400,
                      ),
                      hintMaxLines: 1,

                      fillColor: Colors.grey.shade200,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      // OutlineInputBorder
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.textPrimary),
                      ),
                      // OutlineInputBorder
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ), // BorderSide
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red.shade200,
                        ), // BorderSide
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.red.shade800,
                        ), // BorderSide
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'تأكيد كلمة المرور مطلوب';
                          if (v != controller.passwordController.text) {
                            return 'كلمة المرور غير متطابقة';
                          }
                          return null;
                        },

                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'استخدم مزيج من الأحرف والأرقام والرموز',
                    style: AppTextStyles.splashSubtitle.copyWith(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ),
                const SizedBox(height: 32),
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                      controller.isLoading.value ? null : controller.register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          :   Text(
                        'إنشاء الحساب',
                        style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 12, color: Colors.grey.shade500),
                      children: [
                        const TextSpan(text: 'بتسجيلك توافق على '),
                        TextSpan(
                          text: 'شروط الاستخدام وسياسة الخصوصية',
                          style: AppTextStyles.splashSubtitle.copyWith(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
