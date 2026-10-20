import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/course_details_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/course_stats_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_response_model.dart';

abstract class CourseDetailsRepository {
  Future<Either<String, CourseDetailsResponseModel>> getCourseDetails(String slug);
  Future<Either<String, CourseStatsResponseModel>> getCourseStats(String slug);
  Future<Either<String, UpdateCourseResponseModel>> updateCourse(
    String slug,
    UpdateCourseRequestModel requestModel,
  );
}
