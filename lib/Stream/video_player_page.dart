import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _showPlayIcon = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      })
      ..addListener(() {
        // Hide the play icon when video starts playing
        if (_controller.value.isPlaying && _showPlayIcon) {
          setState(() {
            _showPlayIcon = false;
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade900,
      appBar: AppBar(
        backgroundColor: Colors.brown.shade900,
        title: const Text('Stream For Free'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            else
              const CircularProgressIndicator(),
            if (_showPlayIcon)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showPlayIcon = false;
                  });
                  _controller.play();
                },
                child: Icon(
                  Icons.play_arrow,
                  size: 72,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
              _showPlayIcon = true;
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}


