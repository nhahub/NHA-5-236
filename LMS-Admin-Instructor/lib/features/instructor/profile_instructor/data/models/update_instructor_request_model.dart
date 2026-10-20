import 'package:json_annotation/json_annotation.dart';

part 'update_instructor_request_model.g.dart';

@JsonSerializable()
class UpdateInstructorRequestModel {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String bio;
  final String description;
  final String? image;

  UpdateInstructorRequestModel({
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.description,
    this.image,
  });

  factory UpdateInstructorRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateInstructorRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInstructorRequestModelToJson(this);
}
