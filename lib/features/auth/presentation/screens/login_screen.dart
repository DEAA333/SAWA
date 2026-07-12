import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/auth/presentation/controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'مرحباً بعودتك',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: AppSizes.fontXXXL,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'سجّل دخولك لإدارة مهام العائلة',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: AppSizes.fontL,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'البريد الإلكتروني',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: AppSizes.fontL,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'name@email.com',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade400,
                    ),
                    hintStyle: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: AppSizes.fontM,
                      color: Colors.grey.shade400,
                    ),
                    hintMaxLines: 1,
                    hintTextDirection: TextDirection.rtl,
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
                    contentPadding: EdgeInsets.zero,
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
                    // errorText: controller.emailError,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'البريد الإلكتروني مطلوب';
                    }
                    if (!value.contains('@')) {
                      return 'صيغة البريد غير صحيحة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                Text(
                  'كلمة المرور',
                  style: AppTextStyles.splashSubtitle.copyWith(
                    fontSize: AppSizes.fontL,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    keyboardType: TextInputType.number,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.grey.shade400,
                      ),
                      suffixIcon: IconButton(
                        onPressed: controller.togglePasswordVisibility,
                        icon: controller.isPasswordHidden.value
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined),
                        color: Colors.grey.shade400,
                      ),
                      hintStyle: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: AppSizes.fontXXXL,
                        color: Colors.grey.shade400,
                      ),
                      hintMaxLines: 1,
                      hintTextDirection: TextDirection.rtl,
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
                      contentPadding: EdgeInsets.zero,
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
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'كلمة المرور مطلوبة';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.goToForgotPassword,
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: AppSizes.fontS,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'تسجيل الدخول',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: AppSizes.fontM,
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'أو تابع باستخدام',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade400)),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: OutlinedButton.icon(
                          onPressed: controller.loginWithGoogle,
                          icon: const Icon(
                            Icons.g_mobiledata,
                            size: 30,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Google',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: AppSizes.fontM,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingM),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: OutlinedButton.icon(
                          onPressed: controller.loginWithApple,
                          icon: const Icon(
                            Icons.apple,
                            size: 30,
                            color: Colors.black,
                          ),
                          label: Text(
                            'Apple',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: AppSizes.fontM,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: AppSizes.fontS,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: controller.goToRegister,
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          minimumSize: WidgetStatePropertyAll(Size.zero),
                        ),
                        child: Text(
                          'سجّل الآن',
                          style: AppTextStyles.splashSubtitle.copyWith(
                            fontSize: AppSizes.fontS,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
