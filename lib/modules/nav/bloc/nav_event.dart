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
