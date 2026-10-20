import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_quiz_create_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseQuizCreateModel extends Equatable {
  final String? slug;
  @JsonKey(name: 'quiz_name')
  final String? quizName;
  final String? description;
  @JsonKey(name: "max_attempts")
  final int? maxAttempts;
  @JsonKey(name: "passing_percentage")
  final int? passingPercentage;
  final List<QuestionCreateModel>? questions;

  CourseQuizCreateModel({
    this.slug,
    this.quizName,
    this.description,
    this.maxAttempts,
    this.passingPercentage,
    this.questions,
  });

  factory CourseQuizCreateModel.fromJson(Map<String, dynamic> json) =>
      _$CourseQuizCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseQuizCreateModelToJson(this);

  @override
  List<Object?> get props => [
    slug,
    quizName,
    description,
    maxAttempts,
    passingPercentage,
    questions,
  ];
}

@JsonSerializable(explicitToJson: true)
class QuestionCreateModel extends Equatable {
  @JsonKey(name: 'question_name')
  final String? questionName;
  final int? mark;
  @JsonKey(name: 'question_type')
  final String? questionType;
  final List<ChoiceCreateModel>? choices;

  QuestionCreateModel({
    this.questionName,
    this.mark,
    this.questionType,
    this.choices,
  });

  factory QuestionCreateModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionCreateModelToJson(this);

  @override
  List<Object?> get props => [questionName, mark, questionType, choices];
}

@JsonSerializable()
class ChoiceCreateModel extends Equatable {
  @JsonKey(name: 'choice_name')
  final String? choiceName;
  @JsonKey(name: 'isCorrect')
  final bool? isCorrect;

  ChoiceCreateModel({
    this.choiceName,
    this.isCorrect,
  });

  factory ChoiceCreateModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceCreateModelToJson(this);

  @override
  List<Object?> get props => [choiceName, isCorrect];
}
