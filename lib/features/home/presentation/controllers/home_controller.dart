import 'package:get/get.dart';
import 'package:sawa_app/core/routes/app_pages.dart';
import 'package:sawa_app/features/tasks/data/models/task_model.dart';

class HomeController extends GetxController {
  final currentTab = 0.obs;
  final userName = 'سعيد'.obs;
  final completionPercentage = 0.obs;
  final completedTasks = 0.obs;
  final totalTasks = 0.obs;
  final totalPoints = 0.obs;
  final notificationCount = 1.obs;

  // المهام
  final tasksList = <Task>[].obs;

  // الإحصائيات (محسوبة تلقائياً)

  @override
  void onInit() {
    super.onInit();
    loadTasks(); // تحميل المهام
  }

  void loadTasks() {
    // بيانات وهمية الآن - ستُستبدل بـ API لاحقاً
    tasksList.value = [
      Task(
        id: '1',
        name: 'غسيل الملابس وترتيب الغرفة',
        assigneeName: 'سعيد',
        points: 50,
        status: 'completed',
        category: 'task',
        // color: 'green',
      ),
      Task(
        id: '2',
        name: 'غسيل الملابس وترتيب الغرفة',
        assigneeName: 'سعيد',
        points: 50,
        status: 'pending',
        category: 'task',
        // color: 'orange',
      ),
      Task(
        id: '3',
        name: 'شراء الخضار من السوق',
        assigneeName: 'فاطمة',
        points: 30,
        status: 'completed',
        category: 'purchase',
        // color: 'green',
      ),
      Task(
        id: '4',
        name: 'تحضير العشاء',
        assigneeName: 'أم علي',
        points: 40,
        status: 'completed',
        category: 'task',
        // color: 'green',
      ),
    ];

    updateStatistics();
  }

  void updateStatistics() {
    // حساب الإحصائيات تلقائياً
    totalTasks.value = tasksList.length;
    completedTasks.value = tasksList
        .where((t) => t.status == 'completed')
        .length;
    totalPoints.value = tasksList.fold(0, (sum, task) => sum + task.points);

    // حساب النسبة المئوية
    if (totalTasks.value > 0) {
      completionPercentage.value =
          ((completedTasks.value / totalTasks.value) * 100).toInt();
    } else {
      completionPercentage.value = 0;
    }
  }

  // دالة لتحديث حالة المهمة (للمستقبل مع API)
  void updateTaskStatus(String taskId, String newStatus) {
    final taskIndex = tasksList.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      final updatedTask = tasksList[taskIndex];
      tasksList[taskIndex] = Task(
        id: updatedTask.id,
        name: updatedTask.name,
        assigneeName: updatedTask.assigneeName,
        points: updatedTask.points,
        status: newStatus,
        category: updatedTask.category,
        // color: updatedTask.color,
      );
      tasksList.refresh();
      updateStatistics();
    }
  }

  // دالة لإضافة مهمة جديدة (للمستقبل مع API)
  void addTask(Task task) {
    tasksList.add(task);
    updateStatistics();
  }

  void changeTab(int index) {
    currentTab.value = index;
  }
}
