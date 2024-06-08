part of 'project_bloc.dart';

class ProjectState extends Equatable {
  final List<Project> projects;
  final bool isLoading;
  final Project selectedProject;
  final String projectName;

  const ProjectState({
    this.projects = const [],
    this.isLoading = false,
    this.selectedProject = Project.empty,
    this.projectName = '',
  });

  @override
  List<Object> get props => [projects, isLoading, selectedProject, projectName];

  ProjectState copyWith({
    List<Project>? projects,
    bool? isLoading,
    Project? selectedProject,
    String? projectName,
  }) {
    return ProjectState(
      projects: projects ?? this.projects,
      isLoading: isLoading ?? this.isLoading,
      selectedProject: selectedProject ?? this.selectedProject,
      projectName: projectName ?? this.projectName,
    );
  }

  @override
  bool get stringify => true;
}
