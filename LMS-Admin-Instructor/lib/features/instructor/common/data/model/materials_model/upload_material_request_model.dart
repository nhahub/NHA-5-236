import 'package:file_picker/file_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_material_request_model.g.dart';

@JsonSerializable(createFactory: false)
class UploadMaterialRequestModel {
  @JsonKey(name: 'Material_Name')
  final String materialName;
  @JsonKey(includeToJson: false)
  final PlatformFile file;
  @JsonKey(includeToJson: false)
  final String courseSlug;

  UploadMaterialRequestModel({
    required this.materialName,
    required this.file,
    required this.courseSlug,
  });

  Map<String, dynamic> toJson() => _$UploadMaterialRequestModelToJson(this);
}
