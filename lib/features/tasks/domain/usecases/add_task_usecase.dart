import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;
  AddTaskUseCase(this.repository);

  Future<TaskEntity> call({
    required String name,
    required String description,
    required String assigneeId,
    required String priority,
    required String dueDate,
    required String dueTime,
  }) {
    return repository.addTask(
      name: name,
      description: description,
      assigneeId: assigneeId,
      priority: priority,
      dueDate: dueDate,
      dueTime: dueTime,
    );
  }
}