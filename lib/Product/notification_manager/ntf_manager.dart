import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'default_notification_channel_id',
    'Notification',
    description: 'notifications from Your App Name.',
    importance: Importance.high,
  );
  void initialize() async {
    await FirebaseMessaging.instance.requestPermission();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /* static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (message != null) await showNotification(message.data);
  } */

  static Future<void> showNotification(Map<String, dynamic> data) async {
    final http.Response response = await http.get(Uri.parse(data["imageUrl"]));
    
    debugPrint("gardaş biziz: $data");
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "default_notification_channel_id",
      "channel",
      importance: Importance.max,
      largeIcon: ByteArrayAndroidBitmap.fromBase64String(
          base64Encode(response.bodyBytes)),
      priority: Priority.high,
      showWhen: false,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      data['title'] ?? '',
      data['body'] ?? '',
      platformChannelSpecifics,
    );
  }
}
