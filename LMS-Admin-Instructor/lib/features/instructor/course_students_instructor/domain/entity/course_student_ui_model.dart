import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

class CourseStudentsListUIModel extends PaginatedUIModel<CourseStudentItemUIModel> {
  final List<CourseStudentItemUIModel> students;
  final int totalStudents;
  @override
  final int totalPages;
  @override
  final int currentPage;

  CourseStudentsListUIModel({
    required this.students,
    required this.totalStudents,
    required this.totalPages,
    required this.currentPage,
  }) : super(items: students, totalPages: totalPages, currentPage: currentPage);

  @override
  CourseStudentsListUIModel copyWithItems(
    List<CourseStudentItemUIModel> newItems, {
    int? totalPages,
    int? currentPage,
  }) {
    return CourseStudentsListUIModel(
      students: newItems,
      totalStudents: totalStudents,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  CourseStudentsListUIModel copyWith({
    List<CourseStudentItemUIModel>? students,
    int? totalStudents,
    int? totalPages,
    int? currentPage,
  }) {
    return CourseStudentsListUIModel(
      students: students ?? this.students,
      totalStudents: totalStudents ?? this.totalStudents,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class CourseStudentItemUIModel {
  final String name;
  final String email;
  final String avatar;
  final String enrollmentDate;
  final double progress; 
  final String slug;

  CourseStudentItemUIModel({
    required this.name,
    required this.email,
    required this.avatar,
    required this.enrollmentDate,
    required this.progress,
    required this.slug,
  });
}
