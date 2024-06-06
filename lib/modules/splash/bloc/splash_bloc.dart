import 'package:bloc/bloc.dart';
import 'package:cache/cache.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(Cache cache)
      : _cache = cache,
        super(const SplashState()) {
    on<SplashInitial>(_onSplashInitial);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SplashFinished>(_onSplashFinished);
  }

  final Cache _cache;

  void _onSplashInitial(
    SplashInitial event,
    Emitter<SplashState> emit,
  ) {
    emit(state.copyWith(status: SplashStatus.splashInitial));
    add(const CheckAuthStatus());
  }

  void _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      _cache.writeToken('5ddf336817f735f90bced67b6d07d7f8ec4a0ba9');
      emit(state.copyWith(status: SplashStatus.checkAuthStatus));
    }).whenComplete(() {
      add(const SplashFinished());
    });
  }

  void _onSplashFinished(
    SplashFinished event,
    Emitter<SplashState> emit,
  ) {
    emit(state.copyWith(status: SplashStatus.splashFinished));
    Navigator.of(RootNavigatorKey.context).pushReplacementNamed(Routes.nav);
  }
}
