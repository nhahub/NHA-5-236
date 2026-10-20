import 'package:dartz/dartz.dart';
import '../../data/models/course_students_response_model.dart';

abstract class CourseStudentsRepository {
  Future<Either<String, CourseStudentsResponseModel>> getCourseStudents({
    required String slug,
    int? page,
    int? pageSize,
    String? search,
  });
}
