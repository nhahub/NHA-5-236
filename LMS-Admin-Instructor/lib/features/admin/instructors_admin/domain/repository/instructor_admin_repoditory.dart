import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/add_instructor_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_respomse_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_course_admin_responce_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_details_response_model.dart';

abstract class InstructorAdminRepository {
  Future<Either<String, InstructorAdminResponseModel>> getInstructorAdmin(
    int? page,
    int? pageSize,
    String? search,
  );
  Future<Either<String, InstructorDetailsResponseModel>> getInstructorBySlug(
    String slug,
  );
  Future<Either<String, AddInstructorModel>> addInstructor(
    String first_name,
    String last_name,
    String email,
  );
  Future<Either<String, void>> deleteInstructor(String slug);
  Future<Either<String, InstructorCourseAdminResponceModel>>
  getInstructorCoursesBySslug(
    int? page,
    int? pageSize,
    String slug,
    String? search,
  );
}
