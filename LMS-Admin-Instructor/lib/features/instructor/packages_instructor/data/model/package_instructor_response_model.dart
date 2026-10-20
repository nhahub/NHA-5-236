import 'package:lms_admin_instructor/features/instructor/packages_instructor/domain/entity/instructor_package_ui_model.dart';

class InstructorPackagesListResponseModel {
  final int totalPackages;
  final int totalPages;
  final int currentPage;
  final List<PackageInstructorResponseModel> packages;

  InstructorPackagesListResponseModel({
    required this.totalPackages,
    required this.totalPages,
    required this.currentPage,
    required this.packages,
  });

  factory InstructorPackagesListResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return InstructorPackagesListResponseModel(
      totalPackages: data['total_packages'] ?? 0,
      totalPages: data['total_pages'] ?? 1,
      currentPage: data['current_page'] ?? 1,
      packages: (data['packages'] as List<dynamic>?)
              ?.map((e) => PackageInstructorResponseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  InstructorPackageListUIModel toEntity() {
    return InstructorPackageListUIModel(
      totalPackages: totalPackages,
      totalPages: totalPages,
      currentPage: currentPage,
      packages: packages.map((e) => e.toEntity()).toList(),
    );
  }
}

class PackageInstructorResponseModel {
  final String title;
  final String instructorName;
  final String slug;
  final String description;
  final String price;
  final String createdAt;
  final int coursesCount;
  final double avgRating;
  final List<String> categories;
  final List<String> courseSlugs;
  final bool? isEnrolled;

  PackageInstructorResponseModel({
    required this.title,
    required this.instructorName,
    required this.slug,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.coursesCount,
    required this.avgRating,
    required this.categories,
    required this.courseSlugs,
    this.isEnrolled,
  });

  factory PackageInstructorResponseModel.fromJson(Map<String, dynamic> json) {
    return PackageInstructorResponseModel(
      title: json['title'] ?? '',
      instructorName: json['instructor_name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '0.00',
      createdAt: json['created_at'] ?? '',
      coursesCount: json['courses_count'] ?? 0,
      avgRating: (json['avg_rating'] as num?)?.toDouble() ?? 0.0,
      categories: (json['categories'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      courseSlugs: (json['course_slugs'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      isEnrolled: json['is_enrolled'] as bool?,
    );
  }

  InstructorPackageItemUIModel toEntity() {
    return InstructorPackageItemUIModel(
      slug: slug,
      title: title,
      description: description,
      price: price,
      coursesCount: coursesCount,
      avgRating: avgRating,
      categories: categories,
      courseSlugs: courseSlugs,
      instructorName: instructorName,
      createdAt: createdAt,
    );
  }
}
