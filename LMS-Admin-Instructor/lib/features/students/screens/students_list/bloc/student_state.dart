import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import 'package:lms_admin_instructor/features/students/domain/entity/student_ui_model.dart';

class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState
    implements PaginatedState<StudentItemUIModel, StudentUIModel> {
  final StudentUIModel studentUIModel;
  @override
  final bool isPaginationLoading;

  @override
  StudentUIModel? get uiModel => studentUIModel;

  StudentLoaded({
    required this.studentUIModel,
    this.isPaginationLoading = false,
  });

  StudentLoaded copyWith({
    StudentUIModel? studentUIModel,
    bool? isPaginationLoading,
  }) {
    return StudentLoaded(
      studentUIModel: studentUIModel ?? this.studentUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class StudentError extends StudentState {
  final String message;
  StudentError({required this.message});
}
