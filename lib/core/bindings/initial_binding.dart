import 'package:get/get.dart';
import 'package:sawa_app/core/network/api_client.dart';
import 'package:sawa_app/core/storage/storage_service.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/auth/data/datasources/auth_remote_datasource.dart';
 import 'package:sawa_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:sawa_app/features/auth/repositories/auth_repository_impl.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<ApiClient>(ApiClient(), permanent: true);

    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSource(Get.find<ApiClient>(), Get.find<StorageService>()),
      permanent: true,
    );
    Get.put<AuthRepository>(
      AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
      permanent: true,
    );

    Get.lazyPut<ActivitiesController>(() => ActivitiesController(), fenix: true);
  }
}