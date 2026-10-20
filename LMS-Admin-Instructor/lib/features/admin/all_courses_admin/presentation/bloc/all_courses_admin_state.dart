import 'package:equatable/equatable.dart';
import 'package:lms_admin_instructor/features/admin/all_courses_admin/domain/entity/course_admin_ui_model.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

abstract class AllCoursesAdminState extends Equatable {
  const AllCoursesAdminState();

  @override
  List<Object?> get props => [];
}

class AllCoursesAdminInitial extends AllCoursesAdminState {}

class AllCoursesAdminLoading extends AllCoursesAdminState {}

class AllCoursesAdminLoaded extends AllCoursesAdminState
    implements PaginatedState<CourseAdminItemUIModel, CourseAdminListUIModel> {
  final CourseAdminListUIModel courseListUIModel;
  @override
  final bool isPaginationLoading;

  const AllCoursesAdminLoaded({
    required this.courseListUIModel,
    this.isPaginationLoading = false,
  });

  @override
  CourseAdminListUIModel? get uiModel => courseListUIModel;

  AllCoursesAdminLoaded copyWith({
    CourseAdminListUIModel? courseListUIModel,
    bool? isPaginationLoading,
  }) {
    return AllCoursesAdminLoaded(
      courseListUIModel: courseListUIModel ?? this.courseListUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }

  @override
  List<Object?> get props => [courseListUIModel, isPaginationLoading];
}

class AllCoursesAdminError extends AllCoursesAdminState {
  final String message;

  const AllCoursesAdminError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteCourseAdminLoading extends AllCoursesAdminState {}

class DeleteCourseAdminSuccess extends AllCoursesAdminState {
  final String message;

  const DeleteCourseAdminSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteCourseAdminError extends AllCoursesAdminState {
  final String message;

  const DeleteCourseAdminError({required this.message});

  @override
  List<Object?> get props => [message];
}
