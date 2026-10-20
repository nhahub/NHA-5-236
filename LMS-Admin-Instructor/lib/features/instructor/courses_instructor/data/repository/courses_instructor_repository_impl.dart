import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/add_course_request_model.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/course_instructor_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/repository/courses_instructor_repository.dart';

class CoursesInstructorRepositoryImpl implements CoursesInstructorRepository {
  final ApiConsumer apiConsumer;

  CoursesInstructorRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseInstructorResponseModel>> getCoursesInstructor({
    required String instructorSlug,
    int? page,
    int? pageSize,
    String? search,
  }) async {
    return await apiConsumer.get<CourseInstructorResponseModel>(
      EndPoint.coursesInstructor(instructorSlug),
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
        search: search,
      ),
      fromJson: (json) => CourseInstructorResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, String>> addCourse({
    required AddCourseRequestModel requestModel,
  }) async {
    final formData = {
      ApiKey.title: requestModel.title,
      ApiKey.description: requestModel.description,
      ApiKey.price: requestModel.price,
      ApiKey.category: requestModel.category,
      ApiKey.level: requestModel.level,
      ApiKey.image: requestModel.image,
      ApiKey.isActive: requestModel.isActive,
    };

    return await apiConsumer.post<String>(
      EndPoint.addCourse,
      data: formData,
      isFormData: true,
      fromJson: (json) => json['message'],
    );
  }
}
