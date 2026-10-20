// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_stats_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseStatsResponseModel _$CourseStatsResponseModelFromJson(
        Map<String, dynamic> json) =>
    CourseStatsResponseModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CourseStatsDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseStatsResponseModelToJson(
        CourseStatsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CourseStatsDataModel _$CourseStatsDataModelFromJson(
        Map<String, dynamic> json) =>
    CourseStatsDataModel(
      courseSlug: json['course_slug'] as String?,
      courseTitle: json['course_title'] as String?,
      totalMaterials: (json['total_Materials'] as num?)?.toInt(),
      totalVideos: (json['total_Videos'] as num?)?.toInt(),
      totalQuizzes: (json['total_Quizzes'] as num?)?.toInt(),
      totalStudents: (json['total_Students'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseStatsDataModelToJson(
        CourseStatsDataModel instance) =>
    <String, dynamic>{
      'course_slug': instance.courseSlug,
      'course_title': instance.courseTitle,
      'total_Materials': instance.totalMaterials,
      'total_Videos': instance.totalVideos,
      'total_Quizzes': instance.totalQuizzes,
      'total_Students': instance.totalStudents,
    };
