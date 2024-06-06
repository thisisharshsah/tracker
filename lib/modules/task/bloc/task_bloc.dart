import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoist/todoist.dart';
import 'package:intl/intl.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(Todoist todoist)
      : _todoist = todoist,
        super(const TaskState()) {
    on<TaskInitial>(_onTaskInitial);
    on<TaskContentChanged>(_onTaskContentChanged);
    on<TaskPriorityChanged>(_onTaskPriorityChanged);
    on<TaskDueDateChanged>(_onTaskDueDateChanged);
    on<TaskDescriptionChanged>(_onTaskDescriptionChanged);
    on<TaskSelected>(_onTaskSelected);
    on<TaskCreated>(_onTaskCreate);
    on<TaskUpdated>(_onTaskUpdate);
    on<TaskDeleted>(_onTaskDelete);
  }

  final Todoist _todoist;

  void _onTaskInitial(TaskInitial event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _todoist.getTask(id: event.project.id);
    emit(state.copyWith(tasks: response.tasks, isLoading: false));
  }

  void _onTaskSelected(TaskSelected event, Emitter<TaskState> emit) {
    emit(state.copyWith(selectedTask: event.task));
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

  void _onTaskCreate(TaskCreated event, Emitter<TaskState> emit) async {
    print('TaskCreated');
    print(event.content);
    print(event.description);
    print(DateFormat('yyyy-MM-dd').format(event.due));
    print(DateFormat('d MMM').format(event.due));
    print(event.priority);
    print(event.projectId);
    await _todoist.createTask(
      content: event.content,
      description: event.description,
      dueDate: DateFormat('yyyy-MM-dd').format(event.due),
      dueString: DateFormat('d MMM').format(event.due),
      priority: event.priority,
      projectId: event.projectId,
    );
  }

  void _onTaskUpdate(TaskUpdated event, Emitter<TaskState> emit) async {
    // await _todoist.updateTask(
    //   id: event.task.id,
    //   content: event.task.content,
    //   description: event.task.description,
    //   dueString: event.task.dueString,
    //   priority: event.task.priority,
    // );
  }

  void _onTaskDelete(TaskDeleted event, Emitter<TaskState> emit) async {
    await _todoist.deleteTask(id: event.task.id);
  }
}
