import 'package:flutter_bloc/flutter_bloc.dart';
import 'manage_quiz_instructor_event.dart';
import 'manage_quiz_instructor_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/quiz_repository.dart';

class ManageQuizInstructorBloc
    extends Bloc<ManageQuizInstructorEvent, ManageQuizInstructorState> {
  final QuizRepository quizRepository;

  ManageQuizInstructorBloc({required this.quizRepository})
      : super(ManageQuizInstructorInitial()) {
    on<GetQuizDetailsEvent>(_onGetQuizDetails);
    on<CreateQuizEvent>(_onCreateQuiz);
    on<UpdateQuizEvent>(_onUpdateQuiz);
  }

  Future<void> _onGetQuizDetails(
    GetQuizDetailsEvent event,
    Emitter<ManageQuizInstructorState> emit,
  ) async {
    emit(GetQuizDetailsLoading());
    final result = await quizRepository.getQuizDetails(event.quizSlug);
    result.fold(
      (error) => emit(GetQuizDetailsError(error)),
      (response) {
        if (response.data != null) {
          emit(GetQuizDetailsSuccess(response.data!));
        } else {
          emit(GetQuizDetailsError('No data found'));
        }
      },
    );
  }

  Future<void> _onCreateQuiz(
    CreateQuizEvent event,
    Emitter<ManageQuizInstructorState> emit,
  ) async {
    emit(ManageQuizInstructorLoading());
    final result = await quizRepository.createQuizForCourse(
      event.courseSlug,
      event.quizData,
    );
    result.fold(
      (error) => emit(ManageQuizInstructorError(error)),
      (response) => emit(ManageQuizInstructorSuccess(response)),
    );
  }

  Future<void> _onUpdateQuiz(
    UpdateQuizEvent event,
    Emitter<ManageQuizInstructorState> emit,
  ) async {
    emit(ManageQuizInstructorLoading());
    final result = await quizRepository.updateQuiz(
      event.courseSlug,
      event.quizSlug,
      event.quizData,
    );
    result.fold(
      (error) => emit(ManageQuizInstructorError(error)),
      (response) => emit(ManageQuizInstructorSuccess(response)),
    );
  }
}