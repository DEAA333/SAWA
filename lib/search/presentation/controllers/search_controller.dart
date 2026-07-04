import 'package:get/get.dart';
import 'package:sawa_app/features/activities/presentation/controllers/activities_controller.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class SearchPageController extends GetxController {
  late final ActivitiesController _activitiesController;

  final searchText = ''.obs;
  final selectedTab = 0.obs;
  final searchResults = <Task>[].obs;
  final isFilterApplied = false.obs;

  // فلاتر البوتوم شيت
  final statusFilters = ['الكل', 'اليوم', 'قائمة', 'مرفوضة'];
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
    searchResults.clear();
  }

  void _runSearch() {
    // لو ما في نص، اعرض كل المهام بدون فلترة نص
    final sourceList = selectedTab.value == 0
        ? _activitiesController.tasksList
        : _activitiesController.purchasesList;

    var results = sourceList.toList();

    // فلترة بالنص فقط لو في نص مكتوب
    if (searchText.value.trim().isNotEmpty) {
      results = results
          .where((item) => item.name.contains(searchText.value.trim()))
          .toList();
    }

    // فلتر الحالة
    if (selectedStatusFilter.value != 'الكل') {
      results = results
          .where((item) => item.status == selectedStatusFilter.value)
          .toList();
    }

    // فلتر الأولوية
    if (selectedPriorityFilter.value.isNotEmpty) {
      results = results
          .where((item) => item.priority == selectedPriorityFilter.value)
          .toList();
    }

    // فلتر الشخص المسؤول
    if (selectedAssigneeId.value.isNotEmpty) {
      results = results
          .where((item) => item.assigneeId == selectedAssigneeId.value)
          .toList();
    }

    searchResults.value = results;
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