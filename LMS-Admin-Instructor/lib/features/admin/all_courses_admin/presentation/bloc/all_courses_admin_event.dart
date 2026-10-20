import 'package:equatable/equatable.dart';

abstract class AllCoursesAdminEvent extends Equatable {
  const AllCoursesAdminEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCoursesAdminEvent extends AllCoursesAdminEvent {
  final int? page;
  final int? pageSize;
  final String? search;

  const GetAllCoursesAdminEvent({this.page, this.pageSize, this.search});

  @override
  List<Object?> get props => [page, pageSize, search];
}

class DeleteCourseAdminEvent extends AllCoursesAdminEvent {
  final String slug;

  const DeleteCourseAdminEvent({required this.slug});

  @override
  List<Object?> get props => [slug];
}
