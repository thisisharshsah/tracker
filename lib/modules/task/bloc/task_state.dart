part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final bool isLoading;
  final Task? selectedTask;
  final String content;
  final int priority;
  final String dueDate;
  final String description;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.selectedTask,
    this.content = '',
    this.priority = 1,
    this.dueDate = '',
    this.description = '',
  });

  @override
  List<Object?> get props => [
        tasks,
        isLoading,
        selectedTask,
        content,
        priority,
        dueDate,
        description,
      ];

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    Task? selectedTask,
    String? content,
    int? priority,
    String? dueDate,
    String? description,
    Project? project,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      selectedTask: selectedTask ?? this.selectedTask,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
    );
  }

  @override
  bool get stringify => true;
}
