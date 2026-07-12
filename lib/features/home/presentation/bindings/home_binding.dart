import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/profile/presentation/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';
import 'package:sawa_app/features/statistics/presentation/controllers/statistics_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<StatisticsController>(
      () => StatisticsController(),
      fenix: true,
    );
    Get.lazyPut<ActivitiesController>(
      () => ActivitiesController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
