import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mindfulness_in_je_broekzak/screens/Information_screen.dart';
import 'package:video_player/video_player.dart';
import 'oefeningen_page.dart';
import 'video_page.dart';
import 'settings_page.dart';
import 'video_screen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late VideoPlayerController _mindfulVideoController; // decides video activity
  ChewieController? _mindfulChewieController; //loads in video UI automatically

  @override
  void initState() {
    super.initState();
    _mindfulVideoController = VideoPlayerController.asset('assets/MindfulBewegen.mp4')
      ..initialize().then((_) {
        setState(() {
          _mindfulChewieController = ChewieController(
            videoPlayerController: _mindfulVideoController,
            autoPlay: true,
            looping: true,
          );
        });
      });
  }

  @override
  void dispose() {
    _mindfulVideoController.dispose();
    _mindfulChewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Uitgelicht Video
              Text(
                'Uitgelicht',
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _mindfulChewieController != null
                  ? AspectRatio(
                aspectRatio: _mindfulVideoController.value.aspectRatio,
                child: Chewie(controller: _mindfulChewieController!),) : Center(child: CircularProgressIndicator()),
              // Snel Starten
              Text(
                'Snel Starten',
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('Energie Boosten', Colors.green[300]),
                    SizedBox(width: 10),
                    _buildCategoryChip('Ontspannen', Colors.green[400]),
                    SizedBox(width: 10),
                    _buildCategoryChip('Focus Verbeteren', Colors.green[500]),
                    SizedBox(width: 10),
                    _buildCategoryChip('Snel Kalmeren', Colors.green[600]),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white
                      ),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InformationScreen())
                          );
                        },
                        child: Text("information"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Voortgang
              Text(
                'Voortgang',
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildProgressBar('Video\'s', Colors.green, 3, 10),
              SizedBox(height: 10),
              _buildProgressBar('Oefeningen', Colors.green, 7, 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OefeningenPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VideoPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Oefeningen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Video\'s',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Instellingen',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, Color? color) {
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: color,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildProgressBar(String label, Color color, int current, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        LinearProgressIndicator(
          value: current / total,
          backgroundColor: color.withOpacity(0.3),
          color: color,
          minHeight: 10,
        ),
        SizedBox(height: 5),
        Text('$current/$total voltooid'),
      ],
    );
  }
}