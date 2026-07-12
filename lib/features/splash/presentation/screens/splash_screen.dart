import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/constants/app_sizes.dart';
import 'package:sawa_app/core/constants/text_styles.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/core/storage/storage_service.dart';
import '../../../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _decideNextRoute);
  }

  void _decideNextRoute() {
    final storage = Get.find<StorageService>();

    if (storage.isLoggedIn) {
      // TODO (Phase 3): نتحقق GET /families/myFamily لنعرف نروح HOME ولا FAMILY_SETUP
      Get.offAllNamed(AppRoutes.HOME);
    } else if (!storage.hasSeenOnboarding) {
      Get.offAllNamed(AppRoutes.ONBOARDING);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              SvgPicture.asset('assets/icons/SAWA.svg', width: 140),
              const SizedBox(height: 4),
              Text(
                'عائلتك في مكان واحد',
                style: AppTextStyles.splashSubtitle.copyWith(
                  color: AppColors.textSplash,
                  fontSize: AppSizes.fontM,
                ),
              ),
              const Spacer(flex: 2),
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2.5),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}