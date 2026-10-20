import 'package:dartz/dartz.dart';
import '../../data/models/change_password_model.dart';

abstract class ChangePasswordRepository {
  Future<Either<String, ChangePasswordModel>> changePassword(
    ChangePasswordModel request,
  );
}
