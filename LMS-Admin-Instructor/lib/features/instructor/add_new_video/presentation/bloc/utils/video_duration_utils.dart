import 'dart:developer';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<String> getYoutubeDuration(String url) async {
  try {
    final yt = YoutubeExplode();
    try {
      final video = await yt.videos.get(url);
      final duration = video.duration;
      if (duration != null) {
        return formatDuration(duration);
      }
    } finally {
      yt.close();
    }
  } catch (e) {
    log("youtube exception: $e");
  }
  return "00:00";
}

Future<String> getLocalVideoDuration(String filePath) async {
  try {
    final controller = VideoPlayerController.file(File(filePath));
    await controller.initialize();
    final duration = controller.value.duration;
    await controller.dispose();
    return formatDuration(duration);
  } catch (e) {
    return "00:00";
  }
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${duration.inHours > 0 ? '${duration.inHours}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
}
