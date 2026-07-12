import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  bool get has8Chars => newPass.text.length >= 8;
  bool get hasUpperAndLower =>
      newPass.text.contains(RegExp(r'[A-Z]')) &&
          newPass.text.contains(RegExp(r'[a-z]'));
  bool get hasNumber => newPass.text.contains(RegExp(r'[0-9]'));

  @override
  Widget build(BuildContext context) {
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
                  Text('كلمة المرور', style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: AppSizes.paddingL),

              _buildLabel('كلمة المرور الحالية'),
              const SizedBox(height: 8),
              _buildPasswordField(currentPass, _showCurrent,
                      () => setState(() => _showCurrent = !_showCurrent)),

              const SizedBox(height: AppSizes.paddingM),

              _buildLabel('كلمة المرور'),
              const SizedBox(height: 8),
              _buildPasswordField(newPass, _showNew,
                      () => setState(() => _showNew = !_showNew), onChanged: (_) => setState(() {})),

              const SizedBox(height: AppSizes.paddingM),

              _buildLabel('تأكيد كلمة المرور الجديدة'),
              const SizedBox(height: 8),
              _buildPasswordField(confirmPass, _showConfirm,
                      () => setState(() => _showConfirm = !_showConfirm)),

              const SizedBox(height: AppSizes.paddingM),

              // Password strength indicators
              _buildStrengthRow('٨ أحرف على الأقل', has8Chars),
              const SizedBox(height: 6),
              _buildStrengthRow('حرف كبير وحرف صغير', hasUpperAndLower),
              const SizedBox(height: 6),
              _buildStrengthRow('رقم ورمز خاص', hasNumber),

              const SizedBox(height: AppSizes.paddingXL),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (newPass.text != confirmPass.text) {
                      Get.snackbar('خطأ', 'كلمتا المرور غير متطابقتين');
                      return;
                    }
                    // TODO (API): await changePasswordUseCase(...)
                    Get.back();
                    Get.snackbar('تم', 'تم تغيير كلمة المرور بنجاح');
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

  Widget _buildPasswordField(TextEditingController ctrl, bool show,
      VoidCallback toggle, {Function(String)? onChanged}) {
    return TextField(
      controller: ctrl,
      obscureText: !show,
      textAlign: TextAlign.right,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          icon: Icon(show ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.grey.shade400, size: 20),
          onPressed: toggle,
        ),
        suffixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 20),
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

  Widget _buildStrengthRow(String text, bool satisfied) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(text, style: AppTextStyles.splashSubtitle.copyWith(
          fontSize: 12,
          color: satisfied ? Colors.green : AppColors.textSecondary,
        )),
        const SizedBox(width: 8),
        Icon(Icons.circle, size: 8,
            color: satisfied ? Colors.green : Colors.grey.shade300),
      ],
    );
  }

  @override
  void dispose() {
    currentPass.dispose();
    newPass.dispose();
    confirmPass.dispose();
    super.dispose();
  }
}