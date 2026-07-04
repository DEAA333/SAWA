import 'package:get/get.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';
class ActivitiesController extends GetxController {
  // التاب الحالي: 0 = المهام، 1 = المشتريات
  final selectedTab = 0.obs;

  // الفلاتر الفرعية
  final taskFilters = ['الكل', 'اليوم', 'قادمة', 'مرفوضة'];
  final purchaseFilters = ['الكل', 'طعام', 'تنظيف', 'فواتير', 'صحة', 'أخرى'];
  final selectedTaskFilter = 'الكل'.obs;
  final selectedPurchaseFilter = 'الكل'.obs;

  // القوائم الأصلية
  final tasksList = <Task>[].obs;
  final purchasesList = <Task>[].obs;

  // القوائم المفلترة (هاي يلي بتستخدمها بالشاشة)
  final filteredTasksList = <Task>[].obs;
  final filteredPurchasesList = <Task>[].obs;

  // إجمالي المصاريف
  final totalExpenses = 0.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockData();
    // TODO (API): استبدل بـ fetchActivities()
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeTaskFilter(String filter) {
    selectedTaskFilter.value = filter;
    _applyTaskFilter();
  }

  void changePurchaseFilter(String filter) {
    selectedPurchaseFilter.value = filter;
    _applyPurchaseFilter();
  }

  void _applyTaskFilter() {
    if (selectedTaskFilter.value == 'الكل') {
      filteredTasksList.value = List.from(tasksList);
    } else {
      filteredTasksList.value = tasksList
          .where((t) => t.status == selectedTaskFilter.value)
          .toList();
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

  void deleteTask(String id) {
    tasksList.removeWhere((t) => t.id == id);
    _applyTaskFilter(); // ⬅️ حدّث القائمة المفلترة بعد الحذف
    // TODO (API): await tasksRepo.deleteTask(id);
  }

  void deletePurchase(String id) {
    purchasesList.removeWhere((p) => p.id == id);
    _applyPurchaseFilter(); // ⬅️ حدّث القائمة المفلترة بعد الحذف
    _updateTotalExpenses();
    // TODO (API): await purchasesRepo.deletePurchase(id);
  }

  void _updateTotalExpenses() {
    totalExpenses.value = purchasesList.fold(0, (sum, p) => sum + p.points);
  }

  void _loadMockData() {
    isLoading.value = true;

    Future.delayed(const Duration(milliseconds: 300), () {
      tasksList.value = [
        Task(id: '1', name: 'غسيل الملابس وترتيب الغرفة', assigneeName: 'سعيد', points: 50, status: 'completed', category: 'task', /*color: 'green'*/),
        Task(id: '2', name: 'تنظيف الحديقة', assigneeName: 'أحمد', points: 40, status: 'pending', category: 'task', /*color: 'orange'*/),
        Task(id: '3', name: 'تنظيف غرفة الجلوس', assigneeName: 'نورة', points: 30, status: 'pending', category: 'task', /*color: 'orange'*/),
        Task(id: '4', name: 'غسيل الملابس وترتيب الغرفة', assigneeName: 'سعيد', points: 50, status: 'pending', category: 'task', /*color: 'orange'*/),
      ];

      purchasesList.value = [
        Task(id: '5', name: 'خبز عربي', assigneeName: 'سعيد', points: 5, status: 'completed', category: 'طعام', /*color: 'green'*/),
        Task(id: '6', name: 'قرى فراولة صغير', assigneeName: 'أحمد', points: 12, status: 'pending', category: 'طعام', /*color: 'orange'*/),
        Task(id: '7', name: 'حليب طازج × ٢ لتر', assigneeName: 'نورة', points: 8, status: 'pending', category: 'طعام', /*color: 'orange'*/),
        Task(id: '8', name: 'منظف الأرضيات', assigneeName: 'سعيد', points: 15, status: 'pending', category: 'تنظيف', /*color: 'orange'*/),
        Task(id: '9', name: 'سكر', assigneeName: 'فاطمة', points: 6, status: 'pending', category: 'طعام', /*color: 'orange'*/),
      ];

      // ⬅️ هاد الجزء المهم — عبّي القوائم المفلترة بعد تحميل البيانات
      filteredTasksList.value = List.from(tasksList);
      filteredPurchasesList.value = List.from(purchasesList);

      _updateTotalExpenses();
      isLoading.value = false;
    });
  }
}