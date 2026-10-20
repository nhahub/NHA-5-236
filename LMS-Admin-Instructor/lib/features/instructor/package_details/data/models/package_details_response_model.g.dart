// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDetailsResponseModel _$PackageDetailsResponseModelFromJson(
        Map<String, dynamic> json) =>
    PackageDetailsResponseModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PackageDetailsDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackageDetailsResponseModelToJson(
        PackageDetailsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

PackageDetailsDataModel _$PackageDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    PackageDetailsDataModel(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      price: json['price'],
      coursesCount: (json['courses_count'] as num?)?.toInt(),
      isEnrolled: json['is_enrolled'] as bool?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map(
              (e) => PackageCourseItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageDetailsDataModelToJson(
        PackageDetailsDataModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'price': instance.price,
      'courses_count': instance.coursesCount,
      'is_enrolled': instance.isEnrolled,
      'courses': instance.courses,
    };

PackageCourseItemModel _$PackageCourseItemModelFromJson(
        Map<String, dynamic> json) =>
    PackageCourseItemModel(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      avgRating: json['avg_rating'],
      ratingsCount: (json['ratings_count'] as num?)?.toInt(),
      studentsCount: (json['students_count'] as num?)?.toInt(),
      isEnrolled: json['is_enrolled'] as bool?,
      instructorName: json['instructor_name'] as String?,
    );

Map<String, dynamic> _$PackageCourseItemModelToJson(
        PackageCourseItemModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'image': instance.image,
      'avg_rating': instance.avgRating,
      'ratings_count': instance.ratingsCount,
      'students_count': instance.studentsCount,
      'is_enrolled': instance.isEnrolled,
      'instructor_name': instance.instructorName,
    };
