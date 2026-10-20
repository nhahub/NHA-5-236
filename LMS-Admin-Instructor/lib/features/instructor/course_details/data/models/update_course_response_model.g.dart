// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCourseResponseModel _$UpdateCourseResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdateCourseResponseModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      category: json['category'] as String?,
      level: json['level'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$UpdateCourseResponseModelToJson(
        UpdateCourseResponseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'level': instance.level,
      'image': instance.image,
      'is_active': instance.isActive,
    };
