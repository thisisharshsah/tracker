part of 'splash_bloc.dart';

enum SplashStatus { splashInitial, checkAuthStatus, splashFinished }

final class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({
    this.status = SplashStatus.splashInitial,
  });

  @override
  List<Object> get props => [status];

  SplashState copyWith({
    SplashStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  bool get stringify => true;
}
