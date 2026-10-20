import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../data/models/instructor_profile_response_model.dart';
import '../../data/models/update_instructor_request_model.dart';
import '../../data/models/create_link_request_model.dart';
import '../../data/models/update_link_request_model.dart';

abstract class ProfileInstructorRepository {
  Future<Either<String, InstructorProfileResponseModel>> getInstructorProfile(
    String slug,
  );

  Future<Either<String, InstructorProfileResponseModel>>
  updateInstructorProfile({
    required String slug,
    required UpdateInstructorRequestModel requestModel,
    Uint8List? imageBytes,
    String? imageName,
  });

  Future<Either<String, List<InstructorLinkModel>>> getInstructorLinks(
    String slug,
  );

  Future<Either<String, InstructorLinkModel>> addInstructorLink({
    required String slug,
    required CreateLinkRequestModel requestModel,
  });

  Future<Either<String, InstructorLinkModel>> updateInstructorLink({
    required String linkSlug,
    required UpdateLinkRequestModel requestModel,
  });

  Future<Either<String, String>> deleteInstructorLink(String linkSlug);
}
