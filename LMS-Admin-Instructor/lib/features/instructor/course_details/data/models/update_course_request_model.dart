import 'package:json_annotation/json_annotation.dart';

part 'update_course_request_model.g.dart';

@JsonSerializable()
class UpdateCourseRequestModel {
  final String title;
  final String description;
  final String price;
  final String category;
  final String level;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final dynamic image;

  UpdateCourseRequestModel({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.level,
    required this.isActive,
    this.image,
  });

  factory UpdateCourseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCourseRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCourseRequestModelToJson(this);
}
