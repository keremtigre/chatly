import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FirebaseMsg {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  configure() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => debugPrint("token: ${value!}"));

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }
}

class FirebaseMessagingService {
  final HttpClient httpClient = HttpClient();
  final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  final fcmKey = dotenv.env['fcm_key'];

  void sendNotification(
      String title, String body, String fcmToken, String imageUrl) async {
    debugPrint("sendNotMethod: $fcmToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$fcmKey'
    };
    var request = http.Request('POST', Uri.parse(fcmUrl));
    request.body = '''
{         
          "to":"$fcmToken",
          "priority":"high",
          "data":
          {  
            "title":"$title",
            "body":"$body",
            "imageUrl":"$imageUrl",
            },
            
            }
            ''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase.toString());
    }
  }
}
