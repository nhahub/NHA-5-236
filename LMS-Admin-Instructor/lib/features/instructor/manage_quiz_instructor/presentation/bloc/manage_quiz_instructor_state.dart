import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/quiz_detail_model.dart';

abstract class ManageQuizInstructorState {}

class ManageQuizInstructorInitial extends ManageQuizInstructorState {}

class ManageQuizInstructorLoading extends ManageQuizInstructorState {}

class ManageQuizInstructorSuccess extends ManageQuizInstructorState {
  final QuizDetailResponseModel quizResponse;
  ManageQuizInstructorSuccess(this.quizResponse);
}

class ManageQuizInstructorError extends ManageQuizInstructorState {
  final String message;
  ManageQuizInstructorError(this.message);
}

class GetQuizDetailsLoading extends ManageQuizInstructorState {}

class GetQuizDetailsSuccess extends ManageQuizInstructorState {
  final QuizDetailModel quiz;
  GetQuizDetailsSuccess(this.quiz);
}

class GetQuizDetailsError extends ManageQuizInstructorState {
  final String message;
  GetQuizDetailsError(this.message);
}