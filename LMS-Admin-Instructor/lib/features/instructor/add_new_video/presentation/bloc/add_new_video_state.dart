import '../../../common/data/model/video_model/course_video_model.dart';

abstract class AddNewVideoState {}

class AddNewVideoInitial extends AddNewVideoState {}

class AddNewVideoLoading extends AddNewVideoState {}

class AddNewVideoSuccess extends AddNewVideoState {
  final CourseVideoModel video;

  AddNewVideoSuccess({required this.video});
}

class AddNewVideoError extends AddNewVideoState {
  final String message;

  AddNewVideoError({required this.message});
}

class AddNewVideoProgress extends AddNewVideoState {
  final int sent;
  final int total;
  final double progress;

  AddNewVideoProgress({
    required this.sent,
    required this.total,
    required this.progress,
  });
}
