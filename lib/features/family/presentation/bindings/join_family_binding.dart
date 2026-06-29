import 'package:get/get.dart';
import '../controllers/join_family_controller.dart';

class JoinFamilyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinFamilyController>(() => JoinFamilyController());
  }
}