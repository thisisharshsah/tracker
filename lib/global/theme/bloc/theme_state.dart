part of 'theme_bloc.dart';

@immutable
final class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState({required this.themeData});

  ThemeState copyWith({ThemeData? themeData}) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  List<Object> get props => [themeData];

  AppTheme get appTheme {
    if (themeData == appThemeData[AppTheme.light]) {
      return AppTheme.light;
    } else {
      return AppTheme.dark;
    }
  }

  @override
  String toString() => 'ThemeState { themeData: $themeData }';
}
