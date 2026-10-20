// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_link_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLinkRequestModel _$CreateLinkRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateLinkRequestModel(
      platformName: json['platformName'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$CreateLinkRequestModelToJson(
        CreateLinkRequestModel instance) =>
    <String, dynamic>{
      'platformName': instance.platformName,
      'url': instance.url,
    };
