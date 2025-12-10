import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mindfulness_in_je_broekzak/util/firebaseApi.dart';
import 'package:mindfulness_in_je_broekzak/verander_deze_naam.dart';

class TaskScreen extends StatelessWidget {
static const route = '/tasks-screen';

  @override
  Widget build(BuildContext context) {
    final RemoteMessage? message = ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Opdrachten sdjsfjnesf',
          style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: VeranderDezeNaam.activities.taskActivities
            .map((task) => TaskCard(
                  taskName: task.title!,
                  taskNumber: task.id,
                  tags: [],
                ))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
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

class TaskCard extends StatelessWidget {
  final String taskName;
  final String taskNumber;
  final List<String> tags;

  TaskCard({required this.taskName, required this.taskNumber, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.green),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Text(
          '$taskName',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Opdracht $taskNumber'),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: _getTagColor(tag),
                      ))
                  .toList(),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to task details (optional)
        },
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case 'Rustgevend':
        return Colors.pinkAccent;
      case 'Bewegen':
        return Colors.orangeAccent;
      case 'Meditatie':
        return Colors.lightBlueAccent;
      default:
        return Colors.grey;
    }
  }
}

class NextTaskButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Action for next task
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 15.0),
        ),
        child: Text(
          'Volgende opdracht',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}