//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Notifications Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const NotificationScreen(),
//     );
//   }
// }
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   NotificationScreenState createState() => NotificationScreenState();
// }
//
// class NotificationScreenState extends State<NotificationScreen> {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//   }
//
//   Future<void> _initializeNotifications() async {
//     // Configuration Android
//     const AndroidInitializationSettings androidInitializationSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // Configuration iOS
//     const DarwinInitializationSettings iosInitializationSettings =
//     DarwinInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: androidInitializationSettings,
//         iOS: iosInitializationSettings);
//
//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> showNotification() async {
//
//
//
//     print("22222222222222222222222222222222222222222222");
//     // Configuration de la notification pour Android
//     const AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails(
//       'channel_id', // ID du canal
//       'channel_name', // Nom du canal
//       channelDescription: 'Description du canal',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     // Configuration de la notification pour iOS
//     const DarwinNotificationDetails iosNotificationDetails =
//     DarwinNotificationDetails();
//
//     const NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );
//
//     // Affichage de la notification
//     await _flutterLocalNotificationsPlugin.show(
//       0, // ID unique pour la notification
//       'Bonjour Khaloui', // Titre
//       'Ceci est une notification Flutter 🎉', // Corps
//       notificationDetails,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications Locales'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: showNotification,
//           child: const Text('Afficher la notification'),
//         ),
//       ),
//     );
//   }
// }
