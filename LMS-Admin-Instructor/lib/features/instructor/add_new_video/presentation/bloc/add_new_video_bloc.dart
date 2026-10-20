import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/add_new_video/data/model/add_video_request_model.dart';
import '../../../common/domain/repository/video_repository.dart';
import 'add_new_video_event.dart';
import 'add_new_video_state.dart';
import 'utils/video_helper.dart';
import 'utils/video_duration_utils.dart';

class AddNewVideoBloc extends Bloc<AddNewVideoEvent, AddNewVideoState> {
  final VideoRepository videoRepository;

  AddNewVideoBloc({required this.videoRepository})
    : super(AddNewVideoInitial()) {
    on<AddVideoEvent>((event, emit) async {
      log("Hello world");
      emit(AddNewVideoLoading());

      String duration = "00:00";
      try {
        log("youtube: ${event.videoUrl.toString()}");
        if (event.videoUrl != null && event.videoUrl!.isNotEmpty) {
          log("youtube Video URL: ${event.videoUrl}");
          duration = await getYoutubeDuration(event.videoUrl!);
        } else if (event.videoFile != null) {
          if (!kIsWeb && event.videoFile!.path != null) {
            duration = await getLocalVideoDuration(event.videoFile!.path!);
          } else if (kIsWeb && event.videoFile!.bytes != null) {
            duration = await getLocalVideoDurationWeb(event.videoFile!.bytes!);
          }
        }
      } catch (e) {
        duration = "00:00";
      }

      final requestModel = AddVideoRequestModel(
        title: event.title,
        course: event.course,
        duration: duration,
        videoUrl: event.videoUrl,
        videoFile: event.videoFile,
      );

      final data = await requestModel.toFormDataMap();

      final result = await videoRepository.addVideo(
        event.courseSlug,
        data,
        onSendProgress: (sent, total) {
          if (total > 0) {
            emit(
              AddNewVideoProgress(
                sent: sent,
                total: total,
                progress: sent / total,
              ),
            );
          }
        },
      );

      result.fold(
        (error) => emit(AddNewVideoError(message: error)),
        (video) => emit(AddNewVideoSuccess(video: video)),
      );
    });
    on<ResetAddVideoEvent>((event, emit) {
      emit(AddNewVideoInitial());
    });
  }
}
