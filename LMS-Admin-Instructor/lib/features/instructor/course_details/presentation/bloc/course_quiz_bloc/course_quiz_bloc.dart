import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/quiz_repository.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/quiz_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_state.dart';

class CourseQuizBloc extends Bloc<CourseQuizEvent, CourseQuizState>
    with
        PaginatedListMixin<
            CourseQuizEvent,
            CourseQuizState,
            QuizItemUIModel,
            QuizListUIModel,
            CourseQuizLoaded,
            CourseQuizError,
            CourseQuizLoading> {
  final QuizRepository quizRepository;
  CourseQuizBloc({required this.quizRepository}) : super(CourseQuizInitial()) {
    on<GetQuizzesForCourseEvent>(_onGetQuizzesForCourse);
    on<DeleteQuizEvent>(_onDeleteQuiz);
  }

  Future<void> _onDeleteQuiz(
    DeleteQuizEvent event,
    Emitter<CourseQuizState> emit,
  ) async {
    emit(DeleteQuizLoading());
    final result = await quizRepository.deleteQuiz(
      event.courseSlug,
      event.quizSlug,
    );
    result.fold(
      (error) => emit(DeleteQuizError(message: error)),
      (_) => emit(DeleteQuizSuccess()),
    );
  }

  Future<void> _onGetQuizzesForCourse(
    GetQuizzesForCourseEvent event,
    Emitter<CourseQuizState> emit,
  ) async {
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      emit(CourseQuizLoading());
    } else {
      emit((state as CourseQuizLoaded).copyWith(isPaginationLoading: true));
    }

    final response = await quizRepository.getQuizzesForCourse(
      event.courseSlug,
      page: pageToFetch,
      pageSize: event.pageSize,
    );

    response.fold(
      (error) => emit(CourseQuizError(message: error)),
      (responseModel) {
        handlePaginatedResponse(
          page: pageToFetch,
          newEntity: responseModel.toEntity(),
          currentState: state,
          emit: emit.call,
          loadedStateBuilder: (model, isPaging) =>
              CourseQuizLoaded(uiModel: model, isPaginationLoading: isPaging),
          errorStateBuilder: (msg) => CourseQuizError(message: msg),
          loadingStateBuilder: () => CourseQuizLoading(),
        );
      },
    );
  }
}