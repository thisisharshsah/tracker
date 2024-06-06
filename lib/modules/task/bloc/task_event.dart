part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskEvent {
  const TaskInitial(this.project);

  final Project project;

  @override
  List<Object> get props => [project];
}

class TaskSelected extends TaskEvent {
  const TaskSelected(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskContentChanged extends TaskEvent {
  const TaskContentChanged(this.content);

  final String content;

  @override
  List<Object> get props => [content];
}

class TaskPriorityChanged extends TaskEvent {
  const TaskPriorityChanged(this.priority);

  final int priority;

  @override
  List<Object> get props => [priority];
}

class TaskDueDateChanged extends TaskEvent {
  const TaskDueDateChanged(this.dueDate);

  final DateTime dueDate;

  @override
  List<Object> get props => [dueDate];
}

class TaskDescriptionChanged extends TaskEvent {
  const TaskDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class TaskCreated extends TaskEvent {
  const TaskCreated({
    required this.content,
    required this.description,
    required this.due,
    required this.priority,
    required this.projectId,
  });

  final String content;
  final String description;
  final DateTime due;
  final int priority;
  final String projectId;
}

class TaskUpdated extends TaskEvent {
  const TaskUpdated(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskDeleted extends TaskEvent {
  const TaskDeleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}
