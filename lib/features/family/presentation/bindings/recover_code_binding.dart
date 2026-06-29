import 'package:get/get.dart';
import '../controllers/recover_code_controller.dart';

class RecoverCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoverCodeController>(() => RecoverCodeController());
  }
}