// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminProfileResponseModel _$AdminProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => AdminProfileResponseModel(
  success: json['success'] as bool?,
  status: (json['status'] as num?)?.toInt(),
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : AdminProfileModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AdminProfileResponseModelToJson(
  AdminProfileResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

AdminProfileModel _$AdminProfileModelFromJson(Map<String, dynamic> json) =>
    AdminProfileModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$AdminProfileModelToJson(AdminProfileModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'slug': instance.slug,
      'image': instance.image,
      'created_at': instance.createdAt,
    };
