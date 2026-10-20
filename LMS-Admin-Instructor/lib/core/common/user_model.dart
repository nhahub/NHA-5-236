
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final UserRole? role;
  final String slug;
  final bool? isActive;
  final bool? isVerified;
  final String? image;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.role,
    required this.slug,
    this.isActive,
    this.isVerified,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.firstName: firstName,
      ApiKey.lastName: lastName,
      ApiKey.email: email,
      ApiKey.role: role?.name,
      ApiKey.slug: slug,
      ApiKey.isActive: isActive,
      ApiKey.isVerified: isVerified,
      ApiKey.image: image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json[ApiKey.firstName] ?? '',
      lastName: json[ApiKey.lastName] ?? '',
      email: json[ApiKey.email] ?? '',
      role: UserRole.fromString(json[ApiKey.role]),
      slug: json[ApiKey.slug] ?? '',
      isActive: json[ApiKey.isActive],
      isVerified: json[ApiKey.isVerified],
      image: json[ApiKey.image],
    );
  }
}
