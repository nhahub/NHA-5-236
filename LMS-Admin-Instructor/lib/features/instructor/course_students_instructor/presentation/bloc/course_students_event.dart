abstract class CourseStudentsEvent {
  const CourseStudentsEvent();
}

class GetCourseStudentsEvent extends CourseStudentsEvent {
  final String slug;
  final int? page;
  final int? pageSize;
  final String? search;

  GetCourseStudentsEvent({
    required this.slug,
    this.page,
    this.pageSize,
    this.search,
  });
}
