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

class ProjectNameChanged extends ProjectEvent {
  const ProjectNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ProjectCreated extends ProjectEvent {
  const ProjectCreated();
}
