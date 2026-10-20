import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/data/model/course_admin_response_model.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/domain/repository/all_courses_admin_repository.dart';

class AllCoursesAdminRepositoryImpl implements AllCoursesAdminRepository {
  final ApiConsumer apiConsumer;

  AllCoursesAdminRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, AllCoursesAdminResponseModel>> getAllCourses({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    return await apiConsumer.get<AllCoursesAdminResponseModel>(
      EndPoint.allCoursesAdmin,
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
        search: search,
      ),
      fromJson: (json) => AllCoursesAdminResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, String>> deleteCourse(String slug) async {
    return await apiConsumer.delete<String>(
      EndPoint.deleteCourseAdmin(slug),
      fromJson: (json) => json['message'] ?? 'Course deleted successfully',
    );
  }
}
