import 'package:video_player/video_player.dart';

class VideosAssets {

  VideoPlayerController controller =
      VideoPlayerController.asset('videos/desert.mp4');

  Future<void> initializeVideo() async {
    await controller.initialize().then((_) {
      controller.play();
      controller.setLooping(true);
      controller.setVolume(0.5);
    });
  }
}
