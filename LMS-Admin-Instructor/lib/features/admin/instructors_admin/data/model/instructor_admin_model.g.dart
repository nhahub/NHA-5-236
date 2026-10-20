// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

InstructorAdminModel _$InstructorAdminModelFromJson(
        Map<String, dynamic> json) =>
    InstructorAdminModel(
      slug: json['slug'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      bio: json['bio'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => InstructorLinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      joindata: json['created_at'] as String?,
    );

Map<String, dynamic> _$InstructorAdminModelToJson(
        InstructorAdminModel instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'slug': instance.slug,
      'bio': instance.bio,
      'description': instance.description,
      'image': instance.image,
      'created_at': instance.joindata,
      'links': instance.links,
    };
