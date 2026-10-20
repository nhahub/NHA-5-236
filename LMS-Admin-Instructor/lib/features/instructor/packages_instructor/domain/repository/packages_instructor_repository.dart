import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/data/model/create_package_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/domain/entity/instructor_package_ui_model.dart';

abstract class PackagesInstructorRepository {
  Future<Either<String, String>> createPackage({
    required CreatePackageRequestModel requestModel,
  });

  Future<Either<String, InstructorPackageListUIModel>> getPackagesInstructor({
    required String instructorSlug,
    int page = 1,
    String search = '',
  });

  Future<Either<String, String>> deletePackage({
    required String slug,
  });
}
