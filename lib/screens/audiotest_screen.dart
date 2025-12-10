
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audioscreen extends StatefulWidget{
  const Audioscreen({super.key});

  @override
  State<Audioscreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<Audioscreen>{
  final audioPlayer = AudioPlayer();

  //Shows whether the audio is playing or not
  bool isPlaying = false;
  //Shows how long the audio file(duration) is and how far you are(position)
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState(){
    super.initState();

    //Listens if the audio file is playing and returns a true if that is the case
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    //Listens to see how long the audio file is
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //Listens to see the progress of the audio file
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState((){
        position = newPosition;
      }
      );
    });

    //Initializes the audio file
    setAudio();

  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.release);

    //Decides where the audio file is located
    final player = AudioCache(prefix: 'lib/assets/audio/');
    //decides the file that is picked for the player
    final url = await player.load('test_file2.mp3');
    audioPlayer.setSourceUrl(url.path);
  }

  @override
  void dispose(){
    audioPlayer.dispose();

    super.dispose;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text(
              'test track',
              style: TextStyle(
                fontSize: 24
              ),
            ),
            Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);

                  await audioPlayer.resume();

                }
            ),
            Padding(
                padding:const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: IconButton(onPressed: () async{
                    Duration newPosition = position;
                    if (position > Duration(seconds: 10)){
                      position = newPosition - Duration(seconds: 10);
                      audioPlayer.seek(position);
                    } else {
                      audioPlayer.seek(Duration(seconds: 0));
                    }
                  },
                      icon: Icon(Icons.fast_rewind, size: 50,),
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: Icon(
                      //If the audio is playing(isPlaying = true) the button is a pause button, otherwise it is a play arrow
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      //If the song is playing then it can be paused here or resumed when it is paused
                      if (isPlaying){
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 35,
                  child: IconButton(onPressed: () async{
                    Duration leftover = duration - position;
                    Duration newPosition = position;
                    if (leftover > Duration(seconds: 10)){
                      position = newPosition + Duration(seconds: 10);
                      audioPlayer.seek(position);
                    } else {
                      audioPlayer.seek(duration);
                    }
                  }, icon: Icon(Icons.fast_forward, size: 50,),
                  ),
                ),

              ],
            ),
            ),

          ],
    ),
    )
    );


  //Here we define the attributes of the time in hours, minutes and seconds
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