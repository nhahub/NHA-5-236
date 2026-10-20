import 'package:json_annotation/json_annotation.dart';

part 'add_course_request_model.g.dart';

@JsonSerializable()
class AddCourseRequestModel {
  final String title;
  final String description;
  final String price;
  final String category;
  final String level;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final dynamic image;
  @JsonKey(name: 'is_active')
  final bool isActive;

  AddCourseRequestModel({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.level,
    this.image,
    this.isActive = true,
  });

  factory AddCourseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddCourseRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCourseRequestModelToJson(this);
}
