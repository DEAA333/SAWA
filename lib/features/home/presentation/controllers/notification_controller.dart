import 'package:get/get.dart';
import 'package:sawa_app/features/home/models/notification_model.dart';

class NotificationController extends GetxController {
  final isLoading = false.obs;

  final notifications = <NotificationModel>[].obs;
  final filteredNotifications = <NotificationModel>[].obs;

  final selectedFilter = 'الكل'.obs;

  final filters = [
    'الكل',
    'مقروءة',
    'غير مقروءة',
    'الأحدث',
    'الأقدم',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;

    await Future.delayed(Duration(seconds: 1));

    /// لاحقاً تستبدله بـ API
    notifications.value = [
      NotificationModel(
        id: 1,
        title: 'مهمة جديدة تم تعيينها لك',
        body: 'تنظيف المطبخ بعد العشاء',
        type: 'task',
        createdAt: DateTime.now().subtract(Duration(minutes: 5)),
        isRead: false,

      ),
      NotificationModel(
        id: 2,
        title: 'تم قبول طلبك',
        body: 'تم قبول النشاط',
        type: 'approval',
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        isRead: true,
      ),
    ];
    // notifications.value = response
    //     .map((e) => NotificationModel.fromJson(e))
    //     .toList();
    applyFilter();
    isLoading.value = false;
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

  void applyFilter() {
    List<NotificationModel> temp = List.from(notifications);

    switch (selectedFilter.value) {
      case 'مقروءة':
        temp = temp.where((e) => e.isRead).toList();
        break;

      case 'غير مقروءة':
        temp = temp.where((e) => !e.isRead).toList();
        break;

      case 'الأحدث':
        temp.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;

      case 'الأقدم':
        temp.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;

      case 'الكل':
      default:
        break;
    }

    filteredNotifications.value = temp;
  }

  void deleteNotification(int id) {
    notifications.removeWhere((e) => e.id == id);
    applyFilter();
  }
}