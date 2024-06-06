part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class ProjectInitial extends ProjectEvent {
  const ProjectInitial();
}

class ProjectSelected extends ProjectEvent {
  const ProjectSelected(this.project);

  final Project project;

  @override
  List<Object> get props => [project];
}
