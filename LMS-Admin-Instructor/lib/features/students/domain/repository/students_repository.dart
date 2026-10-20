import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/students/data/model/student_details_model.dart';
import 'package:lms_admin_instructor/features/students/data/model/students_response_model.dart';

abstract class StudentsRepository {
  Future<Either<String, StudentsResponseModel>> getStudents({
    int? page,
    int? pageSize,
    String? search,
  });
  Future<Either<String, Unit>> deleteStudent(String slug);
  Future<Either<String, StudentDetailsModel>> getStudentDetails(String slug);
}
