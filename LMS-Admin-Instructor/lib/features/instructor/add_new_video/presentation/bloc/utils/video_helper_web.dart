import 'dart:html' as html;
import 'dart:typed_data';
import 'package:video_player/video_player.dart';
import 'video_duration_utils.dart';

Future<String> getLocalVideoDurationWeb(Uint8List bytes) async {
  try {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    final duration = controller.value.duration;
    await controller.dispose();
    
    html.Url.revokeObjectUrl(url);
    
    return formatDuration(duration);
  } catch (e) {
    return "00:00";
  }
}
