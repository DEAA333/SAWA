// create_family_binding.dart
import 'package:get/get.dart';
import '../controllers/create_family_controller.dart';

class CreateFamilyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateFamilyController>(() => CreateFamilyController());
  }
}