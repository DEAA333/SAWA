// tasks/data/models/task_model.dart
import 'package:flutter/material.dart';
import '../../domain/entities/task_entity.dart';

class Task {
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

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      name: name,
      description: description,
      assigneeId: assigneeId,
      assigneeName: assigneeName,
      assigneeAvatar: assigneeAvatar,
      status: status,
      priority: priority,
      category: category,
      dueDate: dueDate,
      dueTime: dueTime,
      points: points,
      rejectionReason: rejectionReason,
      completionNote: completionNote,
      createdAt: createdAt,
    );
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
} // ⬅️ هون بينسكر الكلاس Task فعليًا

// ⬅️ الـ extension هون برا، مستقل تمامًا عن الكلاس
extension TaskStatusX on Task {
  String get statusLabel {
    switch (status) {
      case 'completed':
        return 'مكتملة';
      case 'accepted':
        return 'مقبولة';
      case 'rejected':
        return 'مرفوضة';
      case 'pending':
      default:
        return 'معلقة';
    }
  }

  Color get statusColor {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'accepted':
        return Colors.blue;
      case 'rejected':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  Color get statusBackgroundColor {
    switch (status) {
      case 'completed':
        return Colors.green.shade50;
      case 'accepted':
        return Colors.blue.shade50;
      case 'rejected':
        return Colors.red.shade50;
      case 'pending':
      default:
        return Colors.orange.shade50;
    }
  }
}