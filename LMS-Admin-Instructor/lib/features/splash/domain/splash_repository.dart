import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/splash/data/model/auth_admin_check_auth_response_model.dart';

abstract class SplashRepository {
  Future<Either<String, CheckAuthDataModel>> checkLogin();
}