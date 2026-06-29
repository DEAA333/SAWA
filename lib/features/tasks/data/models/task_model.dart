// tasks/data/models/task_model.dart

class Task {
  final String id;
  final String name;
  final String description;
  final String assigneeId;
  final String assigneeName;
  final String assigneeAvatar;
  final String status;       // pending, completed, rejected
  final String priority;     // high, medium, low
  final String category;     // task, purchase
  final String dueDate;
  final String dueTime;
  final int points;
  final String? rejectionReason;
  final String? completionNote;
  final String createdAt;

  Task({
    required this.id,
    required this.name,
    this.description = '',
    this.assigneeId = '',
    this.assigneeName = '',
    this.assigneeAvatar = '',
    required this.status,
    this.priority = 'medium',
    required this.category,
    this.dueDate = '',
    this.dueTime = '',
    required this.points,
    this.rejectionReason,
    this.completionNote,
    this.createdAt = '',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      assigneeId: json['assignee_id']?.toString() ?? '',
      assigneeName: json['assignee_name'] ?? '',
      assigneeAvatar: json['assignee_avatar'] ?? '',
      status: json['status'] ?? 'pending',
      priority: json['priority'] ?? 'medium',
      category: json['category'] ?? 'task',
      dueDate: json['due_date'] ?? '',
      dueTime: json['due_time'] ?? '',
      points: json['points'] ?? 0,
      rejectionReason: json['rejection_reason'],
      completionNote: json['completion_note'],
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'assignee_id': assigneeId,
      'assignee_name': assigneeName,
      'assignee_avatar': assigneeAvatar,
      'status': status,
      'priority': priority,
      'category': category,
      'due_date': dueDate,
      'due_time': dueTime,
      'points': points,
      'rejection_reason': rejectionReason,
      'completion_note': completionNote,
      'created_at': createdAt,
    };
  }

  Task copyWith({
    String? id,
    String? name,
    String? description,
    String? assigneeId,
    String? assigneeName,
    String? assigneeAvatar,
    String? status,
    String? priority,
    String? category,
    String? dueDate,
    String? dueTime,
    int? points,
    String? rejectionReason,
    String? completionNote,
    String? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      assigneeId: assigneeId ?? this.assigneeId,
      assigneeName: assigneeName ?? this.assigneeName,
      assigneeAvatar: assigneeAvatar ?? this.assigneeAvatar,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      dueTime: dueTime ?? this.dueTime,
      points: points ?? this.points,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      completionNote: completionNote ?? this.completionNote,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}