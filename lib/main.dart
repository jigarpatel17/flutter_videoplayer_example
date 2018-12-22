import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Example',
      home: VideoExample(),
    );
  }
}

class VideoExample extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoExample> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network(
          "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        ..addListener(listener)
        ..setVolume(1.0)
        ..setLooping(true)
        ..initialize();
    }

    if (playerController.value.isPlaying) {
      playerController.pause();
    } else {
      playerController.play();
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Example'),
      ),
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                  playerController,
                )
                    : Container()),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();
        },
        child: (playerController != null && playerController.value.isPlaying) ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
    );
  }
}
