class StudentEvent {}

class GetStudentsEvent extends StudentEvent {
  final int? page;
  final int? pageSize;
  final String? search;
  GetStudentsEvent({this.page, this.pageSize, this.search});
}

class DeleteStudentEvent extends StudentEvent {
  final String slug;
  DeleteStudentEvent({required this.slug});
}
