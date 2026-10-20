import 'package:dartz/dartz.dart';
import '../entity/package_details_ui_model.dart';
import '../../data/models/update_package_request_model.dart';

abstract class PackageDetailsRepository {
  Future<Either<String, PackageDetailsUIModel>> getPackageDetails({
    required String slug,
  });

  Future<Either<String, String>> updatePackage({
    required String slug,
    required UpdatePackageRequestModel requestModel,
  });
}
