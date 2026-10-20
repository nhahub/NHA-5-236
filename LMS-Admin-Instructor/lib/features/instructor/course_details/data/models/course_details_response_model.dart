import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/course_details_ui_model.dart';
part 'course_details_response_model.g.dart';

@JsonSerializable()
class CourseDetailsResponseModel {
  @JsonKey(name: 'success')
  final bool? success;
  
  @JsonKey(name: 'status')
  final int? status;
  
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'data')
  final CourseDetailsDataModel? data;

  CourseDetailsResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory CourseDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailsResponseModelToJson(this);
}

@JsonSerializable()
class CourseDetailsDataModel {
  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'level')
  final String? level;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'instructor_name')
  final String? instructorName;

  @JsonKey(name: 'instructor_image')
  final String? instructorImage;

  @JsonKey(name: 'instructor_bio')
  final String? instructorBio;

  @JsonKey(name: 'instructor_links')
  final List<dynamic>? instructorLinks;

  @JsonKey(name: 'avg_rating')
  final double? avgRating;

  @JsonKey(name: 'ratings_count')
  final int? ratingsCount;

  @JsonKey(name: 'is_enrolled')
  final bool? isEnrolled;

  CourseDetailsDataModel({
    this.title,
    this.slug,
    this.description,
    this.price,
    this.category,
    this.level,
    this.image,
    this.createdAt,
    this.isActive,
    this.instructorName,
    this.instructorImage,
    this.instructorBio,
    this.instructorLinks,
    this.avgRating,
    this.ratingsCount,
    this.isEnrolled,
  });

  factory CourseDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailsDataModelToJson(this);

  CourseDetailsUIModel toEntity() {
    return CourseDetailsUIModel(
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      price: price ?? '0.0',
      category: category ?? '',
      level: level ?? '',
      image: image ?? '',
      createdAt: createdAt?.toIso8601String() ?? '',
      isActive: isActive ?? true,
      instructorName: instructorName ?? '',
      instructorImage: instructorImage ?? '',
      instructorBio: instructorBio ?? '',
      avgRating: avgRating ?? 0.0,
      ratingsCount: ratingsCount ?? 0,
      isEnrolled: isEnrolled ?? false,
    );
  }
}
