import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_materials_ui_model.dart';

part 'course_material_model.g.dart';

@JsonSerializable()
class CourseMaterialModel {
  final String? course;
  final String? slug;
  @JsonKey(name: 'Material_Name')
  final String? materialName;
  final String? file;
  @JsonKey(name: 'file_size')
  final String? fileSize;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  CourseMaterialModel({
    this.course,
    this.slug,
    this.materialName,
    this.file,
    this.fileSize,
    this.createdAt,
  });

  factory CourseMaterialModel.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseMaterialModelToJson(this);

  CourseMaterialItemUIModel toEntity() {
    return CourseMaterialItemUIModel(
      slug: slug ?? '',
      course: course ?? '',
      materialName: materialName ?? '',
      file: file,
      fileSize: fileSize,
      createdAt: createdAt?.toIso8601String().split('T').first ?? '',
    );
  }
}
