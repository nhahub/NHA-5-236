// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_course_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCourseRequestModel _$AddCourseRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddCourseRequestModel(
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      category: json['category'] as String,
      level: json['level'] as String,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$AddCourseRequestModelToJson(
        AddCourseRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'level': instance.level,
      'is_active': instance.isActive,
    };
