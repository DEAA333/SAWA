import 'package:get/get.dart';
import 'package:sawa_app/features/auth/presentation/controllers/new_Password_conroller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordController>(() => NewPasswordController());
  }
}