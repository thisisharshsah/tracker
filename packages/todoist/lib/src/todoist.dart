import 'dart:convert';

import 'package:api/api.dart';
import 'package:cache/cache.dart';

import '../todoist.dart';

class Todoist {
  final _api = Api();
  final _cache = Cache();

  Future<ProjectResponse> getProjects() async {
    final token = await _cache.readToken();
    final response = await _api.getWithAuth('/projects', token!);
    return ProjectResponse.fromJson(jsonDecode(response.body));
  }

  Future<void> getProject({required int id}) async {
    final token = await _cache.readToken();
    await _api.getWithAuth('/projects/$id', token!).then((response) {
      return response;
    });
  }

  Future createProject({
    required String name,
  }) async {
    final token = await _cache.readToken();
    return await _api.postWithAuth(
      '/projects',
      body: {'name': name},
      token: token!,
    );
  }

  Future<void> updateProject({
    required int id,
    String? name,
    bool? isFavorite,
  }) async {
    final token = await _cache.readToken();
    await _api
        .postWithAuth('/projects/$id',
            body: {
              if (name != null) 'name': name,
              if (isFavorite != null) 'is_favorite': isFavorite,
            },
            token: token!)
        .then((response) {
      return response;
    });
  }

  Future<void> deleteProject({required int id}) async {
    final token = await _cache.readToken();
    await _api.deleteWithAuth('/projects/$id', token: token!).then((response) {
      return response;
    });
  }

  Future<void> getAllCollaborators({required int id}) async {
    final token = await _cache.readToken();
    await _api
        .getWithAuth('/projects/$id/collaborators', token!)
        .then((response) {
      return response;
    });
  }

  Future<TaskResponse> getTasks() async {
    final token = await _cache.readToken();
    final response = await _api.getWithAuth('/tasks', token!);
    return TaskResponse.fromJson(jsonDecode(response.body));
  }

  Future<TaskResponse> getTask({required String id}) async {
    final token = await _cache.readToken();
    final response = await _api.getWithAuth('/tasks?project_id=$id', token!);
    return TaskResponse.fromJson(jsonDecode(response.body));
  }

  Future<void> createTask({
    required String content,
    required String projectId,
    String? description,
    int? priority,
    String? dueDate,
    String? dueString,
  }) async {
    final token = await _cache.readToken();
    await _api
        .postWithAuth('/tasks?project_id=$projectId',
            body: {
              'content': content,
              if (description != null) 'description': description,
              if (priority != null) 'priority': priority,
              if (dueDate != null) 'due_date': dueDate,
              if (dueString != null) 'due_string': dueString,
            },
            token: token!)
        .then((response) {
      return response;
    });
  }

  Future<void> updateTask({
    required String id,
    String? content,
    String? description,
    bool? isCompleted,
    List<String>? labels,
    String? parentId,
    int? order,
    int? priority,
    String? dueDate,
    String? dueString,
    String? url,
    int? commentCount,
    String? createdAt,
    String? creatorId,
    String? assigneeId,
    String? assignerId,
    String? duration,
  }) async {
    final token = await _cache.readToken();
    await _api
        .postWithAuth('/tasks/$id',
            body: {
              if (content != null) 'content': content,
              if (description != null) 'description': description,
              if (isCompleted != null) 'is_completed': isCompleted,
              if (labels != null) 'labels': labels,
              if (parentId != null) 'parent_id': parentId,
              if (order != null) 'order': order,
              if (priority != null) 'priority': priority,
              if (dueDate != null) 'due_date': dueDate,
              if (dueString != null) 'due_string': dueString,
              if (commentCount != null) 'comment_count': commentCount,
              if (createdAt != null) 'created_at': createdAt,
              if (creatorId != null) 'creator_id': creatorId,
              if (assigneeId != null) 'assignee_id': assigneeId,
              if (assignerId != null) 'assigner_id': assignerId,
              if (duration != null) 'duration': duration,
            },
            token: token!)
        .then((response) {
      return response;
    });
  }

  Future<void> closeTask({required int id}) async {
    final token = await _cache.readToken();
    await _api.postWithAuth('/tasks/$id/close', token: token!).then((response) {
      return response;
    });
  }

  Future<void> reopenTask({required int id}) async {
    final token = await _cache.readToken();
    await _api
        .postWithAuth('/tasks/$id/reopen', token: token!)
        .then((response) {
      return response;
    });
  }

  Future<void> deleteTask({required String id}) async {
    final token = await _cache.readToken();
    await _api.deleteWithAuth('/tasks/$id', token: token!).then((response) {
      return response;
    });
  }

  Future<void> getComments({int? taskId, int? projectId}) async {
    final token = await _cache.readToken();
    final url = taskId != null
        ? '/comments?task_id=$taskId'
        : projectId != null
            ? '/comments?project_id=$projectId'
            : '/comments';
    await _api.getWithAuth(url, token!).then((response) {
      return response;
    });
  }

  Future<void> createComment({
    required String content,
    String? taskId,
    String? projectId,
  }) async {
    final token = await _cache.readToken();
    await _api
        .postWithAuth('/comments',
            body: {
              if (taskId != null) 'task_id': taskId,
              if (projectId != null) 'project_id': projectId,
              'content': content,
            },
            token: token!)
        .then((response) {
      return response;
    });
  }

  Future<void> getComment({required int id}) async {
    final token = await _cache.readToken();
    await _api.getWithAuth('/comments/$id', token!).then((response) {
      return response;
    });
  }

  Future<void> updateComment({
    required int id,
    String? content,
    String? taskId,
    String? projectId,
  }) async {
    final token = await _cache.readToken();
    await _api
        .postWithAuth('/comments/$id',
            body: {
              if (content != null) 'content': content,
              if (taskId != null) 'task_id': taskId,
              if (projectId != null) 'project_id': projectId,
            },
            token: token!)
        .then((response) {
      return response;
    });
  }

  Future<void> deleteComment({required int id}) async {
    final token = await _cache.readToken();
    await _api.deleteWithAuth('/comments/$id', token: token!).then((response) {
      return response;
    });
  }
}
