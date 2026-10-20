// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentDetailsModel _$StudentDetailsModelFromJson(Map<String, dynamic> json) =>
    StudentDetailsModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: StudentDetailsDataModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentDetailsModelToJson(
        StudentDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

StudentDetailsDataModel _$StudentDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    StudentDetailsDataModel(
      slug: json['slug'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool,
      totalEnrollments: (json['total_enrollments'] as num).toInt(),
      averageScore: (_readAverageScore(json, 'averageScore') as num).toDouble(),
      courses: (json['courses'] as List<dynamic>)
          .map((e) =>
              StudentDetailsCourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StudentDetailsDataModelToJson(
        StudentDetailsDataModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'is_active': instance.isActive,
      'total_enrollments': instance.totalEnrollments,
      'averageScore': instance.averageScore,
      'courses': instance.courses,
    };

StudentDetailsCourseModel _$StudentDetailsCourseModelFromJson(
        Map<String, dynamic> json) =>
    StudentDetailsCourseModel(
      title: json['title'] as String,
      slug: json['slug'] as String,
      progress: (json['progress'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$StudentDetailsCourseModelToJson(
        StudentDetailsCourseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'progress': instance.progress,
      'status': instance.status,
    };
