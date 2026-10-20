import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/add_course_request_model.dart';

class CoursesInstructorEvent {}

class GetCoursesInstructorEvent extends CoursesInstructorEvent {
  final String instructorSlug;
  final int? page;
  final int? pageSize;
  final String? search;
  GetCoursesInstructorEvent({
    required this.instructorSlug,
    this.page,
    this.pageSize,
    this.search,
  });
}

class DeleteCourseInstructorEvent extends CoursesInstructorEvent {
  final String slug;
  DeleteCourseInstructorEvent({required this.slug});
}


class AddCourseInstructorEvent extends CoursesInstructorEvent {
  final AddCourseRequestModel requestModel;
  AddCourseInstructorEvent({
    required this.requestModel,
  });
}