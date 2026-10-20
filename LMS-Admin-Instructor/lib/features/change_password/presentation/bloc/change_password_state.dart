import '../../data/models/change_password_model.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordSuccess({required this.changePasswordModel});
}

class ChangePasswordError extends ChangePasswordState {
  final String message;

  ChangePasswordError({required this.message});
}
