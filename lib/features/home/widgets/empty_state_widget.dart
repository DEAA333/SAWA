import 'package:flutter/material.dart';
import 'package:sawa_app/core/constants/app_colors.dart';
import 'package:sawa_app/core/constants/text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/noNotifications.png',
            fit: BoxFit.cover,
            width: 141,
          ),
          const SizedBox(height: 20),
          Text(
            'لا توجد إشعارات',
            style: AppTextStyles.splashSubtitle.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'قم بإنشاء نشاط جديد لتلقي آخر التحديثات',
            style: AppTextStyles.splashSubtitle.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              iconSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            ),
            child: Text(
              'إنشاء نشاط جديد',
              style: AppTextStyles.splashSubtitle.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
