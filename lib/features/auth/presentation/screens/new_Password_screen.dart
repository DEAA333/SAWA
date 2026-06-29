import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/auth/presentation/controllers/new_Password_conroller.dart';

class NewPasswordScreen extends GetView<NewPasswordController> {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:   EdgeInsets.only(top: 32,left: 16,right: 16,bottom: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'كلمة مرور جديدة',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'اختر كلمة مرور قوية لحماية حسابك',
                            style: AppTextStyles.splashSubtitle.copyWith(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
                _buildLabel('كلمة المرور'),
                const SizedBox(height: 8),
                Obx(
                      () => TextFormField(
                    controller: controller.newPasswordController,
                        onChanged: controller.onPasswordChanged,
                        obscureText: controller.isNewPasswordHidden.value,
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
                          controller.isNewPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: controller.toggleNewPasswordVisibility,
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
            
                const SizedBox(height: 32),
                _buildLabel('تأكيد كلمة المرور'),
                const SizedBox(height: 8),
                Obx(
                      () => TextFormField(
                    controller: controller.confirmNewPasswordController,
                    obscureText: controller.isConfirmNewPasswordHidden.value,
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
                          controller.isConfirmNewPasswordHidden.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: controller.toggleConfirmNewPasswordVisibility,
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
                      if (v != controller.newPasswordController.text) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    },
            
                  ),
                ),
                const SizedBox(height: 16),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Obx(
                        () => Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildCondition('٨ أحرف على الأقل', controller.hasMinLength.value),
                        const SizedBox(height: 8),
                        _buildCondition('حرف كبير وحرف صغير', controller.hasUpperAndLower.value),
                        const SizedBox(height: 8),
                        _buildCondition('رقم ورمز خاص', controller.hasNumberAndSymbol.value),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed:
                      controller.isLoading.value ? null : controller.changePassWord,
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
                        'تغيير كلمة المرور',
                        style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white),
                      ),
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

  Widget _buildCondition(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 13,
              color: isMet ? Colors.green : Colors.grey,
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}
