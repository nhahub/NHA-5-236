import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/course_instructor_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/add_course_request_model.dart';

abstract class CoursesInstructorRepository {
  Future<Either<String, CourseInstructorResponseModel>> getCoursesInstructor({
    required String instructorSlug,
    int? page,
    int? pageSize,
    String? search,
  });

  Future<Either<String, String>> addCourse({
    required AddCourseRequestModel requestModel,
  });
}
