import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class SearchPageController extends GetxController {
  late final ActivitiesController _activitiesController;

  final searchText = ''.obs;
  final selectedTab = 0.obs;
  final searchResults = <Task>[].obs;
  final isFilterApplied = false.obs;

  final statusFilters = ['الكل', 'اليوم', 'قادمة', 'مرفوضة']; // ✅ تصليح "قائمة" -> "قادمة"
  final priorityFilters = ['منخفضة', 'متوسطة', 'عالية'];

  final selectedStatusFilter = 'الكل'.obs;
  final selectedPriorityFilter = ''.obs;
  final selectedAssigneeId = ''.obs;

  final assignees = <Map<String, String>>[
    {'id': '1', 'name': 'عمر', 'avatar': '👨'},
    {'id': '2', 'name': 'ليان', 'avatar': '👧'},
    {'id': '3', 'name': 'أحمد', 'avatar': '👦'},
    {'id': '4', 'name': 'سارة', 'avatar': '👩'},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _activitiesController = Get.find<ActivitiesController>();
    _runSearch();
  }

  void changeTab(int index) {
    selectedTab.value = index;
    _runSearch();
  }

  void updateSearchText(String value) {
    searchText.value = value;
    _runSearch();
  }

  void clearSearch() {
    searchText.value = '';
    _runSearch();
  }

  void _runSearch() {
    final sourceList = selectedTab.value == 0
        ? _activitiesController.tasksList
        : _activitiesController.purchasesList;

    var results = sourceList.toList();

    if (searchText.value.trim().isNotEmpty) {
      results = results
          .where((item) => item.name.contains(searchText.value.trim()))
          .toList();
    }

    // ✅ فلتر الحالة/التاريخ بنفس منطق شاشة الأنشطة
    if (selectedStatusFilter.value != 'الكل') {
      if (selectedStatusFilter.value == 'مرفوضة') {
        results = results.where((item) => item.status == 'rejected').toList();
      } else if (selectedStatusFilter.value == 'اليوم') {
        results = results.where((item) => _isToday(item.dueDate)).toList();
      } else if (selectedStatusFilter.value == 'قادمة') {
        results = results.where((item) => _isUpcoming(item.dueDate)).toList();
      }
    }

    // ✅ فلتر الأولوية بعد تحويل التسمية العربية لكود داخلي
    if (selectedPriorityFilter.value.isNotEmpty) {
      final code = TaskPriority.fromArabic(selectedPriorityFilter.value);
      results = results.where((item) => item.priority == code).toList();
    }

    // ✅ فلتر الشخص المسؤول: بالـ id أو بالاسم احتياطياً (للبيانات القديمة)
    if (selectedAssigneeId.value.isNotEmpty) {
      final name = assignees.firstWhereOrNull(
            (m) => m['id'] == selectedAssigneeId.value,
      )?['name'];
      results = results
          .where((item) =>
      item.assigneeId == selectedAssigneeId.value ||
          (name != null && item.assigneeName == name))
          .toList();
    }

    searchResults.value = results;
  }

  bool _isToday(String dueDate) {
    if (dueDate.isEmpty) return false;
    final parsed = DateTime.tryParse(dueDate);
    if (parsed == null) return false;
    final now = DateTime.now();
    return parsed.year == now.year &&
        parsed.month == now.month &&
        parsed.day == now.day;
  }

  bool _isUpcoming(String dueDate) {
    if (dueDate.isEmpty) return false;
    final parsed = DateTime.tryParse(dueDate);
    if (parsed == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final parsedDay = DateTime(parsed.year, parsed.month, parsed.day);
    return parsedDay.isAfter(today);
  }

  void applyFilters({
    required String status,
    required String priority,
    required String assigneeId,
  }) {
    selectedStatusFilter.value = status;
    selectedPriorityFilter.value = priority;
    selectedAssigneeId.value = assigneeId;
    isFilterApplied.value =
        status != 'الكل' || priority.isNotEmpty || assigneeId.isNotEmpty;
    _runSearch();
  }

  void resetFilters() {
    selectedStatusFilter.value = 'الكل';
    selectedPriorityFilter.value = '';
    selectedAssigneeId.value = '';
    isFilterApplied.value = false;
    _runSearch();
  }

// TODO (API): استبدل البحث المحلي بـ SearchTasksUseCase مع query parameter

}