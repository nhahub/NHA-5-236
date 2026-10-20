import 'package:file_picker/file_picker.dart';

abstract class AddNewVideoEvent {}

class AddVideoEvent extends AddNewVideoEvent {
  final String courseSlug;
  final String title;
  final String course;
  final String? videoUrl;
  final PlatformFile? videoFile;

  AddVideoEvent({
    required this.courseSlug,
    required this.title,
    required this.course,
    this.videoUrl,
    this.videoFile,
  });
}
class ResetAddVideoEvent extends AddNewVideoEvent {}
