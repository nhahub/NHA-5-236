class PackageDetailsUIModel {
  final String title;
  final String slug;
  final String description;
  final String price;
  final int coursesCount;
  final bool isEnrolled;
  final List<PackageCourseItemUIModel> courses;

  PackageDetailsUIModel({
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.coursesCount,
    required this.isEnrolled,
    required this.courses,
  });
}

class PackageCourseItemUIModel {
  final String title;
  final String slug;
  final String? image;
  final double avgRating;
  final int ratingsCount;
  final int studentsCount;
  final bool isEnrolled;
  final String instructorName;

  PackageCourseItemUIModel({
    required this.title,
    required this.slug,
    this.image,
    required this.avgRating,
    required this.ratingsCount,
    required this.studentsCount,
    required this.isEnrolled,
    required this.instructorName,
  });
}
