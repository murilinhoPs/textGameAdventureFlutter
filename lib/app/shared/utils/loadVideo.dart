import 'package:video_player/video_player.dart';

class VideosAssets {
  VideoPlayerController controller =
      VideoPlayerController.asset('assets/videos/desert.mp4');

  initializeVideo() {
    controller.initialize().then((_) {
      controller.setLooping(true);
      controller.setVolume(0.5);
      controller.play();
    });
  }
}
