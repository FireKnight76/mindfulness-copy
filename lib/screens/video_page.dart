import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'video_screen.dart'; // Import the full-screen video screen

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controllerAdemhaling; //Ademhaling video
  late VideoPlayerController _controllerWandeling; //Wandeling video
  ChewieController? _breatheChewieController; //loads in video UI automatically
  ChewieController? _walkChewieController;

  bool _isAdemhalingLoaded = false;
  bool _isWandelingLoaded = false;

  @override
  void initState() {
    super.initState();
    // Initialize the first video
    _controllerAdemhaling = VideoPlayerController.asset('assets/MindfulBewegen.mp4')
      ..initialize().then((_) {
      setState(() {
        _breatheChewieController = ChewieController(
          videoPlayerController: _controllerAdemhaling,
          autoPlay: false,
          looping: false,
        );
      });
    });
    // Initialize the second video with the updated path
    _controllerWandeling = VideoPlayerController.asset('assets/ZintuigenWandeling.mp4')
      ..initialize().then((_) {
        setState(() {
          _walkChewieController = ChewieController(
            videoPlayerController: _controllerWandeling,
            autoPlay: false,
            looping: false,
          );
        });
      });
  }

  @override
  void dispose() {
    _controllerAdemhaling.dispose();
    _controllerWandeling.dispose();
    _breatheChewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Video\'s',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildVideoCard(
            'Ademhalingsoefening',
            'Kalmeer je ademhaling en laat je gedachten los.',
            _controllerAdemhaling,
            _isAdemhalingLoaded,
            'assets/MindfulBewegen.mp4',
            context,
          ),
          SizedBox(height: 20),
          _buildVideoCard(
            'Buiten Wandeling',
            'Geniet van een ontspannende wandeling in de natuur.',
            _controllerWandeling,
            _isWandelingLoaded,
            'assets/ZintuigenWandeling.mp4',
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(
    String title,
    String description,
    VideoPlayerController controller,
    bool isLoaded,
    String videoPath,
    BuildContext context,
  ) {
     return Card(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(8.0),
         side: BorderSide(color: Colors.green),
       ),
       child: Column(
         children: [
           Text(
             title

           ),
         ],
       ),
     );
  }
}
