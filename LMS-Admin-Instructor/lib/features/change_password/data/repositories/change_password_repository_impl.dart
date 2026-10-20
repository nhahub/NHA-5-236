import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import '../../domain/repositories/change_password_repository.dart';
import '../models/change_password_model.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ApiConsumer apiConsumer;

  ChangePasswordRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, ChangePasswordModel>> changePassword(
    ChangePasswordModel request,
  ) async {
    return await apiConsumer.post<ChangePasswordModel>(
      EndPoint.changePassword,
      data: request.toJson(),
      fromJson: (json) => ChangePasswordModel.fromJson(json),
    );
  }
}
