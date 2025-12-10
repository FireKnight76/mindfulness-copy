import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String taskName;
  final String taskNumber;
  final List<String> tags;

  TaskCard(
      {required this.taskName, required this.taskNumber, required this.tags});

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
                  .map((tag) =>
                  Chip(
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