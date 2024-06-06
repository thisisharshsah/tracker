part of 'project_bloc.dart';

class ProjectState extends Equatable {
  final List<Project> projects;
  final bool isLoading;
  final Project selectedProject;

  const ProjectState({
    this.projects = const [],
    this.isLoading = false,
    this.selectedProject = Project.empty,
  });

  @override
  List<Object> get props => [projects, isLoading, selectedProject];

  ProjectState copyWith({
    List<Project>? projects,
    bool? isLoading,
    Project? selectedProject,
  }) {
    return ProjectState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      selectedProject: selectedProject ?? this.selectedProject,
    );
  }

  @override
  bool get stringify => true;
}
