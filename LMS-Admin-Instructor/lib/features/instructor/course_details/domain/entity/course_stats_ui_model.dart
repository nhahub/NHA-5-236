class CourseStatsUIModel {
  final String courseSlug;
  final String courseTitle;
  final int totalMaterials;
  final int totalVideos;
  final int totalQuizzes;
  final int totalStudents;

  CourseStatsUIModel({
    required this.courseSlug,
    required this.courseTitle,
    required this.totalMaterials,
    required this.totalVideos,
    required this.totalQuizzes,
    required this.totalStudents,
  });

  CourseStatsUIModel copyWith({
    String? courseSlug,
    String? courseTitle,
    int? totalMaterials,
    int? totalVideos,
    int? totalQuizzes,
    int? totalStudents,
  }) {
    return CourseStatsUIModel(
      courseSlug: courseSlug ?? this.courseSlug,
      courseTitle: courseTitle ?? this.courseTitle,
      totalMaterials: totalMaterials ?? this.totalMaterials,
      totalVideos: totalVideos ?? this.totalVideos,
      totalQuizzes: totalQuizzes ?? this.totalQuizzes,
      totalStudents: totalStudents ?? this.totalStudents,
    );
  }
}
