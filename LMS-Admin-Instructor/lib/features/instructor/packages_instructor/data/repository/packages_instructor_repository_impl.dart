import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/data/model/create_package_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/domain/entity/instructor_package_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/data/model/package_instructor_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/domain/repository/packages_instructor_repository.dart';

class PackagesInstructorRepositoryImpl implements PackagesInstructorRepository {
  final ApiConsumer apiConsumer;

  PackagesInstructorRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, String>> createPackage({
    required CreatePackageRequestModel requestModel,
  }) async {
    final response = await apiConsumer.post<dynamic>(
      EndPoint.createPackage,
      data: requestModel.toJson(),
      fromJson: (json) => json, 
    );

    return response.fold(
      (error) => Left(error),
      (data) => const Right("Package created successfully"),
    );
  }

  @override
  Future<Either<String, InstructorPackageListUIModel>> getPackagesInstructor({
    required String instructorSlug,
    int page = 1,
    String search = '',
  }) async {
    final response = await apiConsumer.get<InstructorPackagesListResponseModel>(
      EndPoint.packagesInstructor(instructorSlug),
      queryParameters: {
        'page': page,
        if (search.isNotEmpty) 'search': search,
      },
      fromJson: (json) => InstructorPackagesListResponseModel.fromJson(json),
    );

    return response.fold(
      (error) => Left(error),
      (data) => Right(data.toEntity()),
    );
  }

  @override
  Future<Either<String, String>> deletePackage({
    required String slug,
  }) async {
    final response = await apiConsumer.delete<dynamic>(
      EndPoint.deletePackage(slug),
    );

    return response.fold(
      (error) => Left(error),
      (data) => const Right("Package deleted successfully"),
    );
  }
}
