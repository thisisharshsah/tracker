import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoist/todoist.dart';
import 'package:intl/intl.dart';

import '../../../global/global.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required Todoist todoist, required Project project})
      : _todoist = todoist,
        _project = project,
        super(const TaskState()) {
    on<TaskInitial>(_onTaskInitial);
    on<TaskContentChanged>(_onTaskContentChanged);
    on<TaskPriorityChanged>(_onTaskPriorityChanged);
    on<TaskDueDateChanged>(_onTaskDueDateChanged);
    on<TaskDescriptionChanged>(_onTaskDescriptionChanged);
    on<TaskClosed>(_onTaskClosed);
    on<TaskEdit>(_onTaskEdit);
    on<FetchDuration>(_onFetchDuration);
    on<TaskResumed>(_onTaskResumed);
    on<TaskPaused>(_onTaskPaused);
    on<TaskCreated>(_onTaskCreate);
    on<TaskUpdated>(_onTaskUpdate);
    on<TaskDeleted>(_onTaskDelete);
  }

  final Todoist _todoist;
  final Project _project;

  void _onTaskInitial(TaskInitial event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true, project: _project));
    await _todoist.getTaskByProjectID(projectId: _project.id).then((response) {
      emit(state.copyWith(tasks: []));
      emit(state.copyWith(tasks: response.tasks));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }

  void _onTaskClosed(TaskClosed event, Emitter<TaskState> emit) async {
    await _todoist.closeTask(id: event.task.id).then((response) {
      emit(state.copyWith(isLoading: true));
      final tasks = state.tasks;
      tasks.removeWhere((element) => element.id == event.task.id);
      emit(state.copyWith(tasks: tasks, isLoading: false));
    });
  }

  void _onTaskEdit(TaskEdit event, Emitter<TaskState> emit) {
    emit(state.copyWith(
      action: TaskAction.update,
      content: event.task.content,
      description: event.task.description,
      dueDate: event.task.due!.date,
      priority: event.task.priority,
    ));
  }

  void _onTaskContentChanged(
    TaskContentChanged event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(content: event.content));
  }

  void _onTaskPriorityChanged(
    TaskPriorityChanged event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(priority: event.priority));
  }

  void _onTaskDueDateChanged(
    TaskDueDateChanged event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(dueDate: event.dueDate.toString()));
  }

  void _onTaskDescriptionChanged(
    TaskDescriptionChanged event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onFetchDuration(FetchDuration event, Emitter<TaskState> emit) async {
    if (event.task.duration != null) {
      emit(state.copyWith(duration: event.task.duration!.amount * 60));
    } else {
      emit(state.copyWith(duration: 0));
    }
  }

  void _onTaskResumed(TaskResumed event, Emitter<TaskState> emit) async {
    await _todoist.getTask(id: event.task.id).then((response) {
      if (response.task.duration != null) {
        emit(state.copyWith(duration: response.task.duration!.amount * 60));
      } else {
        emit(state.copyWith(duration: 0));
      }
    }).whenComplete(() async {
      emit(state.copyWith(isTaskRunning: true));
      while (state.isTaskRunning) {
        await Future.delayed(const Duration(seconds: 1)).then((_) {
          emit(state.copyWith(duration: state.duration + 1));
        });
      }
    });
  }

  void _onTaskPaused(TaskPaused event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isTaskRunning: false));
    await _todoist.updateTask(
      id: event.task.id,
      duration: (state.duration / 60).floor().toString(),
    );
  }

  void _onTaskCreate(TaskCreated event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _todoist
        .createTask(
            content: state.content,
            description: state.description,
            dueDate: state.dueDate != ''
                ? DateFormat('yyyy-MM-dd').format(DateTime.parse(state.dueDate))
                : null,
            dueString: state.dueDate != ''
                ? DateFormat('d MMM').format(DateTime.parse(state.dueDate))
                : null,
            priority: state.priority.toString(),
            projectId: _project.id)
        .then((response) {
      emit(state.copyWith(isLoading: false));
      SnackBarService.showSnackBar(content: 'Task created');
    }).catchError((error) {
      ResponseHandler.handleResponse(response: error);
    });
  }

  void _onTaskUpdate(TaskUpdated event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _todoist
        .updateTask(
            id: event.task.id,
            content: state.content,
            description: state.description,
            dueDate: state.dueDate != ''
                ? DateFormat('yyyy-MM-dd').format(DateTime.parse(state.dueDate))
                : null,
            dueString: state.dueDate != ''
                ? DateFormat('d MMM').format(DateTime.parse(state.dueDate))
                : null,
            priority: state.priority.toString())
        .then((response) {
      emit(state.copyWith(isLoading: false));
      SnackBarService.showSnackBar(content: 'Task updated');
    }).catchError((error) {
      ResponseHandler.handleResponse(response: error);
    });
  }

  void _onTaskDelete(TaskDeleted event, Emitter<TaskState> emit) async {
    await _todoist.deleteTask(id: event.task.id);
  }
}
