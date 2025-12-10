import 'package:flutter/material.dart';

class Progressscreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Studentenlijst',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                )
              ],
            ),
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          onTap: (index) {
            switch (index) {
              case 0:
              // Navigeren naar Oefeningen Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExercisesScreen()),
                );
                break;
              case 1:
              // Navigeren naar Video's Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideosScreen()),
                );
                break;
              case 2:
              // Navigeren naar Home Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                break;
              case 3:
              // Navigeren naar Opdrachten Screen (TaskScreen)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskScreen()),
                );
                break;
              case 4:
              // Navigeren naar Instellingen Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
                break;
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'Oefeningen'),
            BottomNavigationBarItem(icon: Icon(Icons.video_library), label: 'Video\'s'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Opdrachten'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Instellingen'),
          ],
        ),
    );



  }
}

class ExercisesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Exercises Screen")));
  }
}

class VideosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Videos Screen")));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Home Screen")));
  }
}

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Opdrachten Screen")));
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Settings Screen")));
  }
}