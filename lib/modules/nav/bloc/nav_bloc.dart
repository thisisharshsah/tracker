import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/home.dart';
import '../../inbox/inbox.dart';
import '../../project/project.dart';

part 'nav_event.dart';

part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const NavState()) {
    on<NavUpdate>(_onNavUpdate);
    on<NavReset>(_onNavReset);
  }

  void _onNavUpdate(NavUpdate event, Emitter<NavState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onNavReset(NavReset event, Emitter<NavState> emit) {
    emit(const NavState());
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
