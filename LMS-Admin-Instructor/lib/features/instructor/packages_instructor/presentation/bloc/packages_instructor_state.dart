import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/packages_instructor/domain/entity/instructor_package_ui_model.dart';

abstract class PackagesInstructorState {}

class PackagesInstructorInitial extends PackagesInstructorState {}

class InstructorCoursesLoading extends PackagesInstructorState {}

class InstructorCoursesLoaded extends PackagesInstructorState {
  final List<CourseInstructorItemUIModel> courses;

  InstructorCoursesLoaded({required this.courses});
}

class InstructorCoursesError extends PackagesInstructorState {
  final String message;

  InstructorCoursesError({required this.message});
}

class CreatePackageLoading extends PackagesInstructorState {
  final List<CourseInstructorItemUIModel> courses;
  CreatePackageLoading({required this.courses});
}

class CreatePackageSuccess extends PackagesInstructorState {
  final String message;
  final List<CourseInstructorItemUIModel> courses;
  CreatePackageSuccess({required this.message, required this.courses});
}

class CreatePackageError extends PackagesInstructorState {
  final String message;
  final List<CourseInstructorItemUIModel> courses;
  CreatePackageError({required this.message, required this.courses});
}

class PackagesListLoading extends PackagesInstructorState {}

class PackagesListLoaded extends PackagesInstructorState {
  final InstructorPackageListUIModel packagesListUIModel;
  final bool isPaginationLoading;

  PackagesListLoaded({
    required this.packagesListUIModel,
    this.isPaginationLoading = false,
  });

  PackagesListLoaded copyWith({
    InstructorPackageListUIModel? packagesListUIModel,
    bool? isPaginationLoading,
  }) {
    return PackagesListLoaded(
      packagesListUIModel: packagesListUIModel ?? this.packagesListUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class PackagesListError extends PackagesInstructorState {
  final String message;

  PackagesListError({required this.message});
}

class DeletePackageLoading extends PackagesInstructorState {}

class DeletePackageSuccess extends PackagesInstructorState {
  final String message;
  DeletePackageSuccess({required this.message});
}

class DeletePackageError extends PackagesInstructorState {
  final String message;
  DeletePackageError({required this.message});
}
