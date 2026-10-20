// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_instructor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInstructorModel _$AddInstructorModelFromJson(Map<String, dynamic> json) =>
    AddInstructorModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: AddInstructorData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddInstructorModelToJson(AddInstructorModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

AddInstructorData _$AddInstructorDataFromJson(Map<String, dynamic> json) =>
    AddInstructorData(
      instructorEmail: json['instructor_email'] as String,
      instructorName: json['instructor_name'] as String,
    );

Map<String, dynamic> _$AddInstructorDataToJson(AddInstructorData instance) =>
    <String, dynamic>{
      'instructor_email': instance.instructorEmail,
      'instructor_name': instance.instructorName,
    };
