
abstract class CourseMaterialsEvent {}

class GetCourseMaterialsEvent extends CourseMaterialsEvent {
  final String slug;
  final int? page;
  final int? pageSize;

  GetCourseMaterialsEvent({
    required this.slug,
    this.page,
    this.pageSize,
  });
}

