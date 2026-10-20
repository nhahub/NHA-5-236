import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/course_instructor_ui_model.dart';

part 'course_instructor_model.g.dart';

@JsonSerializable()
class CourseInstructorModel {
  final String title;
  final String slug;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'ratings_count')
  final int ratingsCount;

  @JsonKey(name: 'students_count')
  final int studentsCount;

  CourseInstructorModel({
    required this.title,
    required this.slug,
    this.createdAt,
    required this.ratingsCount,
    required this.studentsCount,
  });

  factory CourseInstructorModel.fromJson(Map<String, dynamic> json) =>
      _$CourseInstructorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInstructorModelToJson(this);

  CourseInstructorItemUIModel toEntity() {
    return CourseInstructorItemUIModel(
      slug: slug,
      title: title,
      createdAt: createdAt?.toIso8601String().split('T').first ?? '',
      studentsCount: studentsCount,
      ratingsCount: ratingsCount,
    );
  }
}
