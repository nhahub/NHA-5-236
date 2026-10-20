import 'package:json_annotation/json_annotation.dart';

part 'add_instructor_model.g.dart';

@JsonSerializable()
class AddInstructorModel {
  final bool success;
  final int status;
  final String message;
  final AddInstructorData data;

  AddInstructorModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddInstructorModel.fromJson(Map<String, dynamic> json) =>
      _$AddInstructorModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddInstructorModelToJson(this);
}

@JsonSerializable()
class AddInstructorData {
  @JsonKey(name: 'instructor_email')
  final String instructorEmail;
  @JsonKey(name: 'instructor_name')
  final String instructorName;

  AddInstructorData({
    required this.instructorEmail,
    required this.instructorName,
  });

  factory AddInstructorData.fromJson(Map<String, dynamic> json) =>
      _$AddInstructorDataFromJson(json);
  Map<String, dynamic> toJson() => _$AddInstructorDataToJson(this);
}
