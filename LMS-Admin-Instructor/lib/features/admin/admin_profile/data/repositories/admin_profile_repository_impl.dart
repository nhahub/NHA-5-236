import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import '../models/admin_profile_model.dart';
import '../../domain/repositories/admin_profile_repository.dart';

class AdminProfileRepositoryImpl implements AdminProfileRepository {
  final ApiConsumer apiConsumer;

  AdminProfileRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, AdminProfileResponseModel>> getAdminProfile(
    String slug,
  ) async {
    return await apiConsumer.get<AdminProfileResponseModel>(
      EndPoint.adminProfile(slug),
      fromJson: (json) => AdminProfileResponseModel.fromJson(json),
    );
  }
}
