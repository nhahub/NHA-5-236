import 'package:dartz/dartz.dart';
import '../../data/model/video_model/course_video_model.dart';

abstract class VideoRepository {
  Future<Either<String, CourseVideoResponseModel>> getCourseVideos(
    String courseSlug,
  );
  Future<Either<String, CourseVideoModel>> addVideo(
    String courseSlug,
    Map<String, dynamic> data, {
    void Function(int sent, int total)? onSendProgress,
  });
  Future<Either<String, String>> deleteVideo(String videoSlug);
}
