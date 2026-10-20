import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class AddVideoRequestModel {
  final String title;
  final String course;
  final String duration;
  final String? videoUrl;
  final PlatformFile? videoFile;

  AddVideoRequestModel({
    required this.title,
    required this.course,
    required this.duration,
    this.videoUrl,
    this.videoFile,
  });

  Future<Map<String, dynamic>> toFormDataMap() async {
    final Map<String, dynamic> data = {
      'title': title,
      'course': course,
      'duration': duration,
    };

    if (videoUrl != null && videoUrl!.isNotEmpty) {
      data['video_url'] = videoUrl;
    }

    MultipartFile? multipartFile;
    if (videoFile != null) {
      if (kIsWeb) {
        multipartFile = MultipartFile.fromBytes(
          videoFile!.bytes!,
          filename: videoFile!.name,
        );
      } else {
        multipartFile = MultipartFile.fromFileSync(
          videoFile!.path!,
          filename: videoFile!.name,
        );
      }
    }
    if (multipartFile != null) {
      data['video_upload'] = multipartFile;
    }
    return data;
  }
}
