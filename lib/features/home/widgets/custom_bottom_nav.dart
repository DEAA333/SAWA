import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/features/home/presentation/controllers/home_controller.dart';

class CustomBottomNav extends GetView<HomeController> {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textDirection: TextDirection.rtl,
          children: [
            navItem(0, Icons.home_outlined, 'الرئيسية'),
            navItem(1, Icons.pie_chart_outline, 'الإحصائيات'),
            navItem(2, Icons.track_changes_outlined, 'الأنشطة'),
            navItem(3, Icons.person_outline, 'ملفي'),
          ],
        ),
      ),
    );
  }

  Widget navItem(int index, IconData icon, String title) {
    final active = controller.currentTab.value == index;

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 0),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: active
                ? const Color(0xffE7ECFF)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active ? Colors.blue : Colors.grey,
            ),
             Text(
              title,
              style: AppTextStyles.splashSubtitle.copyWith(
                fontSize: 13,
                color: active ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}