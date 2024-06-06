part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent extends Equatable {
  const ThemeEvent._();

  @override
  List<Object> get props => [];
}

class InitialTheme extends ThemeEvent {
  const InitialTheme() : super._();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme appTheme;

  const ThemeChanged(this.appTheme) : super._();

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeChanged { appTheme: $appTheme }';
}
