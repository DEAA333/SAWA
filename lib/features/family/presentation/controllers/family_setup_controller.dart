import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';

class FamilySetupController extends GetxController {
  void createFamily() {
    Get.toNamed(AppRoutes.CREATE_FAMILY);
  }

  void joinFamily() {
    Get.toNamed(AppRoutes.JOIN_FAMILY);
  }
}