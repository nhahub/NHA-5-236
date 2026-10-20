import 'package:json_annotation/json_annotation.dart';

part 'update_course_response_model.g.dart';

@JsonSerializable()
class UpdateCourseResponseModel {
  final String? title;
  final String? description;
  final String? price;
  final String? category;
  final String? level;
  final String? image;
  @JsonKey(name: 'is_active')
  final bool? isActive;

  UpdateCourseResponseModel({
    this.title,
    this.description,
    this.price,
    this.category,
    this.level,
    this.image,
    this.isActive,
  });

  factory UpdateCourseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCourseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCourseResponseModelToJson(this);
}
