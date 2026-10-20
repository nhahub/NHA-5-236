// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCourseRequestModel _$UpdateCourseRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateCourseRequestModel(
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$UpdateCourseRequestModelToJson(
        UpdateCourseRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'level': instance.level,
      'is_active': instance.isActive,
    };
