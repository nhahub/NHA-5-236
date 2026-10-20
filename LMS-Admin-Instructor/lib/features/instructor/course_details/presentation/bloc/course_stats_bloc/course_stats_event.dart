abstract class CourseStatsEvent {}

class GetCourseStatsEvent extends CourseStatsEvent {
  final String slug;

  GetCourseStatsEvent({required this.slug});
}
