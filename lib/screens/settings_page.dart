import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Instellingen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person, color: Colors.green),
              title: Text('Gebruikersnaam'),
              subtitle: Text('Atal Burhani'),
              trailing: Icon(Icons.edit, color: Colors.grey),
              onTap: () {
                // Add edit functionality here
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.green),
              title: Text('Meldingen'),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.palette, color: Colors.green),
              title: Text('Thema'),
              trailing: Text('Groen', style: TextStyle(color: Colors.grey)),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

