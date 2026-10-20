import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/quiz_ui_model.dart';

part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel {
  @JsonKey(name: 'quiz_name')
  final String? quizName;
  final String? slug;
  @JsonKey(name: 'total_mark')
  final num? totalMark;
  @JsonKey(name: 'max_attempts')
  final num? maxAttempts;
  @JsonKey(name: 'course_name')
  final String? courseName;
  @JsonKey(name: 'attempts_used')
  final num? attemptsUsed;
  @JsonKey(name: 'best_score')
  final num? bestScore;
  @JsonKey(name: 'quiz_status')
  final String? quizStatus;
  final String? description;
  @JsonKey(name: 'passing_percentage')
  final num? passingPercentage;

  QuizModel({
    this.quizName,
    this.slug,
    this.totalMark,
    this.maxAttempts,
    this.courseName,
    this.attemptsUsed,
    this.bestScore,
    this.quizStatus,
    this.description,
    this.passingPercentage,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  QuizItemUIModel toEntity() {
    return QuizItemUIModel(
      quizName: quizName ?? '',
      totalMark: totalMark ?? 0,
      slug: slug ?? '',
    );
  }
}
