part of 'task_bloc.dart';

enum TaskAction { add, update, view }

class TaskState extends Equatable {
  final List<Task> tasks;
  final bool isLoading;
  final Task? selectedTask;
  final String content;
  final int priority;
  final String dueDate;
  final String description;
  final Project project;
  final int duration;
  final TaskAction action;
  final bool isTaskRunning;

  const TaskState({
    this.tasks = const [],
    this.isLoading = true,
    this.selectedTask,
    this.content = '',
    this.priority = 1,
    this.dueDate = '',
    this.description = '',
    this.duration = 0,
    this.project = Project.empty,
    this.action = TaskAction.view,
    this.isTaskRunning = false,
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
        duration,
        project,
        action,
        isTaskRunning,
      ];

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    Task? selectedTask,
    String? content,
    int? priority,
    String? dueDate,
    String? description,
    int? duration,
    Project? project,
    TaskAction? action,
    bool? isTaskRunning,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      selectedTask: selectedTask ?? this.selectedTask,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      project: project ?? this.project,
      action: action ?? this.action,
      isTaskRunning: isTaskRunning ?? this.isTaskRunning,
    );
  }

  @override
  bool get stringify => true;
}
