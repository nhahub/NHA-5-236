// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_material_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMaterialResponseModel _$UpdateMaterialResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdateMaterialResponseModel(
      success: json['success'] as bool,
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: CourseMaterialModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateMaterialResponseModelToJson(
        UpdateMaterialResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
