class TaskEntity {
  final String id;
  final String name;
  final String description;
  final String assigneeId;
  final String assigneeName;
  final String assigneeAvatar;
  final String status;
  final String priority;
  final String category;
  final String dueDate;
  final String dueTime;
  final int points;
  final String? rejectionReason;
  final String? completionNote;
  final String createdAt;

  const TaskEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.assigneeId,
    required this.assigneeName,
    required this.assigneeAvatar,
    required this.status,
    required this.priority,
    required this.category,
    required this.dueDate,
    required this.dueTime,
    required this.points,
    this.rejectionReason,
    this.completionNote,
    required this.createdAt,
  });
}