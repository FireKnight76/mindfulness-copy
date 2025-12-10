import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mindfulness_in_je_broekzak/main.dart';
import 'package:mindfulness_in_je_broekzak/screens/tasks_screen.dart';
class firebaseApi{
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await firebaseMessaging.getAPNSToken();
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    print('Token: $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async{ //shows noti message outside of app
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  void handleMessage(RemoteMessage? message){ // decides where the user gets sent after click on noti message
    if (message==null) return;

    print('Handling message: ${message.notification?.title}');
    navigatorKey.currentState?.pushNamed(TaskScreen.route, arguments: message);
  }

  Future initPushNotifications() async{ //makes it so handleMessage gets called properly at noti click
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage); //unopened case
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);// opened case
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}