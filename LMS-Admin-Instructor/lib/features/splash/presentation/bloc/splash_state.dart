import 'package:equatable/equatable.dart';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';

class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final UserRole role;
  const SplashLoaded({required this.role});
}

class SplashError extends SplashState {
  final String? message;
  final bool? isActive;
  final bool? isVerified;

  const SplashError({this.message, this.isActive, this.isVerified});

  @override
  List<Object?> get props => [message, isActive, isVerified];
}