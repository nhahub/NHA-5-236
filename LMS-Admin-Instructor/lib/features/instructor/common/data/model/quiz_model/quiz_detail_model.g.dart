// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizDetailResponseModel _$QuizDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    QuizDetailResponseModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : QuizDetailModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizDetailResponseModelToJson(
        QuizDetailResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

QuizDetailModel _$QuizDetailModelFromJson(Map<String, dynamic> json) =>
    QuizDetailModel(
      quizName: json['quiz_name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      totalMark: json['total_mark'] as num?,
      maxAttempts: json['max_attempts'] as num?,
      courseName: json['course_name'] as String?,
      passingPercentage: json['passing_percentage'] as num?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizDetailModelToJson(QuizDetailModel instance) =>
    <String, dynamic>{
      'quiz_name': instance.quizName,
      'slug': instance.slug,
      'description': instance.description,
      'total_mark': instance.totalMark,
      'max_attempts': instance.maxAttempts,
      'course_name': instance.courseName,
      'passing_percentage': instance.passingPercentage,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
    };

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      questionName: json['question_name'] as String?,
      slug: json['slug'] as String?,
      mark: json['mark'] as num?,
      questionType: json['question_type'] as String?,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'question_name': instance.questionName,
      'slug': instance.slug,
      'mark': instance.mark,
      'question_type': instance.questionType,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
    };

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) => ChoiceModel(
      choiceName: json['choice_name'] as String?,
      slug: json['slug'] as String?,
      isCorrect: json['is_correct'] as bool?,
    );

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{
      'choice_name': instance.choiceName,
      'slug': instance.slug,
      'is_correct': instance.isCorrect,
    };
