import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import '../../domain/entity/course_student_ui_model.dart';

abstract class CourseStudentsState {}

class CourseStudentsInitial extends CourseStudentsState {}

class CourseStudentsLoading extends CourseStudentsState {}

class CourseStudentsLoaded extends CourseStudentsState
    implements PaginatedState<CourseStudentItemUIModel, CourseStudentsListUIModel> {
  final CourseStudentsListUIModel studentsListUIModel;
  
  @override
  final bool isPaginationLoading;

  @override
  CourseStudentsListUIModel? get uiModel => studentsListUIModel;

  CourseStudentsLoaded({
    required this.studentsListUIModel,
    this.isPaginationLoading = false,
  });

  CourseStudentsLoaded copyWith({
    CourseStudentsListUIModel? studentsListUIModel,
    bool? isPaginationLoading,
  }) {
    return CourseStudentsLoaded(
      studentsListUIModel: studentsListUIModel ?? this.studentsListUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class CourseStudentsError extends CourseStudentsState {
  final String message;
  CourseStudentsError(this.message);
}
