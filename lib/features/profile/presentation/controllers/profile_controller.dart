import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class ProfileController extends GetxController {
  final userName = 'سعيد محمد'.obs;
  final userEmail = 's2026@gmail.com'.obs;
  final notificationsEnabled = true.obs;
  final darkModeEnabled = false.obs;
  final selectedLanguage = 'العربية'.obs;

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
    // TODO (API): await updateSettingsUseCase(notifications: value)
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
    // TODO: Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light)
  }

  void goToEditProfile() => Get.toNamed(AppRoutes.EDIT_PROFILE);
  void goToFamily() => Get.toNamed(AppRoutes.PROFILE_FAMILY);
  void goToLanguage() => Get.toNamed(AppRoutes.LANGUAGE);
  void goToChangePassword() => Get.toNamed(AppRoutes.CHANGE_PASSWORD);

  void showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.info_outline, color: Colors.white, size: 28),
              ),
              const SizedBox(height: 16),
              const Text(
                'تسجيل الخروج؟',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'هل أنت متأكد من تسجيل الخروج؟',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('إلغاء', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    // TODO (API): await authRepo.logout()
                    Get.offAllNamed(AppRoutes.LOGIN);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}