import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoist/todoist.dart';

part 'inbox_event.dart';

part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc(
    Todoist todoist,
  )   : _todoist = todoist,
        super(const InboxState()) {
    on<InboxInitial>(_onInboxInitial);
  }

  final Todoist _todoist;

  void _onInboxInitial(
    InboxInitial event,
    Emitter<InboxState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _todoist.getProjects().then((response) {
      emit(state.copyWith(
        inbox: response.projects.firstWhere((element) {
          return element.order == 0;
        }),
      ));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
