part of 'auth_admin_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordRequestModel requestModel;

  ResetPasswordEvent({required this.requestModel});
}

class ResendOtpEvent extends AuthEvent {
  final String email;

  ResendOtpEvent({required this.email});
}

class LogoutEvent extends AuthEvent {}