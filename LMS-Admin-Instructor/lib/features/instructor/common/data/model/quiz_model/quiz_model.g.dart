// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
      quizName: json['quiz_name'] as String?,
      slug: json['slug'] as String?,
      totalMark: json['total_mark'] as num?,
      maxAttempts: json['max_attempts'] as num?,
      courseName: json['course_name'] as String?,
      attemptsUsed: json['attempts_used'] as num?,
      bestScore: json['best_score'] as num?,
      quizStatus: json['quiz_status'] as String?,
      description: json['description'] as String?,
      passingPercentage: json['passing_percentage'] as num?,
    );

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
      'quiz_name': instance.quizName,
      'slug': instance.slug,
      'total_mark': instance.totalMark,
      'max_attempts': instance.maxAttempts,
      'course_name': instance.courseName,
      'attempts_used': instance.attemptsUsed,
      'best_score': instance.bestScore,
      'quiz_status': instance.quizStatus,
      'description': instance.description,
      'passing_percentage': instance.passingPercentage,
    };
