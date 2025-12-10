import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mindfulness_in_je_broekzak/screens/tasks_screen.dart';
import 'package:mindfulness_in_je_broekzak/verander_deze_naam.dart';

class OefeningenPage extends StatefulWidget {
  @override
  _OefeningenPageState createState() => _OefeningenPageState();
}

class _OefeningenPageState extends State<OefeningenPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentAudio; // Keeps track of the currently playing file
  bool isPlaying = false; // Play status
  int? _expandedIndex; // Keeps track of the expanded exercise
  //Shows how long the audio file(duration) is and how far you are(position)
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  var _taskType = VeranderDezeNaam.activities.taskActivities;


  void initState(){
    super.initState();

    //Listens if the audio file is playing and returns a true if that is the case
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    //Listens to see how long the audio file is
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //Listens to see the progress of the audio file
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState((){
        position = newPosition;
      }
      );
    });

    //Initializes the audio file
    setAudio();

  }

  Future setAudio() async {
    _audioPlayer.setReleaseMode(ReleaseMode.release);

    //Decides where the audio file is located
    final player = AudioCache(prefix: 'assets/audio/');
    //decides the file that is picked for the player
    final url = await player.load('test_file2.mp3');
    _audioPlayer.setSourceUrl(url.path);
  }



  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Play audio from the `videos` folder
  void _playAudio(String fileName) async {
    final path = 'assets/videos/$fileName'; // Correct path to the videos folder
    try {
      if (isPlaying && _currentAudio == fileName) {
        // Pause if the same file is already playing
        await _audioPlayer.pause();
        setState(() {
          isPlaying = false;
        });
      } else {
        // Stop any existing audio and play the new one
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource(path));
        setState(() {
          _currentAudio = fileName;
          isPlaying = true;
        });
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Oefeningen', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Taken",
              style:TextStyle(fontSize: 30),
            ),
            SizedBox(height: 10,),
            ..._taskType.map((task) => TaskCard(
              taskName: task.title!,
              taskNumber: task.id,
              tags: [],
            )),
            Text(
              "Audio",
              style:TextStyle(fontSize: 30),
            ),
            SizedBox(height: 10,),
            _buildExerciseTile(2, "ladjflkasdf", "laksdjflksajlfjasflaskfdjlakf", 'assets/audio/test_file.mp3')
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseTile(int index, String title, String description, String audioFile) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            trailing: Icon(
              _expandedIndex == index ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.green,
            ),
            onTap: () {
              setState(() {
                _expandedIndex = _expandedIndex == index ? null : index;
              });
            },
          ),
          if (_expandedIndex == index)
            _buildAudioPlayer(audioFile) // Audio player with controls
        ],
      ),
    );
  }

  Widget _buildAudioPlayer(String audioFile) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await _audioPlayer.seek(position);

                await _audioPlayer.resume();
              }
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatTime(position)),
              Text(formatTime(duration))
            ],
          ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Playback controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async{
                          Duration newPosition = position;
                          if (position > Duration(seconds: 10)){
                            position = newPosition - Duration(seconds: 10);
                            _audioPlayer.seek(position);
                          } else {
                            _audioPlayer.seek(Duration(seconds: 0));
                          }
                          print('Rewind 10 seconds');
                        },
                        icon: Icon(Icons.replay_10, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: () async {
                          //If the song is playing then it can be paused here or resumed when it is paused
                          if (isPlaying){
                            await _audioPlayer.pause();
                          } else {
                            await _audioPlayer.resume();
                          }
                        },
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.green,
                          size: 36,
                        ),
                      ),
                      IconButton(
                        onPressed: () async{
                          Duration leftover = duration - position;
                          Duration newPosition = position;
                          if (leftover > Duration(seconds: 10)){
                            position = newPosition + Duration(seconds: 10);
                            _audioPlayer.seek(position);
                          } else {
                            _audioPlayer.seek(duration);
                          }
                          print('Fast forward 10 seconds');
                        },
                        icon: Icon(Icons.forward_10, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              )
          )
        ],
      ),
      
    );
  }

  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    //Here the duration is noted as hours:minutes:seconds for the audio file
    return[
      if (duration.inHours > 0) hours, minutes, seconds,
    ].join(':');
  }

}