import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_details_ui_model.dart';

abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final CourseDetailsUIModel courseDetails;

  CourseDetailsLoaded({required this.courseDetails});
}

class CourseDetailsError extends CourseDetailsState {
  final String message;

  CourseDetailsError({required this.message});
}

class UpdateCourseLoading extends CourseDetailsState {}

class UpdateCourseSuccess extends CourseDetailsState {
  final String message;
  UpdateCourseSuccess({required this.message});
}

class UpdateCourseError extends CourseDetailsState {
  final String message;
  UpdateCourseError({required this.message});
}