// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_admin_respomse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorAdminResponseModel _$InstructorAdminResponseModelFromJson(
        Map<String, dynamic> json) =>
    InstructorAdminResponseModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: InstructorAdminData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstructorAdminResponseModelToJson(
        InstructorAdminResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

InstructorAdminData _$InstructorAdminDataFromJson(Map<String, dynamic> json) =>
    InstructorAdminData(
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalInstructors: (json['total_instructors'] as num?)?.toInt(),
      instructors: (json['instructors'] as List<dynamic>?)
          ?.map((e) => InstructorAdminModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstructorAdminDataToJson(
        InstructorAdminData instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_instructors': instance.totalInstructors,
      'instructors': instance.instructors,
    };
