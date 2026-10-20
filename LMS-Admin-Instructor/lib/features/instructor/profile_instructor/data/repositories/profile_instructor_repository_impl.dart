import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import '../models/instructor_profile_response_model.dart';
import '../models/update_instructor_request_model.dart';
import '../models/create_link_request_model.dart';
import '../models/update_link_request_model.dart';
import '../../domain/repositories/profile_instructor_repository.dart';

class ProfileInstructorRepositoryImpl implements ProfileInstructorRepository {
  final ApiConsumer apiConsumer;

  ProfileInstructorRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, InstructorProfileResponseModel>> getInstructorProfile(
    String slug,
  ) async {
    return await apiConsumer.get<InstructorProfileResponseModel>(
      EndPoint.getInstructorBySlug(slug),
      fromJson: (json) => InstructorProfileResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, InstructorProfileResponseModel>>
  updateInstructorProfile({
    required String slug,
    required UpdateInstructorRequestModel requestModel,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final Map<String, dynamic> data = requestModel.toJson();

    if (imageBytes != null) {
      data['image'] = apiConsumer.multipartFileFromBytes(
        imageBytes,
        filename: imageName,
      );
    } else {
      data.remove('image');
    }

    return await apiConsumer.patch<InstructorProfileResponseModel>(
      EndPoint.updateInstructor(slug),
      data: data,
      isFormData: imageBytes != null,
      fromJson: (json) => InstructorProfileResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, List<InstructorLinkModel>>> getInstructorLinks(
    String slug,
  ) async {
    return await apiConsumer.get<List<InstructorLinkModel>>(
      EndPoint.getInstructorLinks(slug),
      fromJson: (json) =>
          (json as List).map((e) => InstructorLinkModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<Either<String, InstructorLinkModel>> addInstructorLink({
    required String slug,
    required CreateLinkRequestModel requestModel,
  }) async {
    return await apiConsumer.post<InstructorLinkModel>(
      EndPoint.addInstructorLink(slug),
      data: requestModel.toJson(),
      fromJson: (json) => InstructorLinkModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, InstructorLinkModel>> updateInstructorLink({
    required String linkSlug,
    required UpdateLinkRequestModel requestModel,
  }) async {
    return await apiConsumer.patch<InstructorLinkModel>(
      EndPoint.updateInstructorLink(linkSlug),
      data: requestModel.toJson(),
      fromJson: (json) => InstructorLinkModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, String>> deleteInstructorLink(String linkSlug) async {
    return await apiConsumer.delete<String>(
      EndPoint.deleteInstructorLink(linkSlug),
      fromJson: (json) {
        final dynamic data = json;
        if (data == null || (data is Map && data.isEmpty)) {
          return 'Link deleted successfully';
        }
        return data['message'] ?? 'Link deleted successfully';
      },
    );
  }
}
