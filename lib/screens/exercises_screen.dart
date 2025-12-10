import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class SimpleVideoScreen extends StatefulWidget {
  @override
  _SimpleVideoScreenState createState() => _SimpleVideoScreenState();
}

class _SimpleVideoScreenState extends State<SimpleVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    print('Initializing the video controller...');
    // Initialize the video controller
    _controller = VideoPlayerController.asset('lib/assets/videos/test.mp4')
      ..initialize().then((_) {
        print('Video initialized: ${_controller.value.isInitialized}');
        setState(() {}); // Rebuild the widget once initialized
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  void dispose() {
    print('Disposing the video controller...');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Video Test')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Testing Video Player',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Text(
                  'Video is not initialized',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
                print('Video paused');
              } else {
                _controller.play();
                print('Video playing');
              }
              setState(() {});
            },
            child: Text(_controller.value.isPlaying ? 'Pause' : 'Play'),
          ),
        ],
      ),
    );
  }
}