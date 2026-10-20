import 'package:lms_admin_instructor/features/instructor/common/data/model/materials_model/upload_material_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/materials_model/update_material_request_model.dart';

abstract class CourseMaterialsEvent {}

class GetCourseMaterialsEvent extends CourseMaterialsEvent {
  final String slug;
  final int? page;
  final int? pageSize;

  GetCourseMaterialsEvent({
    required this.slug,
    this.page,
    this.pageSize,
  });
}

class UploadMaterialEvent extends CourseMaterialsEvent {
  final UploadMaterialRequestModel requestModel;

  UploadMaterialEvent({required this.requestModel});
}

class UpdateMaterialEvent extends CourseMaterialsEvent {
  final UpdateMaterialRequestModel requestModel;

  UpdateMaterialEvent({required this.requestModel});
}

class DeleteMaterialEvent extends CourseMaterialsEvent {
  final String courseSlug;
  final String materialSlug;

  DeleteMaterialEvent({
    required this.courseSlug,
    required this.materialSlug,
  });
}
