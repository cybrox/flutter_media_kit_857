import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoWidget extends StatefulWidget {
  final String mySource;

  const VideoWidget(this.mySource, {super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late final player;
  late final controller;

  @override
  void initState() {
    super.initState();

    print("### Creating Video Widget");

    player =
        Player(configuration: PlayerConfiguration(logLevel: MPVLogLevel.debug));
    player.stream.log.listen((event) {
      print("###=> $event");
    });
    controller = VideoController(
      player,
      configuration: const VideoControllerConfiguration(
        enableHardwareAcceleration: true,
        scale: 1.0,
      ),
    );

    player.setVolume(0.0);
    player.open(Media(widget.mySource));
  }

  @override
  Widget build(BuildContext context) {
    return Video(
      controller: controller,
      controls: NoVideoControls,
    );
  }

  @override
  void dispose() {
    print("### Disposing Video Widget");

    player.stop();
    player.dispose();

    super.dispose();
  }
}
