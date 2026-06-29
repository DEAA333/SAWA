import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class UpdateTaskStatusUseCase {
  final TaskRepository repository;
  UpdateTaskStatusUseCase(this.repository);

  Future<TaskEntity> call({
    required String id,
    required String status,
    String? rejectionReason,
    String? completionNote,
  }) {
    return repository.updateTaskStatus(
      id: id,
      status: status,
      rejectionReason: rejectionReason,
      completionNote: completionNote,
    );
  }
}