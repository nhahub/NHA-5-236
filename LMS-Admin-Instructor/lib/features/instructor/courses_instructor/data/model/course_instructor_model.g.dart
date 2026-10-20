// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_instructor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInstructorModel _$CourseInstructorModelFromJson(
        Map<String, dynamic> json) =>
    CourseInstructorModel(
      title: json['title'] as String,
      slug: json['slug'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      ratingsCount: (json['ratings_count'] as num).toInt(),
      studentsCount: (json['students_count'] as num).toInt(),
    );

Map<String, dynamic> _$CourseInstructorModelToJson(
        CourseInstructorModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'created_at': instance.createdAt?.toIso8601String(),
      'ratings_count': instance.ratingsCount,
      'students_count': instance.studentsCount,
    };
