import 'package:get/get.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class ActivitiesController extends GetxController {
  final selectedTab = 0.obs;

  final taskFilters = ['الكل', 'اليوم', 'قادمة', 'مرفوضة'];
  final purchaseFilters = ['الكل', 'طعام', 'تنظيف', 'فواتير', 'صحة', 'أخرى'];
  final selectedTaskFilter = 'الكل'.obs;
  final selectedPurchaseFilter = 'الكل'.obs;

  final tasksList = <Task>[].obs;
  final purchasesList = <Task>[].obs;

  final filteredTasksList = <Task>[].obs;
  final filteredPurchasesList = <Task>[].obs;

  final totalExpenses = 0.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  void changeTab(int index) => selectedTab.value = index;

  void changeTaskFilter(String filter) {
    selectedTaskFilter.value = filter;
    _applyTaskFilter();
  }

  void changePurchaseFilter(String filter) {
    selectedPurchaseFilter.value = filter;
    _applyPurchaseFilter();
  }

  // ==============================
  // ✅ فلترة المهام: الكل / مرفوضة (حالة) / اليوم / قادمة (تاريخ)
  // ==============================
  void _applyTaskFilter() {
    final filter = selectedTaskFilter.value;

    if (filter == 'الكل') {
      filteredTasksList.value = List.from(tasksList);
    } else if (filter == 'مرفوضة') {
      filteredTasksList.value = tasksList
          .where((t) => t.status == 'rejected')
          .toList();
    } else if (filter == 'اليوم') {
      filteredTasksList.value = tasksList
          .where((t) => _isToday(t.dueDate))
          .toList();
    } else if (filter == 'قادمة') {
      filteredTasksList.value = tasksList
          .where((t) => _isUpcoming(t.dueDate))
          .toList();
    } else {
      filteredTasksList.value = List.from(tasksList);
    }
  }

  void _applyPurchaseFilter() {
    if (selectedPurchaseFilter.value == 'الكل') {
      filteredPurchasesList.value = List.from(purchasesList);
    } else {
      filteredPurchasesList.value = purchasesList
          .where((p) => p.category == selectedPurchaseFilter.value)
          .toList();
    }
  }

  // ==============================
  // Helpers لمقارنة التواريخ (تنسيق yyyy-MM-dd)
  // ==============================
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

  void deleteTask(String id) {
    tasksList.removeWhere((t) => t.id == id);
    _applyTaskFilter();
  }

  void deletePurchase(String id) {
    purchasesList.removeWhere((p) => p.id == id);
    _applyPurchaseFilter();
    _updateTotalExpenses();
  }

  void _updateTotalExpenses() {
    totalExpenses.value = purchasesList.fold(0, (sum, p) => sum + p.points);
  }

  void addPurchase(Task purchase) {
    purchasesList.insert(0, purchase);
    purchasesList.refresh();
    _applyPurchaseFilter();
    _updateTotalExpenses();
  }

  void addTask(Task task) {
    tasksList.insert(0, task);
    tasksList.refresh();
    _applyTaskFilter();
  }

  void updateTask(Task updatedTask) {
    final index = tasksList.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      tasksList[index] = updatedTask;
      tasksList.refresh();
      _applyTaskFilter();
    }
  }

  void updatePurchase(Task updatedPurchase) {
    final index = purchasesList.indexWhere((p) => p.id == updatedPurchase.id);
    if (index != -1) {
      purchasesList[index] = updatedPurchase;
      purchasesList.refresh();
      _applyPurchaseFilter();
      _updateTotalExpenses();
    }
  }

  void _loadMockData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 300), () {
      final today = DateTime.now();
      String fmt(DateTime d) =>
          '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

      tasksList.value = [
        Task(
          id: '1',
          name: 'غسيل الملابس وترتيب الغرفة',
          assigneeName: 'سعيد',
          points: 50,
          status: 'completed',
          category: 'task',
          dueDate: fmt(today),
        ),
        Task(
          id: '2',
          name: 'تنظيف الحديقة',
          assigneeName: 'أحمد',
          points: 40,
          status: 'pending',
          category: 'task',
          dueDate: fmt(today),
        ),
        Task(
          id: '3',
          name: 'تنظيف غرفة الجلوس',
          assigneeName: 'نورة',
          points: 30,
          status: 'pending',
          category: 'task',
          dueDate: fmt(today.add(const Duration(days: 2))), // قادمة
        ),
        Task(
          id: '4',
          name: 'غسيل الملابس وترتيب الغرفة',
          assigneeName: 'سعيد',
          points: 50,
          status: 'rejected',
          category: 'task',
          dueDate: fmt(today),
        ),
      ];

      purchasesList.value = [
        Task(
          id: '5',
          name: 'خبز عربي',
          assigneeName: 'سعيد',
          points: 5,
          status: 'completed',
          category: 'طعام',
        ),
        Task(
          id: '6',
          name: 'قرى فراولة صغير',
          assigneeName: 'أحمد',
          points: 12,
          status: 'pending',
          category: 'طعام',
        ),
        Task(
          id: '7',
          name: 'حليب طازج × ٢ لتر',
          assigneeName: 'نورة',
          points: 8,
          status: 'pending',
          category: 'طعام',
        ),
        Task(
          id: '8',
          name: 'منظف الأرضيات',
          assigneeName: 'سعيد',
          points: 15,
          status: 'pending',
          category: 'تنظيف',
        ),
        Task(
          id: '9',
          name: 'سكر',
          assigneeName: 'فاطمة',
          points: 6,
          status: 'pending',
          category: 'طعام',
        ),
      ];

      filteredTasksList.value = List.from(tasksList);
      filteredPurchasesList.value = List.from(purchasesList);

      _updateTotalExpenses();
      isLoading.value = false;
    });
  }
}
