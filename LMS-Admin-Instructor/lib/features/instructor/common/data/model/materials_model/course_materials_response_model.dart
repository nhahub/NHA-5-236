import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';
import 'course_material_model.dart';

part 'course_materials_response_model.g.dart';

@JsonSerializable()
class CourseMaterialsResponseModel {
  final bool success;
  final int status;
  final String message;
  final CourseMaterialsDataModel data;

  CourseMaterialsResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourseMaterialsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseMaterialsResponseModelToJson(this);

  CourseMaterialsListUIModel toEntity() {
    return CourseMaterialsListUIModel(
      materials: data.materials?.map((e) => e.toEntity()).toList() ?? [],
      totalPages: data.totalPages ?? 1,
      currentPage: data.currentPage ?? 1,
      totalMaterials: data.totalMaterials ?? 0,
    );
  }
}

@JsonSerializable()
class CourseMaterialsDataModel {
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_materials')
  final int? totalMaterials;
  final List<CourseMaterialModel>? materials;

  CourseMaterialsDataModel({
    this.totalPages,
    this.currentPage,
    this.totalMaterials,
    this.materials,
  });

  factory CourseMaterialsDataModel.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseMaterialsDataModelToJson(this);
}
