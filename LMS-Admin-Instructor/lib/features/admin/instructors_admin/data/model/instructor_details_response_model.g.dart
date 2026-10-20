// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorDetailsResponseModel _$InstructorDetailsResponseModelFromJson(
        Map<String, dynamic> json) =>
    InstructorDetailsResponseModel(
      data: InstructorAdminModel.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$InstructorDetailsResponseModelToJson(
        InstructorDetailsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
