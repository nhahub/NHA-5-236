// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorProfileResponseModel _$InstructorProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    InstructorProfileResponseModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : InstructorProfileDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstructorProfileResponseModelToJson(
        InstructorProfileResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

InstructorProfileDataModel _$InstructorProfileDataModelFromJson(
        Map<String, dynamic> json) =>
    InstructorProfileDataModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      slug: json['slug'] as String?,
      bio: json['bio'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => InstructorLinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$InstructorProfileDataModelToJson(
        InstructorProfileDataModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'slug': instance.slug,
      'bio': instance.bio,
      'description': instance.description,
      'image': instance.image,
      'links': instance.links,
      'created_at': instance.createdAt,
    };

InstructorLinkModel _$InstructorLinkModelFromJson(Map<String, dynamic> json) =>
    InstructorLinkModel(
      slug: json['slug'] as String?,
      platformName: json['platformName'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$InstructorLinkModelToJson(
        InstructorLinkModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'platformName': instance.platformName,
      'url': instance.url,
    };
