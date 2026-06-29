
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TaskEntity>> getTasks() async {
    final tasks = await remoteDataSource.getTasks();
    return tasks.map((task) => task.toEntity()).toList(); // ✅ تحويل List<Task> -> List<TaskEntity>
  }

  @override
  Future<TaskEntity> getTaskById(String id) async {
    final task = await remoteDataSource.getTaskById(id);
    return task.toEntity(); // ✅
  }

  @override
  Future<TaskEntity> addTask({
    required String name,
    required String description,
    required String assigneeId,
    required String priority,
    required String dueDate,
    required String dueTime,
  }) async {
    final task = await remoteDataSource.addTask({
      'name': name,
      'description': description,
      'assignee_id': assigneeId,
      'priority': priority,
      'due_date': dueDate,
      'due_time': dueTime,
    });
    return task.toEntity(); // ✅
  }

  @override
  Future<TaskEntity> updateTask(TaskEntity task) async {
    final updated = await remoteDataSource.updateTask(task.id, {
      'name': task.name,
      'description': task.description,
      'priority': task.priority,
      'due_date': task.dueDate,
      'due_time': task.dueTime,
    });
    return updated.toEntity(); // ✅
  }

  @override
  Future<void> deleteTask(String id) {
    return remoteDataSource.deleteTask(id);
  }

  @override
  Future<TaskEntity> updateTaskStatus({
    required String id,
    required String status,
    String? rejectionReason,
    String? completionNote,
  }) async {
    final task = await remoteDataSource.updateTaskStatus(id, {
      'status': status,
      'rejection_reason': rejectionReason,
      'completion_note': completionNote,
    });
    return task.toEntity(); // ✅
  }
}