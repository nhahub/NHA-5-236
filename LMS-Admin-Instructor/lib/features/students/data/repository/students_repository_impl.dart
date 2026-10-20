import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import 'package:lms_admin_instructor/features/students/data/model/student_details_model.dart';
import 'package:lms_admin_instructor/features/students/data/model/students_response_model.dart';
import 'package:lms_admin_instructor/features/students/domain/repository/students_repository.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  StudentsRepositoryImpl({required this.apiConsumer,required this.cacheHelper});

  @override
  Future<Either<String, StudentsResponseModel>> getStudents({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    final role = UserRole.fromString(cacheHelper.getDataString(key: ApiKey.role));
    final slug = cacheHelper.getDataString(key: ApiKey.slug) ?? '';

    String endPoint;
    if (role == UserRole.admin) {
      endPoint = EndPoint.studentsAdmin;
    } else if (role == UserRole.instructor) {
      endPoint = EndPoint.studentsInstructor(slug);
    } else {
      return const Left('You are not authorized to perform this action');
    }

    return await apiConsumer.get<StudentsResponseModel>(
      endPoint,
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
        search: search,
      ),
      fromJson: (json) => StudentsResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, Unit>> deleteStudent(String slug) async {
    return await apiConsumer.delete<Unit>(
      EndPoint.deleteStudentAdmin(slug),
      fromJson: (json) => unit,
    );
  }

  @override
  Future<Either<String, StudentDetailsModel>> getStudentDetails(String slug) async {
    final role = UserRole.fromString(cacheHelper.getDataString(key: ApiKey.role));

    String endPoint;
    if (role == UserRole.admin) {
      endPoint = EndPoint.studentsDetailsAdmin(slug);
    } else if (role == UserRole.instructor) {
      endPoint = EndPoint.studentsDetailsInstructor(slug);
    } else {
      return const Left('You are not authorized to perform this action');
    }

    return await apiConsumer.get<StudentDetailsModel>(
      endPoint,
      fromJson: (json) => StudentDetailsModel.fromJson(json),
    );
  }
}
