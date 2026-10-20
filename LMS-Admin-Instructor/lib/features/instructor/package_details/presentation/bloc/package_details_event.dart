import 'package:lms_admin_instructor/features/instructor/package_details/data/models/update_package_request_model.dart';

abstract class PackageDetailsEvent {}

class GetPackageDetailsEvent extends PackageDetailsEvent {
  final String slug;

  GetPackageDetailsEvent({required this.slug});
}

class UpdatePackageDetailsEvent extends PackageDetailsEvent {
  final String slug;
  final UpdatePackageRequestModel requestModel;

  UpdatePackageDetailsEvent({
    required this.slug,
    required this.requestModel,
  });
}
