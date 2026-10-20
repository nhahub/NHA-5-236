import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class ChangePasswordModel {
  final String oldPassword;
  final String newPassword;

  ChangePasswordModel({required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      ApiKey.oldPassword: oldPassword,
      ApiKey.newPassword: newPassword,
    };
  }

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      oldPassword: json[ApiKey.oldPassword] ?? '',
      newPassword: json[ApiKey.newPassword] ?? '',
    );
  }
}
