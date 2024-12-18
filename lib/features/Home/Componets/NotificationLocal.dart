// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationLocal {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   // Initialisation de la notification
//   Future<void> initialize() async {
//     final android = AndroidInitializationSettings('app_icon'); // Icône de l'application
//     final settings = InitializationSettings(android: android);
//     await flutterLocalNotificationsPlugin.initialize(settings);
//   }
//
//   Future<void> showNotification(
//       String title, String content, int progress) async {
//     const channelId = 'example_channel_id';
//     const channelName = 'Example Channel';
//     const notificationId = 1;
//
//     // Configuration de la notification
//     final androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       channelId,
//       channelName,
//       importance: Importance.defaultImportance,
//       priority: Priority.defaultPriority,
//       showProgress: true,
//       maxProgress: 100,
//       progress: progress,
//       ticker: 'ticker',
//       styleInformation: BigPictureStyleInformation(
//         const DrawableResourceAndroidBitmap('assets/yassineImage.jpg'), // Remplacez par une image réelle
//         largeIcon: const DrawableResourceAndroidBitmap('assets/yassineImage.jpg'),
//         contentTitle: title,
//         summaryText: content,
//       ),
//     );
//
//
//     NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     // Notification de téléchargement en cours
//     if (title == 'upload en cours') {
//       await flutterLocalNotificationsPlugin.show(
//         notificationId,
//         title,
//         content,
//         platformChannelSpecifics,
//       );
//     }
//     // Notification de succès d'upload
//     else if (title == 'upload success') {
//       await flutterLocalNotificationsPlugin.show(
//         notificationId,
//         title,
//         'Upload avec succès',
//         platformChannelSpecifics,
//       );
//     } else {
//       // Notification générique
//       await flutterLocalNotificationsPlugin.show(
//         notificationId,
//         title,
//         content,
//         platformChannelSpecifics,
//       );
//     }
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationLocal {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialisation de la notification
  Future<void> initialize() async {
    final android = AndroidInitializationSettings('app_icon'); // Icône de l'application
    final settings = InitializationSettings(android: android);
    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  Future<void> showNotification(
      String title, String content, int progress) async {
    const channelId = 'example_channel_id';
    const channelName = 'Example Channel';
    const notificationId = 1;

    // Remplacez cette URI par celle de l'image que vous voulez afficher dans la notification
    const imageUri = 'https://res.cloudinary.com/dcjtuxprn/image/upload/v1733255957/UploadLeaders/IMG20220616145640.png';  // URL de l'image

    // Vous devrez peut-être télécharger l'image et la sauvegarder localement
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
      ticker: 'ticker',
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(imageUri), // Cette méthode nécessite que l'image soit locale
        largeIcon: FilePathAndroidBitmap(imageUri), // Si vous voulez l'icône aussi
        contentTitle: title,
        summaryText: content,
      ),
    );

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    // Notification de téléchargement en cours
    if (title == 'upload en cours') {
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        content,
        platformChannelSpecifics,
      );
    }
    // Notification de succès d'upload
    else if (title == 'upload success') {
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        'Upload avec succès',
        platformChannelSpecifics,
      );
    } else {
      // Notification générique
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        title,
        content,
        platformChannelSpecifics,
      );
    }
  }
}
