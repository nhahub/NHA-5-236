import 'package:dartz/dartz.dart';
import '../../data/models/admin_profile_model.dart';

abstract class AdminProfileRepository {
  Future<Either<String, AdminProfileResponseModel>> getAdminProfile(
    String slug,
  );
}
