import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoist/todoist.dart';
import 'package:tracker/global/functions/functions.dart';

import '../../../routes/routes.dart';
import '../../history/history.dart';
import '../../home/home.dart';
import '../../inbox/inbox.dart';
import '../../project/project.dart';

part 'nav_event.dart';

part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc({required Todoist todoist})
      : _todoist = todoist,
        super(const NavState()) {
    on<NavUpdate>(_onNavUpdate);
    on<NavReset>(_onNavReset);
    on<ProjectNameChanged>(_onProjectNameChanged);
    on<NavAdd>(_onNavAdd);
  }

  final Todoist _todoist;

  void _onNavUpdate(NavUpdate event, Emitter<NavState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onNavReset(NavReset event, Emitter<NavState> emit) {
    emit(const NavState());
  }

  void _onProjectNameChanged(ProjectNameChanged event, Emitter<NavState> emit) {
    emit(state.copyWith(projectName: event.name));
  }

  void _onNavAdd(NavAdd event, Emitter<NavState> emit) async {
    await _todoist.createProject(name: state.projectName).then((response) {
      SnackBarService.showSnackBar(content: 'Project created');
    }).catchError((error) {
      ResponseHandler.handleResponse(response: error);
    }).whenComplete(() {
      Navigator.of(RootNavigatorKey.key.currentContext!)
          .pushReplacementNamed(Routes.nav);
    });
  }

  @override
  void onTransition(Transition<NavEvent, NavState> transition) {
    super.onTransition(transition);
    debugPrint(transition.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
  }

  @override
  void onEvent(NavEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
