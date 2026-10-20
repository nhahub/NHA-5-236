import 'package:dartz/dartz.dart';
import '../../data/model/quiz_model/quiz_response_model.dart';
import '../../data/model/quiz_model/quiz_detail_model.dart';
import '../../data/model/quiz_model/course_quiz_create_model.dart';

abstract class QuizRepository {
  Future<Either<String, QuizResponseModel>> getQuizzesForCourse(
    String courseSlug, {
    int? page,
    int? pageSize,
  });
  Future<Either<String, QuizDetailResponseModel>> getQuizDetails(
    String quizSlug,
  );
  Future<Either<String, QuizDetailResponseModel>> createQuizForCourse(
    String courseSlug,
    CourseQuizCreateModel data,
  );
  Future<Either<String, QuizDetailResponseModel>> updateQuiz(
    String courseSlug,
    String quizSlug,
    CourseQuizCreateModel data,
  );
  Future<Either<String, Unit>> deleteQuiz(String courseSlug, String quizSlug);

  //? Questions
  Future<Either<String, List<QuestionModel>>> getQuizQuestions(String quizSlug);
  Future<Either<String, QuestionModel>> createQuestion(
    String quizSlug,
    Map<String, dynamic> data,
  );
  Future<Either<String, QuestionModel>> updateQuestion(
    String quizSlug,
    String questionSlug,
    Map<String, dynamic> data,
  );
  Future<Either<String, Unit>> deleteQuestion(
    String quizSlug,
    String questionSlug,
  );

  //? Choices
  Future<Either<String, List<ChoiceModel>>> getQuestionChoices(
    String quizSlug,
    String questionSlug,
  );
  Future<Either<String, ChoiceModel>> createChoice(
    String quizSlug,
    String questionSlug,
    Map<String, dynamic> data,
  );
  Future<Either<String, ChoiceModel>> updateChoice(
    String quizSlug,
    String questionSlug,
    String choiceSlug,
    Map<String, dynamic> data,
  );
  Future<Either<String, Unit>> deleteChoice(
    String quizSlug,
    String questionSlug,
    String choiceSlug,
  );
}
