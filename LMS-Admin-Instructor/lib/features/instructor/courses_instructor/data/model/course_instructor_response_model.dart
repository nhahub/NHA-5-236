import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/course_instructor_ui_model.dart';
import 'course_instructor_model.dart';

part 'course_instructor_response_model.g.dart';

@JsonSerializable()
class CourseInstructorResponseModel {
  final bool success;
  final int status;
  final String message;
  final CourseInstructorData data;

  CourseInstructorResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourseInstructorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseInstructorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInstructorResponseModelToJson(this);

  CourseInstructorListUIModel toEntity() {
    return CourseInstructorListUIModel(
      courses: data.courses?.map((e) => e.toEntity()).toList() ?? [],
      totalCourses: data.totalCourses ?? 0,
      totalPages: data.totalPages ?? 1,
      currentPage: data.currentPage ?? 1,
    );
  }
}

@JsonSerializable()
class CourseInstructorData {
  @JsonKey(name: 'total_courses')
  final int? totalCourses;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  final List<CourseInstructorModel>? courses;

  CourseInstructorData({
    this.totalCourses,
    this.totalPages,
    this.currentPage,
    this.courses,
  });

  factory CourseInstructorData.fromJson(Map<String, dynamic> json) =>
      _$CourseInstructorDataFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInstructorDataToJson(this);
}
