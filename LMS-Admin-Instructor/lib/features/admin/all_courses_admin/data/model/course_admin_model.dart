import 'package:lms_admin_instructor/features/admin/all_courses_admin/domain/entity/course_admin_ui_model.dart';

class CourseAdminModel {
  final String title;
  final String slug;
  final String? description;
  final String? price;
  final String? category;
  final String? level;
  final String? image;
  final String? createdAt;
  final bool? isActive;
  final String? instructorName;
  final double? avgRating;
  final int? ratingsCount;
  final int? studentsCount;

  CourseAdminModel({
    required this.title,
    required this.slug,
    this.description,
    this.price,
    this.category,
    this.level,
    this.image,
    this.createdAt,
    this.isActive,
    this.instructorName,
    this.avgRating,
    this.ratingsCount,
    this.studentsCount,
  });

  factory CourseAdminModel.fromJson(Map<String, dynamic> json) {
    return CourseAdminModel(
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'],
      price: json['price'],
      category: json['category'],
      level: json['level'],
      image: json['image'],
      createdAt: json['created_at'],
      isActive: json['is_active'],
      instructorName: json['instructor_name'],
      avgRating: json['avg_rating'] != null
          ? (json['avg_rating'] as num).toDouble()
          : null,
      ratingsCount: json['ratings_count'] ?? 0,
      studentsCount: json['students_count'] ?? 0,
    );
  }

  CourseAdminItemUIModel toEntity() {
    return CourseAdminItemUIModel(
      slug: slug,
      title: title,
      instructorName: instructorName ?? ' ',
      studentsCount: studentsCount ?? 0,
      ratingsCount: ratingsCount ?? 0,
      createdAt: createdAt ?? ' ',
      image: image,
    );
  }
}
