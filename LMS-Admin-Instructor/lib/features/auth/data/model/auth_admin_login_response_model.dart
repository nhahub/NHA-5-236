import 'package:lms_admin_instructor/core/common/user_model.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class LoginResponseModel {
  final bool success;
  final int status;
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': {
        'tokens': {
          ApiKey.accessToken: accessToken,
          ApiKey.refreshToken: refreshToken,
        },
        'user': user.toJson(),
      },
    };
  }

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final tokens = data['tokens'] ?? {};

    return LoginResponseModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      accessToken: tokens[ApiKey.accessToken] ?? '',
      refreshToken: tokens[ApiKey.refreshToken] ?? '',
      user: UserModel.fromJson(data['user'] ?? {}),
    );
  }

  factory LoginResponseModel.error(String message) {
    return LoginResponseModel(
      success: false,
      status: 500,
      message: message,
      accessToken: '',
      refreshToken: '',
      user: UserModel.fromJson({}),
    );
  }

  @override
  String toString() {
    return 'LoginResponseModel(message: $message)';
  }
}
