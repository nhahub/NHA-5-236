import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';

class QuizListUIModel extends PaginatedUIModel<QuizItemUIModel> {
  final List<QuizItemUIModel> quizzes;
  @override
  final int totalPages;
  @override
  final int currentPage;
  final int totalQuizzes;

  QuizListUIModel({
    required this.quizzes,
    required this.totalPages,
    required this.currentPage,
    required this.totalQuizzes,
  }) : super(
          items: quizzes,
          totalPages: totalPages,
          currentPage: currentPage,
        );

  @override
  QuizListUIModel copyWithItems(
    List<QuizItemUIModel> newItems, {
    int? totalPages,
    int? currentPage,
  }) {
    return QuizListUIModel(
      quizzes: newItems,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      totalQuizzes: totalQuizzes,
    );
  }
}

class QuizItemUIModel {
  final String quizName;
  final num totalMark;
  final String slug;

  QuizItemUIModel({
    required this.quizName,
    required this.totalMark,
    required this.slug,
  });
}
