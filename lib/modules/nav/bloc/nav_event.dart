part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {
  const NavEvent._();

  List<Object> get props => [];
}

class NavUpdate extends NavEvent {
  const NavUpdate(this.index) : super._();

  final int index;

  @override
  List<Object> get props => [index];
}

class NavReset extends NavEvent {
  const NavReset() : super._();
}

class ProjectNameChanged extends NavEvent {
  const ProjectNameChanged({
    required this.name,
  }) : super._();

  final String name;

  @override
  List<Object> get props => [name];
}

class NavAdd extends NavEvent {
  const NavAdd() : super._();
}
