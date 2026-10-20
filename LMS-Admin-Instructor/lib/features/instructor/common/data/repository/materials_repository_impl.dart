import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import '../../domain/repository/materials_repository.dart';
import '../model/materials_model/course_materials_response_model.dart';
import '../model/materials_model/course_material_model.dart';
import '../model/materials_model/upload_material_request_model.dart';
import '../model/materials_model/update_material_request_model.dart';

class MaterialsRepositoryImpl implements MaterialsRepository {
  final ApiConsumer apiConsumer;

  MaterialsRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseMaterialsResponseModel>> getCourseMaterials({
    required String slug,
    int? page,
    int? pageSize,
  }) async {
    return await apiConsumer.get<CourseMaterialsResponseModel>(
      EndPoint.courseMaterials(slug),
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
      ),
      fromJson: (json) => CourseMaterialsResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, CourseMaterialModel>> uploadMaterial({
    required UploadMaterialRequestModel requestModel,
  }) async {
    final data = requestModel.toJson();

    if (requestModel.file.bytes != null) {
      data['file'] = apiConsumer.multipartFileFromBytes(
        requestModel.file.bytes!,
        filename: requestModel.file.name,
      );
    } else if (requestModel.file.path != null) {
      data['file'] = await apiConsumer.multipartFileFromPath(
        requestModel.file.path!,
        filename: requestModel.file.name,
      );
    }

    return await apiConsumer.post<CourseMaterialModel>(
      EndPoint.courseMaterials(requestModel.courseSlug),
      data: data,
      isFormData: true,
      sendTimeout: const Duration(minutes: 30),
      fromJson: (json) => CourseMaterialModel.fromJson(json['data']),
    );
  }

  @override
  Future<Either<String, CourseMaterialModel>> updateMaterial({
    required UpdateMaterialRequestModel requestModel,
  }) async {
    final data = requestModel.toJson();

    if (requestModel.file != null) {
      if (requestModel.file!.bytes != null) {
        data['file'] = apiConsumer.multipartFileFromBytes(
          requestModel.file!.bytes!,
          filename: requestModel.file!.name,
        );
      } else if (requestModel.file!.path != null) {
        data['file'] = await apiConsumer.multipartFileFromPath(
          requestModel.file!.path!,
          filename: requestModel.file!.name,
        );
      }
    }

    return await apiConsumer.patch<CourseMaterialModel>(
      EndPoint.courseMaterials(requestModel.courseSlug),
      data: data,
      isFormData: true,
      sendTimeout: const Duration(minutes: 30),
      fromJson: (json) => CourseMaterialModel.fromJson(json['data']),
    );
  }

  @override
  Future<Either<String, String>> deleteMaterial({
    required String courseSlug,
    required String materialSlug,
  }) async {
    return await apiConsumer.delete<String>(
      EndPoint.courseMaterials(courseSlug),
      data: {'slug': materialSlug},
      isFormData: true,
      fromJson: (json) => json['message'] as String? ?? 'Deleted Successfully',
    );
  }
}
