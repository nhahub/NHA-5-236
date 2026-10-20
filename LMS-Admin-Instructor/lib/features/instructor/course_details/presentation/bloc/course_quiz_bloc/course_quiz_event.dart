abstract class CourseQuizEvent {}

class GetQuizzesForCourseEvent extends CourseQuizEvent {
  final String courseSlug;
  final int? page;
  final int? pageSize;

  GetQuizzesForCourseEvent({
    required this.courseSlug,
    this.page,
    this.pageSize,
  });
}

class DeleteQuizEvent extends CourseQuizEvent {
  final String courseSlug;
  final String quizSlug;

  DeleteQuizEvent({required this.courseSlug, required this.quizSlug});
}