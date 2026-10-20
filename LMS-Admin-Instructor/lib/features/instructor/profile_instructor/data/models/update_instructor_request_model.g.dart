// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_instructor_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInstructorRequestModel _$UpdateInstructorRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateInstructorRequestModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      bio: json['bio'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UpdateInstructorRequestModelToJson(
        UpdateInstructorRequestModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'bio': instance.bio,
      'description': instance.description,
      'image': instance.image,
    };
