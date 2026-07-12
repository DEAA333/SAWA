 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/screens/activities_screen.dart';
import 'package:sawa_app/features/home/presentation/controllers/home_controller.dart';
import 'package:sawa_app/features/home/presentation/screens/home_body.dart';
import 'package:sawa_app/features/home/widgets/custom_bottom_nav.dart';
import 'package:sawa_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:sawa_app/features/statistics/presentation/screens/statistics_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  // الشاشات الأربعة
  final List<Widget> _screens = const [
      HomeBody(),
      StatisticsScreen(),
      ActivitiesScreen(),
    ProfileScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
            () => IndexedStack(
          index: controller.currentTab.value,
          children: _screens,
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}