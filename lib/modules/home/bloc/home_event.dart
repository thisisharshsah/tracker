part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeEvent {
  const HomeInitial();

  @override
  List<Object> get props => [];
}

class ChangeTaskStatus extends HomeEvent {
  const ChangeTaskStatus(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}
