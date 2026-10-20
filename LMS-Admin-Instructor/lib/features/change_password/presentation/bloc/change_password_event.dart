import '../../data/models/change_password_model.dart';

abstract class ChangePasswordEvent {}

class ChangePasswordSubmitEvent extends ChangePasswordEvent {
  final ChangePasswordModel request;

  ChangePasswordSubmitEvent({required this.request});
}
