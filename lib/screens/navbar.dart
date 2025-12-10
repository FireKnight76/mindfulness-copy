import 'package:flutter/material.dart';
import 'oefeningen_page.dart';
import 'video_page.dart';
import 'settings_page.dart';
import 'second_screen.dart';
import 'video_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Make the BottomNavBar taller
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        iconSize: 32, // Make icons bigger
        selectedFontSize: 16, // Larger font for selected label
        unselectedFontSize: 14, // Slightly smaller font for unselected label
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0 && currentIndex != 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          } else if (index == 1 && currentIndex != 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OefeningenPage()),
            );
          } else if (index == 2 && currentIndex != 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => VideoPage()),
            );
          } else if (index == 3 && currentIndex != 3) {
            Navigator.pushReplacement(
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
}