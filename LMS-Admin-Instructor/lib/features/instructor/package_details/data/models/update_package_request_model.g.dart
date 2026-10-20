// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_package_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePackageRequestModel _$UpdatePackageRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdatePackageRequestModel(
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      courses:
          (json['courses'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdatePackageRequestModelToJson(
        UpdatePackageRequestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'courses': instance.courses,
    };
