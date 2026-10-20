import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/data/models/package_details_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/data/models/update_package_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/domain/entity/package_details_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/package_details/domain/repositories/package_details_repository.dart';

class PackageDetailsRepositoryImpl implements PackageDetailsRepository {
  final ApiConsumer apiConsumer;

  PackageDetailsRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, PackageDetailsUIModel>> getPackageDetails({
    required String slug,
  }) async {
    final response = await apiConsumer.get<PackageDetailsResponseModel>(
      EndPoint.packageDetails(slug),
      fromJson: (json) => PackageDetailsResponseModel.fromJson(json),
    );

    return response.fold((error) => Left(error), (data) {
      if (data.success == true && data.data != null) {
        return Right(data.data!.toEntity());
      }
      return Left(data.message!);
    });
  }

  @override
  Future<Either<String, String>> updatePackage({
    required String slug,
    required UpdatePackageRequestModel requestModel,
  }) async {
    final response = await apiConsumer.put<dynamic>(
      EndPoint.updatePackage(slug),
      data: requestModel.toJson(),
      fromJson: (json) => json,
    );

    return response.fold(
      (error) => Left(error),
      (data) => const Right("Package updated successfully"),
    );
  }
}
