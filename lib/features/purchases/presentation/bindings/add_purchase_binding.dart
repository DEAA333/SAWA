import 'package:get/get.dart';
import '../controllers/add_purchase_controller.dart';

class AddPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPurchaseController>(() => AddPurchaseController());
  }
}