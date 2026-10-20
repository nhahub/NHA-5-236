// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_quiz_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseQuizCreateModel _$CourseQuizCreateModelFromJson(
        Map<String, dynamic> json) =>
    CourseQuizCreateModel(
      slug: json['slug'] as String?,
      quizName: json['quiz_name'] as String?,
      description: json['description'] as String?,
      maxAttempts: (json['max_attempts'] as num?)?.toInt(),
      passingPercentage: (json['passing_percentage'] as num?)?.toInt(),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionCreateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseQuizCreateModelToJson(
        CourseQuizCreateModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'quiz_name': instance.quizName,
      'description': instance.description,
      'max_attempts': instance.maxAttempts,
      'passing_percentage': instance.passingPercentage,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
    };

QuestionCreateModel _$QuestionCreateModelFromJson(Map<String, dynamic> json) =>
    QuestionCreateModel(
      questionName: json['question_name'] as String?,
      mark: (json['mark'] as num?)?.toInt(),
      questionType: json['question_type'] as String?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => ChoiceCreateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionCreateModelToJson(
        QuestionCreateModel instance) =>
    <String, dynamic>{
      'question_name': instance.questionName,
      'mark': instance.mark,
      'question_type': instance.questionType,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
    };

ChoiceCreateModel _$ChoiceCreateModelFromJson(Map<String, dynamic> json) =>
    ChoiceCreateModel(
      choiceName: json['choice_name'] as String?,
      isCorrect: json['isCorrect'] as bool?,
    );

Map<String, dynamic> _$ChoiceCreateModelToJson(ChoiceCreateModel instance) =>
    <String, dynamic>{
      'choice_name': instance.choiceName,
      'isCorrect': instance.isCorrect,
    };
