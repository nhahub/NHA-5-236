// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_materials_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseMaterialsResponseModel _$CourseMaterialsResponseModelFromJson(
        Map<String, dynamic> json) =>
    CourseMaterialsResponseModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: CourseMaterialsDataModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseMaterialsResponseModelToJson(
        CourseMaterialsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CourseMaterialsDataModel _$CourseMaterialsDataModelFromJson(
        Map<String, dynamic> json) =>
    CourseMaterialsDataModel(
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalMaterials: (json['total_materials'] as num?)?.toInt(),
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => CourseMaterialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseMaterialsDataModelToJson(
        CourseMaterialsDataModel instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_materials': instance.totalMaterials,
      'materials': instance.materials,
    };
