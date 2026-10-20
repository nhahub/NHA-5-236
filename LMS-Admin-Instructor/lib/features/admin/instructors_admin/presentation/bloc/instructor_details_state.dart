import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_course_admin_ui_model.dart';

class InstructorDetailsState {}

class InstructorDetailsInitial extends InstructorDetailsState {}

class InstructorCoursesLoading extends InstructorDetailsState {}

class InstructorCoursesLoaded extends InstructorDetailsState {
  final InstructorCourseAdminUiModel instructorCourseAdminUiModel;
  final bool isPaginationLoading;

  InstructorCoursesLoaded({
    required this.instructorCourseAdminUiModel,
    this.isPaginationLoading = false,
  });

  InstructorCoursesLoaded copyWith({
    final InstructorCourseAdminUiModel? instructorCourseAdminUiModel,
    final bool? isPaginationLoading,
  }) {
    return InstructorCoursesLoaded(
      instructorCourseAdminUiModel:
          instructorCourseAdminUiModel ?? this.instructorCourseAdminUiModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class InstructorCoursesError extends InstructorDetailsState {
  final String message;
  InstructorCoursesError({required this.message});
}
