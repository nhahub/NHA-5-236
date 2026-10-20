import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import '../../data/models/course_students_response_model.dart';
import '../../domain/repositories/course_students_repository.dart';

class CourseStudentsRepositoryImpl implements CourseStudentsRepository {
  final ApiConsumer apiConsumer;

  CourseStudentsRepositoryImpl(this.apiConsumer);

  @override
  Future<Either<String, CourseStudentsResponseModel>> getCourseStudents({
    required String slug,
    int? page,
    int? pageSize,
    String? search,
  }) async {
    return await apiConsumer.get<CourseStudentsResponseModel>(
      EndPoint.courseStudents(slug),
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
        search: search,
      ),
      fromJson: (json) => CourseStudentsResponseModel.fromJson(json['data']),
    );
  }
}
