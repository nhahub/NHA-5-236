class InstructorAdminEvent {}

class GetInstructorAdminEvent extends InstructorAdminEvent {
  final int? page;
  final int? pageSize;
  final String? search;
  GetInstructorAdminEvent({this.page, this.pageSize, this.search});
}

class AddInstructorEvent extends InstructorAdminEvent {
  final String first_name;
  final String last_name;
  final String email;

  AddInstructorEvent({
    required this.first_name,
    required this.last_name,
    required this.email,
  });
}

class GetInstructorBySlugEvent extends InstructorAdminEvent {
  final String slug;
  GetInstructorBySlugEvent({required this.slug});
}

class DeleteInstructorEvent extends InstructorAdminEvent {
  final String slug;
  DeleteInstructorEvent({required this.slug});
}
