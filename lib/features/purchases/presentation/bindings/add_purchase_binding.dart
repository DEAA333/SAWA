import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import '../controllers/add_purchase_controller.dart';

class AddPurchaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPurchaseController>(() => AddPurchaseController());
    if (!Get.isRegistered<ActivitiesController>()) {
      Get.lazyPut<ActivitiesController>(
        () => ActivitiesController(),
        fenix: true,
      );
    }
  }
}
