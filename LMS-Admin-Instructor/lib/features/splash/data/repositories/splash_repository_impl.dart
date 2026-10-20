import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/splash/data/model/auth_admin_check_auth_response_model.dart';
import 'package:lms_admin_instructor/features/splash/domain/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  SplashRepositoryImpl({required this.apiConsumer, required this.cacheHelper});
  @override
  Future<Either<String, CheckAuthDataModel>> checkLogin() async {
    if (cacheHelper.getData(key: ApiKey.accessToken) == null ||
        cacheHelper.getData(key: ApiKey.accessToken) == "") {
      return const Left("No token found");
    }

    final result = await apiConsumer.get<CheckAuthResponseModel>(
      EndPoint.checkToken,
      fromJson: (json) => CheckAuthResponseModel.fromJson(json),
    );

    return await result.fold(
      (error) async {
        if (error.contains("Unauthorized") || error.contains("401")) {
          await _clearCache();
        }
        return Left(error);
      },
      (response) async {
        if (response.data != null) {
          return Right(response.data!);
        } else {
          return Left(response.message ?? "Unknown error");
        }
      },
    );
  }

  Future<void> _clearCache() async {
    await cacheHelper.removeData(key: ApiKey.accessToken);
    await cacheHelper.removeData(key: ApiKey.refreshToken);
    await cacheHelper.removeData(key: ApiKey.user);
    await cacheHelper.removeData(key: ApiKey.isLoggedIn);
  }
}

// import 'package:dartz/dartz.dart';
// import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
// import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
// import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
// import 'package:lms_admin_instructor/features/splash/data/model/auth_admin_check_auth_response_model.dart';
// import 'package:lms_admin_instructor/features/splash/domain/splash_repository.dart';

// class SplashRepositoryImpl implements SplashRepository {
//   final ApiConsumer apiConsumer;
//   final CacheHelper cacheHelper;

//   SplashRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

//   @override
//   Future<Either<String, CheckAuthDataModel>> checkLogin() async {
//     // ✅ 1. نجيب التوكن من الـ Cache
//     final token = cacheHelper.getData(key: ApiKey.accessToken);
//     print('🔐 [1] Token from cache: $token');

//     if (token == null || token == "") {
//       print('❌ [2] No token found → going to Login');
//       return const Left("No token found");
//     }

//     print('✅ [3] Token found, calling checkToken API...');

//     // ✅ 2. نطلب من السيرفر يتأكد من التوكن
//     final result = await apiConsumer.get<CheckAuthResponseModel>(
//       EndPoint.checkToken,
//       fromJson: (json) => CheckAuthResponseModel.fromJson(json),
//     );

//     print('📡 [4] API Response: $result');

//     // ✅ 3. نتعامل مع النتيجة
//     return await result.fold(
//       (error) async {
//         print('❌ [5] API Error: $error');
//         if (error.contains("Unauthorized") || error.contains("401")) {
//           print('⚠️ [6] Unauthorized → clearing cache');
//           await _clearCache();
//         }
//         return Left(error);
//       },
//       (response) async {
//         print('✅ [7] API Success, response.data = ${response.data}');
//         if (response.data != null) {
//           print(
//             '📦 [8] Returning Right with data: isActive=${response.data!.isActive}, isVerified=${response.data!.isVerified}, role=${response.data!.role}',
//           );
//           return Right(response.data!);
//         } else {
//           print('❌ [9] response.data is null, message = ${response.message}');
//           return Left(response.message ?? "Unknown error");
//         }
//       },
//     );
//   }

//   Future<void> _clearCache() async {
//     print('🧹 Clearing cache...');
//     await cacheHelper.removeData(key: ApiKey.accessToken);
//     await cacheHelper.removeData(key: ApiKey.refreshToken);
//     await cacheHelper.removeData(key: ApiKey.user);
//     await cacheHelper.removeData(key: ApiKey.isLoggedIn);
//     print('✅ Cache cleared');
//   }
// }
