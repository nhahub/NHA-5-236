import 'package:equatable/equatable.dart';

class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashStarted extends SplashEvent {}