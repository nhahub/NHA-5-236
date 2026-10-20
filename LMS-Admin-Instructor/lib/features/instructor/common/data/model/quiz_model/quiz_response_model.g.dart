// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponseModel _$QuizResponseModelFromJson(Map<String, dynamic> json) =>
    QuizResponseModel(
      success: json['success'] as bool?,
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : QuizData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizResponseModelToJson(QuizResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

QuizData _$QuizDataFromJson(Map<String, dynamic> json) => QuizData(
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalQuizzes: (json['total_quizzes'] as num?)?.toInt(),
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((e) => QuizModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizDataToJson(QuizData instance) => <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_quizzes': instance.totalQuizzes,
      'quizzes': instance.quizzes,
    };
