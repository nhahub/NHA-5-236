import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_login_request_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_login_response_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_reset_password_request_model.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResponseModel>> login(LoginRequestModel request);
  Future<Either<String, String>> forgotPassword(String email);
  Future<Either<String, String>> resetPassword(
    ResetPasswordRequestModel request,
  );
  Future<Either<String, String>> resendOtp(String email);
  Future<Either<String, String>> logout();
}
