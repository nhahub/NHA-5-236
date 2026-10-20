import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import '../../../domain/entity/quiz_ui_model.dart';

abstract class CourseQuizState {}

class CourseQuizInitial extends CourseQuizState {}

class CourseQuizLoading extends CourseQuizState {}

class CourseQuizLoaded extends CourseQuizState
    implements PaginatedState<QuizItemUIModel, QuizListUIModel> {
  @override
  final QuizListUIModel? uiModel;
  @override
  final bool isPaginationLoading;

  CourseQuizLoaded({
    this.uiModel,
    this.isPaginationLoading = false,
  });

  CourseQuizLoaded copyWith({
    QuizListUIModel? uiModel,
    bool? isPaginationLoading,
  }) {
    return CourseQuizLoaded(
      uiModel: uiModel ?? this.uiModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class CourseQuizError extends CourseQuizState {
  final String message;
  CourseQuizError({required this.message});
}

class DeleteQuizLoading extends CourseQuizState {}

class DeleteQuizSuccess extends CourseQuizState {}

class DeleteQuizError extends CourseQuizState {
  final String message;
  DeleteQuizError({required this.message});
}
