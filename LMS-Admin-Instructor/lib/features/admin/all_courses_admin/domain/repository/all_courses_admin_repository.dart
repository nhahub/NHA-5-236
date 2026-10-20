import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/data/model/course_admin_response_model.dart';

abstract class AllCoursesAdminRepository {
  Future<Either<String, AllCoursesAdminResponseModel>> getAllCourses({
    int? page,
    int? pageSize,
    String? search,
  });

  Future<Either<String, String>> deleteCourse(String slug);
}
