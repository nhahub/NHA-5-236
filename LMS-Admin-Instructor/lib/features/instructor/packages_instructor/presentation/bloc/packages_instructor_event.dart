import 'package:lms_admin_instructor/features/instructor/packages_instructor/data/model/create_package_request_model.dart';

abstract class PackagesInstructorEvent {}

class CreatePackageEvent extends PackagesInstructorEvent {
  final CreatePackageRequestModel requestModel;

  CreatePackageEvent({required this.requestModel});
}

class GetInstructorCoursesForPackageEvent extends PackagesInstructorEvent {
  final String instructorSlug;

  GetInstructorCoursesForPackageEvent({required this.instructorSlug});
}

class GetInstructorPackagesEvent extends PackagesInstructorEvent {
  final String instructorSlug;
  final int page;
  final String search;

  GetInstructorPackagesEvent({
    required this.instructorSlug,
    this.page = 1,
    this.search = '',
  });
}

class DeletePackageEvent extends PackagesInstructorEvent {
  final String slug;
  final String instructorSlug;

  DeletePackageEvent({
    required this.slug,
    required this.instructorSlug,
  });
}
