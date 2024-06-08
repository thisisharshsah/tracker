part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskEvent {
  const TaskInitial();

  @override
  List<Object> get props => [];
}

class TaskClosed extends TaskEvent {
  const TaskClosed(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskEdit extends TaskEvent {
  const TaskEdit(this.task);

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

class FetchDuration extends TaskEvent {
  const FetchDuration(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskResumed extends TaskEvent {
  const TaskResumed(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskPaused extends TaskEvent {
  const TaskPaused(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

class TaskCreated extends TaskEvent {
  const TaskCreated();

  @override
  List<Object> get props => [];
}

class TaskUpdated extends TaskEvent {
  const TaskUpdated(
    this.task,
  );

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
