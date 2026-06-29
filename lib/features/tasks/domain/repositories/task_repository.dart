import '../entities/task_entity.dart';

abstract class TaskRepository {
  // جلب كل المهام
  Future<List<TaskEntity>> getTasks();

  // جلب مهمة واحدة
  Future<TaskEntity> getTaskById(String id);

  // إضافة مهمة
  Future<TaskEntity> addTask({
    required String name,
    required String description,
    required String assigneeId,
    required String priority,
    required String dueDate,
    required String dueTime,
  });

  // تحديث مهمة
  Future<TaskEntity> updateTask(TaskEntity task);

  // حذف مهمة
  Future<void> deleteTask(String id);

  // تغيير حالة المهمة
  Future<TaskEntity> updateTaskStatus({
    required String id,
    required String status,
    String? rejectionReason,
    String? completionNote,
  });
}