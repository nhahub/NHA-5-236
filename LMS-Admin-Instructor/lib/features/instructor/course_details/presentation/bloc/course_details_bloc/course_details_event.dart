import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_request_model.dart';

abstract class CourseDetailsEvent {}

class GetCourseDetailsEvent extends CourseDetailsEvent {
  final String slug;

  GetCourseDetailsEvent({required this.slug});
}

class UpdateCourseDetailsEvent extends CourseDetailsEvent {
  final String slug;
  final UpdateCourseRequestModel requestModel;

  UpdateCourseDetailsEvent({
    required this.slug,
    required this.requestModel,
  });
}