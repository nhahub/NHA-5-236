import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';

abstract class CoursesInstructorState {}

class CoursesInstructorInitial extends CoursesInstructorState {}

class CoursesInstructorLoading extends CoursesInstructorState {}

class CoursesInstructorLoaded extends CoursesInstructorState
    implements PaginatedState<CourseInstructorItemUIModel, CourseInstructorListUIModel> {
  final CourseInstructorListUIModel courseListUIModel;
  @override
  final bool isPaginationLoading;

  @override
  CourseInstructorListUIModel? get uiModel => courseListUIModel;

  CoursesInstructorLoaded({
    required this.courseListUIModel,
    this.isPaginationLoading = false,
  });

  CoursesInstructorLoaded copyWith({
    CourseInstructorListUIModel? courseListUIModel,
    bool? isPaginationLoading,
  }) {
    return CoursesInstructorLoaded(
      courseListUIModel: courseListUIModel ?? this.courseListUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class CoursesInstructorError extends CoursesInstructorState {
  final String message;
  CoursesInstructorError({required this.message});
}

class AddCourseLoading extends CoursesInstructorState {}

class AddCourseSuccess extends CoursesInstructorState {
  final String message;
  AddCourseSuccess({required this.message});
}

class AddCourseError extends CoursesInstructorState {
  final String message;
  AddCourseError({required this.message});
}
