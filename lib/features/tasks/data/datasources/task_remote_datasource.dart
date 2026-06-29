import 'package:dio/dio.dart';
import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<Task>> getTasks();
  Future<Task> getTaskById(String id);
  Future<Task> addTask(Map<String, dynamic> data);
  Future<Task> updateTask(String id, Map<String, dynamic> data);
  Future<void> deleteTask(String id);
  Future<Task> updateTaskStatus(String id, Map<String, dynamic> data);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;
  TaskRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Task>> getTasks() async {
    // TODO (API): final response = await dio.get('/tasks');
    // return (response.data as List).map((e) => Task.fromJson(e)).toList();

    // Mock مؤقت
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  @override
  Future<Task> getTaskById(String id) async {
    // TODO (API): final response = await dio.get('/tasks/$id');
    // return Task.fromJson(response.data);
    throw UnimplementedError();
  }

  @override
  Future<Task> addTask(Map<String, dynamic> data) async {
    // TODO (API): final response = await dio.post('/tasks', data: data);
    // return Task.fromJson(response.data);

    // Mock مؤقت
    await Future.delayed(const Duration(milliseconds: 500));
    return Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: data['name'],
      description: data['description'] ?? '',
      assigneeId: data['assignee_id'] ?? '',
      assigneeName: data['assignee_name'] ?? '',
      assigneeAvatar: '',
      status: 'pending',
      priority: data['priority'] ?? 'medium',
      category: 'task',
      dueDate: data['due_date'] ?? '',
      dueTime: data['due_time'] ?? '',
      points: 0,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<Task> updateTask(String id, Map<String, dynamic> data) async {
    // TODO (API): final response = await dio.put('/tasks/$id', data: data);
    // return Task.fromJson(response.data);
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String id) async {
    // TODO (API): await dio.delete('/tasks/$id');
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<Task> updateTaskStatus(String id, Map<String, dynamic> data) async {
    // TODO (API): final response = await dio.patch('/tasks/$id/status', data: data);
    // return Task.fromJson(response.data);
    throw UnimplementedError();
  }
}