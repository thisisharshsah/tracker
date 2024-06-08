import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoist/todoist.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required Todoist todoist})
      : _todoist = todoist,
        super(const HomeState()) {
    on<HomeInitial>(_onHomeInitial);
    on<ChangeTaskStatus>(_onChangeTaskStatus);
  }

  final Todoist _todoist;

  void _onHomeInitial(
    HomeInitial event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _todoist.getTasks().then((response) {
      emit(state.copyWith(tasks: response.tasks));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }

  void _onChangeTaskStatus(
    ChangeTaskStatus event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _todoist
        .updateTask(id: event.task.id, )
        .then((response) {})
        .whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
