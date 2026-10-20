import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/course_details_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/course_stats_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/repositories/course_details_repository.dart';

class CourseDetailsRepositoryImpl implements CourseDetailsRepository {
  final ApiConsumer apiConsumer;

  CourseDetailsRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseDetailsResponseModel>> getCourseDetails(
    String slug,
  ) async {
    return await apiConsumer.get<CourseDetailsResponseModel>(
      EndPoint.courseDetails(slug),
      fromJson: (json) => CourseDetailsResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, CourseStatsResponseModel>> getCourseStats(
    String slug,
  ) async {
    return await apiConsumer.get<CourseStatsResponseModel>(
      EndPoint.totalCourseDetails(slug),
      fromJson: (json) => CourseStatsResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, UpdateCourseResponseModel>> updateCourse(
    String slug,
    UpdateCourseRequestModel requestModel,
  ) async {
    final Map<String, dynamic> data = requestModel.toJson();
    if (requestModel.image != null) {
      if (requestModel.image is XFile) {
        final XFile file = requestModel.image;
        final bytes = await file.readAsBytes();
        data[ApiKey.image] = dio.MultipartFile.fromBytes(
          bytes,
          filename: file.name,
        );
      } else {
        data[ApiKey.image] = requestModel.image;
      }
    }

    return await apiConsumer.patch<UpdateCourseResponseModel>(
      EndPoint.updateCourse(slug),
      data: data,
      isFormData: requestModel.image != null,
      fromJson: (json) => UpdateCourseResponseModel.fromJson(json),
    );
  }
}
