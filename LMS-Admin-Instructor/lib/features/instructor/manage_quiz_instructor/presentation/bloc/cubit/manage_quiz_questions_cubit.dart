import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';

class ManageQuizQuestionsCubit extends Cubit<List<QuestionCreateModel>> {
  ManageQuizQuestionsCubit() : super([]);

  void init(List<QuestionCreateModel> initialQuestions) {
    if (initialQuestions.isEmpty) {
      addQuestion();
    } else {
      emit(List.from(initialQuestions));
    }
  }

  void addQuestion() {
    final newQuestion = QuestionCreateModel(
      questionName: '',
      mark: 1,
      questionType: 'single',
      choices: [
        ChoiceCreateModel(choiceName: '', isCorrect: true),
        ChoiceCreateModel(choiceName: '', isCorrect: false),
      ],
    );
    emit([...state, newQuestion]);
  }

  void removeQuestion(int index) {
    if (state.length > 1) {
      final updatedQuestions = List<QuestionCreateModel>.from(state);
      updatedQuestions.removeAt(index);
      emit(updatedQuestions);
    }
  }

  void updateQuestion(int index, QuestionCreateModel updatedQuestion) {
    if (index >= 0 && index < state.length) {
      if (state[index] == updatedQuestion) return;
      final updatedQuestions = List<QuestionCreateModel>.from(state);
      updatedQuestions[index] = updatedQuestion;
      emit(updatedQuestions);
    }
  }

  List<QuestionCreateModel> get questions => state;
}
