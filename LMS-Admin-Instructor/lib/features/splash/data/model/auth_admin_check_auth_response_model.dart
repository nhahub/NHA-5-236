import 'package:lms_admin_instructor/core/common/user_role_enum.dart';

class CheckAuthResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final CheckAuthDataModel? data;

  const CheckAuthResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CheckAuthResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckAuthResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CheckAuthDataModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class CheckAuthDataModel {
  final bool? isActive;
  final bool? isVerified;
  final UserRole? role;
  final String? message;  

  const CheckAuthDataModel({
    this.isActive,
    this.isVerified,
    this.role,
    this.message,
  });

  factory CheckAuthDataModel.fromJson(Map<String, dynamic> json) {
    return CheckAuthDataModel(
      isActive: json['is_active'] as bool?,
      isVerified: json['is_verified'] as bool?,
      role: UserRole.fromString(json['role'] as String?),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_active': isActive,
      'is_verified': isVerified,
      'role': role?.name,
      'message': message,
    };
  }
}