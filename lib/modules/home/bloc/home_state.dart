part of 'home_bloc.dart';

enum ProgressItem { todo, inProgress, done }

class HomeState extends Equatable {
  final bool isLoading;
  final List<Task> tasks;

  const HomeState({
    this.isLoading = true,
    this.tasks = const [],
  });

  @override
  List<Object> get props => [isLoading, tasks];

  HomeState copyWith({
    bool? isLoading,
    List<Task>? tasks,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  bool get stringify => true;
}
