import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/package_details_ui_model.dart';

part 'package_details_response_model.g.dart';

@JsonSerializable()
class PackageDetailsResponseModel {
  @JsonKey(name: 'success')
  final bool? success;
  
  @JsonKey(name: 'status')
  final int? status;
  
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'data')
  final PackageDetailsDataModel? data;

  PackageDetailsResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory PackageDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailsResponseModelToJson(this);
}

@JsonSerializable()
class PackageDetailsDataModel {
  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'price')
  final dynamic price;

  @JsonKey(name: 'courses_count')
  final int? coursesCount;

  @JsonKey(name: 'is_enrolled')
  final bool? isEnrolled;

  @JsonKey(name: 'courses')
  final List<PackageCourseItemModel>? courses;

  PackageDetailsDataModel({
    this.title,
    this.slug,
    this.description,
    this.price,
    this.coursesCount,
    this.isEnrolled,
    this.courses,
  });

  factory PackageDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDetailsDataModelToJson(this);

  PackageDetailsUIModel toEntity() {
    return PackageDetailsUIModel(
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      price: price?.toString() ?? '0.0',
      coursesCount: coursesCount ?? 0,
      isEnrolled: isEnrolled ?? false,
      courses: courses?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class PackageCourseItemModel {
  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'avg_rating')
  final dynamic avgRating;

  @JsonKey(name: 'ratings_count')
  final int? ratingsCount;

  @JsonKey(name: 'students_count')
  final int? studentsCount;

  @JsonKey(name: 'is_enrolled')
  final bool? isEnrolled;

  @JsonKey(name: 'instructor_name')
  final String? instructorName;

  PackageCourseItemModel({
    this.title,
    this.slug,
    this.image,
    this.avgRating,
    this.ratingsCount,
    this.studentsCount,
    this.isEnrolled,
    this.instructorName,
  });

  factory PackageCourseItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackageCourseItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageCourseItemModelToJson(this);

  PackageCourseItemUIModel toEntity() {
    return PackageCourseItemUIModel(
      title: title ?? '',
      slug: slug ?? '',
      image: image,
      avgRating: (avgRating is int) ? (avgRating as int).toDouble() : (avgRating as double? ?? 0.0),
      ratingsCount: ratingsCount ?? 0,
      studentsCount: studentsCount ?? 0,
      isEnrolled: isEnrolled ?? false,
      instructorName: instructorName ?? '',
    );
  }
}
