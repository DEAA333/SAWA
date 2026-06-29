import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/features/onboarding/presentation/models/onboarding_item.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingItem> items = const [
    OnboardingItem(
      image: 'assets/images/onBoarding1.png',
      title: 'نظّموا مهام العائلة معاً',
      description:
          'وزّعوا المهام اليومية على أفراد العائلة بكل سهولة، وتابعوا إنجازها بلحظة.',
    ),
    OnboardingItem(
      image: 'assets/images/onBoarding2.png',
      title: 'قوائم تسوّق ومصاريف ذكية',
      description:
          'أضيفوا المشتريات، سجّلوا التكاليف، واحصلوا على رؤية واضحة لإنفاق العائلة كل شهر.',
    ),
    OnboardingItem(
      image: 'assets/images/onBoarding3.png',
      title: 'ستريك يومي ومكافآت',
      description:
          'حافظوا على عاداتكم اليومية، اجمعوا النقاط، واحتفلوا بإنجازاتكم معاً.',
    ),
  ];

  bool get isLastPage => currentPage.value == items.length -1;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (isLastPage) {
      goToLogin();
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    goToLogin();
  }

  void goToLogin() {
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
