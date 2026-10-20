// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsResponseModel _$CourseDetailsResponseModelFromJson(
        Map<String, dynamic> json) =>
    CourseDetailsResponseModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CourseDetailsDataModel.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseDetailsResponseModelToJson(
        CourseDetailsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CourseDetailsDataModel _$CourseDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    CourseDetailsDataModel(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      category: json['category'] as String?,
      level: json['level'] as String?,
      image: json['image'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      isActive: json['is_active'] as bool?,
      instructorName: json['instructor_name'] as String?,
      instructorImage: json['instructor_image'] as String?,
      instructorBio: json['instructor_bio'] as String?,
      instructorLinks: json['instructor_links'] as List<dynamic>?,
      avgRating: (json['avg_rating'] as num?)?.toDouble(),
      ratingsCount: (json['ratings_count'] as num?)?.toInt(),
      isEnrolled: json['is_enrolled'] as bool?,
    );

Map<String, dynamic> _$CourseDetailsDataModelToJson(
        CourseDetailsDataModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'level': instance.level,
      'image': instance.image,
      'created_at': instance.createdAt?.toIso8601String(),
      'is_active': instance.isActive,
      'instructor_name': instance.instructorName,
      'instructor_image': instance.instructorImage,
      'instructor_bio': instance.instructorBio,
      'instructor_links': instance.instructorLinks,
      'avg_rating': instance.avgRating,
      'ratings_count': instance.ratingsCount,
      'is_enrolled': instance.isEnrolled,
    };
