class CourseDetailsUIModel {
  final String title;
  final String slug;
  final String description;
  final String price;
  final String category;
  final String level;
  final String image;
  final String createdAt;
  final bool isActive;
  final String instructorName;
  final String instructorImage;
  final String instructorBio;
  final double avgRating;
  final int ratingsCount;
  final bool isEnrolled;

  CourseDetailsUIModel({
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.category,
    required this.level,
    required this.image,
    required this.createdAt,
    required this.isActive,
    required this.instructorName,
    required this.instructorImage,
    required this.instructorBio,
    required this.avgRating,
    required this.ratingsCount,
    required this.isEnrolled,
  });

  CourseDetailsUIModel copyWith({
    String? title,
    String? slug,
    String? description,
    String? price,
    String? category,
    String? level,
    String? image,
    String? createdAt,
    bool? isActive,
    String? instructorName,
    String? instructorImage,
    String? instructorBio,
    double? avgRating,
    int? ratingsCount,
    bool? isEnrolled,
  }) {
    return CourseDetailsUIModel(
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      level: level ?? this.level,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      instructorName: instructorName ?? this.instructorName,
      instructorImage: instructorImage ?? this.instructorImage,
      instructorBio: instructorBio ?? this.instructorBio,
      avgRating: avgRating ?? this.avgRating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      isEnrolled: isEnrolled ?? this.isEnrolled,
    );
  }
}
