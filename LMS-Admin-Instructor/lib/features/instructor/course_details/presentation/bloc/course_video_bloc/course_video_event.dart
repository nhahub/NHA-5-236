abstract class CourseVideoEvent {}

class GetCourseVideosEvent extends CourseVideoEvent {
  final String courseSlug;

  GetCourseVideosEvent({required this.courseSlug});
}

class DeleteVideoEvent extends CourseVideoEvent {
  final String videoSlug;
  final String courseSlug;

  DeleteVideoEvent({required this.videoSlug, required this.courseSlug});
}
