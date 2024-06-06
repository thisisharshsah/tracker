import 'package:bloc/bloc.dart';
import 'package:cache/cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemeData[AppTheme.light]!)) {
    on<InitialTheme>(_onInitialTheme);
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onInitialTheme(InitialTheme event, Emitter<ThemeState> emit) async {
    final appTheme = await Cache().readDarkMode();
    emit(
      state.copyWith(
        themeData: appTheme == true
            ? appThemeData[AppTheme.dark]!
            : appThemeData[AppTheme.light]!,
      ),
    );
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeData: appThemeData[event.appTheme]!));
  }

  ThemeData get theme => state.themeData;
}
