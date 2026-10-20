import 'package:lms_admin_instructor/features/instructor/common/data/model/video_model/course_video_model.dart';

abstract class CourseVideoState {}

class CourseVideoInitial extends CourseVideoState {}

class CourseVideoLoading extends CourseVideoState {}

class CourseVideoLoaded extends CourseVideoState {
  final List<CourseVideoModel> videos;

  CourseVideoLoaded({required this.videos});
}

class CourseVideoError extends CourseVideoState {
  final String message;

  CourseVideoError({required this.message});
}

class DeleteVideoLoading extends CourseVideoState {}

class DeleteVideoSuccess extends CourseVideoState {
  final String message;
  DeleteVideoSuccess({required this.message});
}

class DeleteVideoError extends CourseVideoState {
  final String message;
  DeleteVideoError({required this.message});
}
