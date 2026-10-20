// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_students_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseStudentsResponseModel _$CourseStudentsResponseModelFromJson(
        Map<String, dynamic> json) =>
    CourseStudentsResponseModel(
      totalStudents: (json['total_students'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      students: (json['students'] as List<dynamic>)
          .map((e) => CourseStudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseStudentsResponseModelToJson(
        CourseStudentsResponseModel instance) =>
    <String, dynamic>{
      'total_students': instance.totalStudents,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'students': instance.students,
    };

CourseStudentModel _$CourseStudentModelFromJson(Map<String, dynamic> json) =>
    CourseStudentModel(
      studentSlug: json['student_slug'] as String?,
      studentName: json['student_name'] as String?,
      studentEmail: json['student_email'] as String?,
      enrollmentDate: json['enrollment_date'] as String?,
      progress: json['progress'] as num?,
    );

Map<String, dynamic> _$CourseStudentModelToJson(CourseStudentModel instance) =>
    <String, dynamic>{
      'student_slug': instance.studentSlug,
      'student_name': instance.studentName,
      'student_email': instance.studentEmail,
      'enrollment_date': instance.enrollmentDate,
      'progress': instance.progress,
    };
