import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/add_instructor_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_respomse_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_course_admin_responce_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_details_response_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';

class InstructorAdminRepositoryImpl implements InstructorAdminRepository {
  final ApiConsumer apiConsumer;
  InstructorAdminRepositoryImpl({required this.apiConsumer});
  @override
  Future<Either<String, InstructorAdminResponseModel>> getInstructorAdmin(
    int? page,
    int? pageSize,
    String? search,
  ) async {
    return await apiConsumer.get<InstructorAdminResponseModel>(
      EndPoint.instructorAdmin,
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
        search: search,
      ),
      fromJson: (json) => InstructorAdminResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, AddInstructorModel>> addInstructor(
    String first_name,
    String last_name,
    String email,
  ) async {
    return await apiConsumer.post<AddInstructorModel>(
      EndPoint.addInstructor,
      data: {'first_name': first_name, 'last_name': last_name, 'email': email},
      fromJson: (json) => AddInstructorModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, void>> deleteInstructor(String slug) async {
    return await apiConsumer.delete<void>(EndPoint.deleteInstructor(slug));
  }

  @override
  Future<Either<String, InstructorDetailsResponseModel>> getInstructorBySlug(
    String slug,
  ) async {
    return await apiConsumer.get<InstructorDetailsResponseModel>(
      EndPoint.getInstructorBySlug(slug),
      fromJson: (json) => InstructorDetailsResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, InstructorCourseAdminResponceModel>>
  getInstructorCoursesBySslug(
    int? page,
    int? pageSize,
    String slug,
    String? search,
  ) async {
    return await apiConsumer.get<InstructorCourseAdminResponceModel>(
      EndPoint.getInstructorCoursesBySslug(slug),
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
        search: search,
      ),
      fromJson: (json) => InstructorCourseAdminResponceModel.fromJson(json),
    );
  }
}
