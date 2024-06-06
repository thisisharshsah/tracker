import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todoist/todoist.dart';
import '../../../global/global.dart';
import '../../../routes/routes.dart';

part 'project_event.dart';

part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc(
    Todoist todoist,
  )   : _todoist = todoist,
        super(const ProjectState()) {
    on<ProjectInitial>(_onProjectInitial);
    on<ProjectSelected>(_onProjectSelected);
  }

  final Todoist _todoist;

  void _onProjectInitial(
    ProjectInitial event,
    Emitter<ProjectState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _todoist.getProjects().then((response) {
      emit(state.copyWith(projects: response.projects));
      print(jsonEncode(response.projects));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }

  void _onProjectSelected(ProjectSelected event, Emitter<ProjectState> emit) {
    emit(state.copyWith(selectedProject: event.project));
    Navigator.of(RootNavigatorKey.key.currentContext!).pushNamed(
      Routes.task,
      arguments: state.selectedProject,
    );
  }
}
