import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mindfulness_in_je_broekzak/util/ActivitiesResponse.dart';
import 'package:http/http.dart' as http;
import 'package:mindfulness_in_je_broekzak/util/firebaseApi.dart';
import 'package:mindfulness_in_je_broekzak/verander_deze_naam.dart';
import 'screens/welcome_screen.dart';
import 'screens/tasks_screen.dart';
import 'dart:io';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = Jeje();
  fetchActivities();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await firebaseApi().initNotifications();

  // njn


  runApp(MyApp());
}

Future<void> fetchActivities () async {
  final response = await http.get(Uri.parse('https://mindful_api.sven.lol/api/activities'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    final activitiesResponse = ActivitiesResponse.fromJson(jsonData);

    VeranderDezeNaam.activities = activitiesResponse;
    print("testestsebt");
    print(VeranderDezeNaam.activities.taskActivities.length);

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Jeje extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(), // Set the WelcomeScreen as the home screen
      navigatorKey: navigatorKey,
      routes: {
        TaskScreen.route: (context) => TaskScreen(),
      },
    );
  }
}
