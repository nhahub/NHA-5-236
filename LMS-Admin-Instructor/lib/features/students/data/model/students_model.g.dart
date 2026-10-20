// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsModel _$StudentsModelFromJson(Map<String, dynamic> json) =>
    StudentsModel(
      slug: json['slug'] as String?,
      studentName: json['student_name'] as String?,
      email: json['email'] as String?,
      isActive: json['is_active'] as bool?,
      enrollmentsCount: (json['enrollments_count'] as num?)?.toInt(),
      image: json['image'] as String?,
      isVerified: json['is_verified'] as bool?,
    );

Map<String, dynamic> _$StudentsModelToJson(StudentsModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'student_name': instance.studentName,
      'email': instance.email,
      'is_active': instance.isActive,
      'enrollments_count': instance.enrollmentsCount,
      'image': instance.image,
      'is_verified': instance.isVerified,
    };
