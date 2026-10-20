import 'package:json_annotation/json_annotation.dart';

part 'student_details_model.g.dart';

Object? _readAverageScore(Map json, String key) {
  return json['avg_score'] ?? json['average_score'] ?? 0.0;
}

@JsonSerializable()
class StudentDetailsModel {
  final bool success;
  final int status;
  final String message;
  final StudentDetailsDataModel data;

  StudentDetailsModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory StudentDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$StudentDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentDetailsModelToJson(this);
}

@JsonSerializable()
class StudentDetailsDataModel {
  final String slug;
  final String name;
  final String email;
  final String? image;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'total_enrollments')
  final int totalEnrollments;
  @JsonKey(readValue: _readAverageScore)
  final double averageScore;
  final List<StudentDetailsCourseModel> courses;

  StudentDetailsDataModel({
    required this.slug,
    required this.name,
    required this.email,
    this.image,
    required this.isActive,
    required this.totalEnrollments,
    required this.averageScore,
    required this.courses,
  });

  factory StudentDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$StudentDetailsDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentDetailsDataModelToJson(this);
}

@JsonSerializable()
class StudentDetailsCourseModel {
  final String title;
  final String slug;
  final int progress;
  final String status;

  StudentDetailsCourseModel({
    required this.title,
    required this.slug,
    required this.progress,
    required this.status,
  });

  factory StudentDetailsCourseModel.fromJson(Map<String, dynamic> json) =>
      _$StudentDetailsCourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentDetailsCourseModelToJson(this);
}
