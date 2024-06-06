part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {
  const SplashEvent._();
}

class SplashInitial extends SplashEvent {
  const SplashInitial() : super._();

  @override
  String toString() => 'SplashInitial';
}

class CheckAuthStatus extends SplashEvent {
  const CheckAuthStatus() : super._();

  @override
  String toString() => 'CheckAuthStatus';
}

class SplashFinished extends SplashEvent {
  const SplashFinished() : super._();

  @override
  String toString() => 'SplashFinished';
}
