import 'package:video_player/video_player.dart';

class VideosAssets {

  VideoPlayerController controller =
      VideoPlayerController.asset('videos/desert.mp4');

  Future<void> initializeVideo() async {
    await controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      controller.play();
      controller.setLooping(true);
      controller.setVolume(0.5);
    });
  }
}
