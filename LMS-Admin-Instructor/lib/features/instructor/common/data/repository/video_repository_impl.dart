import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import '../../domain/repository/video_repository.dart';
import '../model/video_model/course_video_model.dart';

class VideoRepositoryImpl implements VideoRepository {
  final ApiConsumer apiConsumer;

  VideoRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseVideoResponseModel>> getCourseVideos(
    String courseSlug,
  ) async {
    return await apiConsumer.get<CourseVideoResponseModel>(
      EndPoint.courseVideos(courseSlug),
      fromJson: (json) => CourseVideoResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, CourseVideoModel>> addVideo(
    String courseSlug,
    Map<String, dynamic> data, {
    void Function(int sent, int total)? onSendProgress,
  }) async {
    return await apiConsumer.post<CourseVideoModel>(
      EndPoint.createVideo,
      data: data,
      isFormData: data.containsKey('video_upload'),
      sendTimeout: const Duration(minutes: 30),
      receiveTimeout: const Duration(minutes: 30),
      onSendProgress: (sent, total) {
        if (total > 0) {
          final sentMb = (sent / (1024 * 1024)).toStringAsFixed(2);
          final totalMb = (total / (1024 * 1024)).toStringAsFixed(2);
          final percent = (sent / total * 100).toStringAsFixed(1);
          log('Upload Progress: $sentMb MB / $totalMb MB ($percent%)');
        }
        onSendProgress?.call(sent, total);
      },
      fromJson: (json) => CourseVideoModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, String>> deleteVideo(String videoSlug) async {
    return await apiConsumer.delete<String>(
      EndPoint.deleteVideo(videoSlug),
      fromJson: (json) => json['message'] as String? ?? 'Deleted Successfully',
    );
  }
}
