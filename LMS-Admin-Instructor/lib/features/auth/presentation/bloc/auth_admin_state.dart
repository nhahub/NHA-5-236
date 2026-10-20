part of 'auth_admin_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess<T> extends AuthState {
  final T? data;
  AuthSuccess({this.data});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class ForgotPasswordSuccess extends AuthState {
  final String message;
  ForgotPasswordSuccess(this.message);
}

class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess(this.message);
}


class ResendSuccess extends AuthState {
  final String message;
  ResendSuccess(this.message);
}

class LogoutSuccess extends AuthState {}