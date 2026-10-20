// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_course_admin_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorCourseAdminResponceModel _$InstructorCourseAdminResponceModelFromJson(
        Map<String, dynamic> json) =>
    InstructorCourseAdminResponceModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : InstructorCourseAdminData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstructorCourseAdminResponceModelToJson(
        InstructorCourseAdminResponceModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

InstructorCourseAdminData _$InstructorCourseAdminDataFromJson(
        Map<String, dynamic> json) =>
    InstructorCourseAdminData(
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalCourses: (json['total_courses'] as num?)?.toInt(),
      courses: (json['courses'] as List<dynamic>?)
          ?.map(
              (e) => CourseInstructorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstructorCourseAdminDataToJson(
        InstructorCourseAdminData instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_courses': instance.totalCourses,
      'courses': instance.courses,
    };
