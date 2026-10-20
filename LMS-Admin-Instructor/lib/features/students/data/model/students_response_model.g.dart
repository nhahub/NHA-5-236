// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsResponseModel _$StudentsResponseModelFromJson(
        Map<String, dynamic> json) =>
    StudentsResponseModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StudentsData.fromJson(json['data'] as Map<String, dynamic>),
      totalEnrollments: (json['total_enrollments'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudentsResponseModelToJson(
        StudentsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
      'total_enrollments': instance.totalEnrollments,
    };

StudentsData _$StudentsDataFromJson(Map<String, dynamic> json) => StudentsData(
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalStudents: (json['total_students'] as num?)?.toInt(),
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => StudentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalEnrollments: (json['total_enrollments'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudentsDataToJson(StudentsData instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_students': instance.totalStudents,
      'students': instance.students,
      'total_enrollments': instance.totalEnrollments,
    };
