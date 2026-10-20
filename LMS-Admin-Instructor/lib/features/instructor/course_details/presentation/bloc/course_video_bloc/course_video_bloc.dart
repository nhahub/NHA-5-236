import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/video_repository.dart';
import 'course_video_event.dart';
import 'course_video_state.dart';

class CourseVideoBloc extends Bloc<CourseVideoEvent, CourseVideoState> {
  final VideoRepository videoRepository;

  CourseVideoBloc({required this.videoRepository})
    : super(CourseVideoInitial()) {
    on<GetCourseVideosEvent>((event, emit) async {
      log('CourseVideoBloc: Fetching videos for slug -> ${event.courseSlug}');
      emit(CourseVideoLoading());

      final result = await videoRepository.getCourseVideos(event.courseSlug);

      result.fold(
        (error) {
          log('CourseVideoBloc: API Error -> $error');
          emit(CourseVideoError(message: error));
        },
        (response) {
          log(
            'CourseVideoBloc: API Success -> ${response.data.length} videos found',
          );
          emit(CourseVideoLoaded(videos: response.data));
        },
      );
    });

    on<DeleteVideoEvent>((event, emit) async {
      emit(DeleteVideoLoading());
      final result = await videoRepository.deleteVideo(event.videoSlug);

      result.fold(
        (error) => emit(DeleteVideoError(message: error)),
        (message) {
          emit(DeleteVideoSuccess(message: message));
          add(GetCourseVideosEvent(courseSlug: event.courseSlug));
        },
      );
    });
  }
}
