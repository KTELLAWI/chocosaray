// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class PushNotificationsManager {
//
//   PushNotificationsManager._();
//
//   factory PushNotificationsManager() => _instance;
//
//   static final PushNotificationsManager _instance = PushNotificationsManager();
//
//
//
//   bool _initialized = false;
//
//   Future<void> init() async {
//     if (!_initialized) {
//       // For iOS request permission first.
//       FirebaseMessaging.instance.requestPermission();
//       // FirebaseMessaging.instance;
//
//       // For testing purposes print the Firebase Messaging token
//       String token = await FirebaseMessaging.instance.getToken();
//       print("FirebaseMessaging token: $token");
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       prefs.setString("token", token);
//       FirebaseMessaging.instance.subscribeToTopic("all");
//       _initialized = true;
//     }
//   }
// }