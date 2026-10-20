import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_material_request_model.g.dart';

@JsonSerializable(createFactory: false)
class UpdateMaterialRequestModel {
  @JsonKey(includeToJson: false)
  final String courseSlug;
  final String slug;
  @JsonKey(name: 'Material_Name')
  final String materialName;
  @JsonKey(includeToJson: false)
  final PlatformFile? file;

  UpdateMaterialRequestModel({
    required this.courseSlug,
    required this.slug,
    required this.materialName,
    this.file,
  });

  Map<String, dynamic> toJson() => _$UpdateMaterialRequestModelToJson(this);
}
