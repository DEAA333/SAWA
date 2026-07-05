// core/bindings/initial_binding.dart
import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivitiesController>(
          () => ActivitiesController(),
      fenix: true,
    );
  }
}