import 'package:json_annotation/json_annotation.dart';
import 'course_material_model.dart';

part 'update_material_response_model.g.dart';

@JsonSerializable()
class UpdateMaterialResponseModel {
  final bool success;
  final int status;
  final String message;
  final CourseMaterialModel data;

  UpdateMaterialResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateMaterialResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateMaterialResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMaterialResponseModelToJson(this);
}
