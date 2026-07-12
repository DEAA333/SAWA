import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: AppSizes.paddingL),

              // // الهيدر
              // Center(
              //   child: Text(
              //     'ملفي',
              //     style: AppTextStyles.splashSubtitle.copyWith(
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //       color: AppColors.textPrimary,
              //     ),
              //   ),
              // ),
              //
              // const SizedBox(height: AppSizes.paddingL),

              // الأفاتار + الاسم + الإيميل
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade50,
                      ),
                      child: const Icon(Icons.person, size: 50, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    Obx(() => Text(
                      controller.userName.value,
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    )),
                    const SizedBox(height: 4),
                    Obx(() => Text(
                      controller.userEmail.value,
                      style: AppTextStyles.splashSubtitle.copyWith(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    )),
                    const SizedBox(height: AppSizes.paddingM),
                    OutlinedButton(
                      onPressed: controller.goToEditProfile,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                      ),
                      child: Text(
                        'تعديل الملف الشخصي',
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 13,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              // الإعدادات
              Text(
                'الإعدادات',
                style: AppTextStyles.splashSubtitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  children: [
                    _buildNavItem(
                      icon: Icons.people_outline,
                      title: 'العائلة',
                      onTap: controller.goToFamily,
                    ),
                    _buildDivider(),
                    _buildNavItem(
                      icon: Icons.language_outlined,
                      title: 'اللغة',
                      trailing: Obx(() => Text(
                        controller.selectedLanguage.value,
                        style: AppTextStyles.splashSubtitle.copyWith(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      )),
                      onTap: controller.goToLanguage,
                    ),
                    _buildDivider(),
                    _buildToggleItem(
                      icon: Icons.notifications_outlined,
                      title: 'الإشعارات',
                      value: controller.notificationsEnabled,
                      onChanged: controller.toggleNotifications,
                    ),
                    _buildDivider(),
                    _buildToggleItem(
                      icon: Icons.wb_sunny_outlined,
                      title: 'الوضع الداكن',
                      value: controller.darkModeEnabled,
                      onChanged: controller.toggleDarkMode,
                    ),
                    _buildDivider(),
                    _buildNavItem(
                      icon: Icons.lock_outline,
                      title: 'كلمة المرور',
                      onTap: controller.goToChangePassword,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),

              // زر تسجيل الخروج
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.showLogoutDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'تسجيل الخروج',
                    style: AppTextStyles.splashSubtitle.copyWith(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (trailing != null) ...[trailing, const SizedBox(width: 8)],
          Text(
            title,
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      trailing: Icon(icon, color: Colors.grey.shade400, size: 20),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return ListTile(
      leading: Obx(() => Switch(
        value: value.value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      )),
      title: Text(
        title,
        textAlign: TextAlign.end,
        style: AppTextStyles.splashSubtitle.copyWith(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: Icon(icon, color: Colors.grey.shade400, size: 20),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey.shade100);
  }
}