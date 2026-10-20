// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_instructor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInstructorResponseModel _$CourseInstructorResponseModelFromJson(
        Map<String, dynamic> json) =>
    CourseInstructorResponseModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: CourseInstructorData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseInstructorResponseModelToJson(
        CourseInstructorResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CourseInstructorData _$CourseInstructorDataFromJson(
        Map<String, dynamic> json) =>
    CourseInstructorData(
      totalCourses: (json['total_courses'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      courses: (json['courses'] as List<dynamic>?)
          ?.map(
              (e) => CourseInstructorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseInstructorDataToJson(
        CourseInstructorData instance) =>
    <String, dynamic>{
      'total_courses': instance.totalCourses,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'courses': instance.courses,
    };
