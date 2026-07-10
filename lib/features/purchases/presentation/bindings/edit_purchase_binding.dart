import 'package:get/get.dart';
import '../controllers/edit_purchase_controller.dart';

class EditPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPurchaseController>(() => EditPurchaseController());
  }
}