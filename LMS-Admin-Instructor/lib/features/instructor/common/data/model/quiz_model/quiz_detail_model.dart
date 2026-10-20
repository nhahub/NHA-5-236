import 'package:json_annotation/json_annotation.dart';

part 'quiz_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizDetailResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final QuizDetailModel? data;

  QuizDetailResponseModel({this.success, this.status, this.message, this.data});

  factory QuizDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuizDetailResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizDetailResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuizDetailModel {
  @JsonKey(name: 'quiz_name')
  final String? quizName;
  final String? slug;
  final String? description;
  @JsonKey(name: 'total_mark')
  final num? totalMark;
  @JsonKey(name: 'max_attempts')
  final num? maxAttempts;
  @JsonKey(name: 'course_name')
  final String? courseName;
  @JsonKey(name: 'passing_percentage')
  final num? passingPercentage;
  final List<QuestionModel>? questions;

  QuizDetailModel({
    this.quizName,
    this.slug,
    this.description,
    this.totalMark,
    this.maxAttempts,
    this.courseName,
    this.passingPercentage,
    this.questions,
  });

  factory QuizDetailModel.fromJson(Map<String, dynamic> json) =>
      _$QuizDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuestionModel {
  @JsonKey(name: 'question_name')
  final String? questionName;
  final String? slug;
  final num? mark;
  @JsonKey(name: 'question_type')
  final String? questionType;
  final List<ChoiceModel>? choices;

  QuestionModel({
    this.questionName,
    this.slug,
    this.mark,
    this.questionType,
    this.choices,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class ChoiceModel {
  @JsonKey(name: 'choice_name')
  final String? choiceName;
  final String? slug;
  @JsonKey(name: 'is_correct')
  final bool? isCorrect;

  ChoiceModel({this.choiceName, this.slug, this.isCorrect});

  factory ChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}
