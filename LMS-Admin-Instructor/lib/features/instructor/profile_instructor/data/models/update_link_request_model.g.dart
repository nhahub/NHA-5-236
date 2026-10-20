// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_link_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLinkRequestModel _$UpdateLinkRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateLinkRequestModel(
      slug: json['slug'] as String,
      platformName: json['platformName'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$UpdateLinkRequestModelToJson(
        UpdateLinkRequestModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'platformName': instance.platformName,
      'url': instance.url,
    };
