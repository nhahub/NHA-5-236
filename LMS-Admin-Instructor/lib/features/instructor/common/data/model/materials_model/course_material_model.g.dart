// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseMaterialModel _$CourseMaterialModelFromJson(Map<String, dynamic> json) =>
    CourseMaterialModel(
      course: json['course'] as String?,
      slug: json['slug'] as String?,
      materialName: json['Material_Name'] as String?,
      file: json['file'] as String?,
      fileSize: json['file_size'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CourseMaterialModelToJson(
        CourseMaterialModel instance) =>
    <String, dynamic>{
      'course': instance.course,
      'slug': instance.slug,
      'Material_Name': instance.materialName,
      'file': instance.file,
      'file_size': instance.fileSize,
      'created_at': instance.createdAt?.toIso8601String(),
    };
