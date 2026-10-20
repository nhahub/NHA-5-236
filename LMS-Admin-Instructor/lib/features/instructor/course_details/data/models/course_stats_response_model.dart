import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/course_stats_ui_model.dart';

part 'course_stats_response_model.g.dart';

@JsonSerializable()
class CourseStatsResponseModel {
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final CourseStatsDataModel? data;

  CourseStatsResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CourseStatsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseStatsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStatsResponseModelToJson(this);
}

@JsonSerializable()
class CourseStatsDataModel {
  @JsonKey(name: 'course_slug')
  final String? courseSlug;
  @JsonKey(name: 'course_title')
  final String? courseTitle;
  @JsonKey(name: 'total_Materials')
  final int? totalMaterials;
  @JsonKey(name: 'total_Videos')
  final int? totalVideos;
  @JsonKey(name: 'total_Quizzes')
  final int? totalQuizzes;
  @JsonKey(name: 'total_Students')
  final int? totalStudents;

  CourseStatsDataModel({
    this.courseSlug,
    this.courseTitle,
    this.totalMaterials,
    this.totalVideos,
    this.totalQuizzes,
    this.totalStudents,
  });

  factory CourseStatsDataModel.fromJson(Map<String, dynamic> json) =>
      _$CourseStatsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStatsDataModelToJson(this);

  CourseStatsUIModel toEntity() {
    return CourseStatsUIModel(
      courseSlug: courseSlug ?? '',
      courseTitle: courseTitle ?? '',
      totalMaterials: totalMaterials ?? 0,
      totalVideos: totalVideos ?? 0,
      totalQuizzes: totalQuizzes ?? 0,
      totalStudents: totalStudents ?? 0,
    );
  }
}
