import 'dart:convert';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';

import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_login_request_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_login_response_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_reset_password_request_model.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_admin_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  AuthRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

  @override
  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final result = await apiConsumer.post<LoginResponseModel>(
      EndPoint.login,
      data: request.toJson(),
      fromJson: (json) => LoginResponseModel.fromJson(json),
    );

    return await result.fold(
      (error) {
        return Left(error);
      },
      (loginResponse) async {
        if (loginResponse.user.role != UserRole.admin &&
            loginResponse.user.role != UserRole.instructor) {
          return const Left('You are not authorized to login to dashboard');
        }

        await cacheHelper.saveData(
          key: ApiKey.accessToken,
          value: loginResponse.accessToken,
        );

        await cacheHelper.saveData(
          key: ApiKey.refreshToken,
          value: loginResponse.refreshToken,
        );

        await cacheHelper.saveData(key: ApiKey.isLoggedIn, value: true);

        final userJson = jsonEncode(loginResponse.user.toJson());
        await cacheHelper.saveData(key: ApiKey.user, value: userJson);

        await cacheHelper.saveData(
          key: ApiKey.slug,
          value: loginResponse.user.slug,
        );

        await cacheHelper.saveData(
          key: ApiKey.role,
          value: loginResponse.user.role?.name,
        );

        return Right(loginResponse);
      },
    );
  }

  @override
  Future<Either<String, String>> forgotPassword(String email) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.forgotPassword,
      data: {"email": email},
    );
    return result.fold(
      (error) => Left(error),
      (data) => Right(data['message']?.toString() ?? 'OTP sent successfully'),
    );
  }

  @override
  Future<Either<String, String>> resetPassword(
    ResetPasswordRequestModel request,
  ) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.resetPassword,
      data: request.toJson(),
    );
    return result.fold(
      (error) => Left(error),
      (data) =>
          Right(data['message']?.toString() ?? 'Password reset successfully'),
    );
  }

  @override
  Future<Either<String, String>> resendOtp(String email) async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.resendOtp,
      data: {"email": email},
    );
    return result.fold(
      (error) => Left(error),
      (data) => Right(data['message']?.toString() ?? 'OTP resent successfully'),
    );
  }

  @override
  Future<Either<String, String>> logout() async {
    final result = await apiConsumer.post<Map<String, dynamic>>(
      EndPoint.logout,
      data: {
        ApiKey.refreshToken: cacheHelper.getData(key: ApiKey.refreshToken),
      },
    );
    return await result.fold(
      (error) {
        return Left(error);
      },
      (successResponse) async {
        await cacheHelper.clearUserData();
        return Right(
          successResponse['message']?.toString() ?? 'Logout successfully',
        );
      },
    );
  }
}
