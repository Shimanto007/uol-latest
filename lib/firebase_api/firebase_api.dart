import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('${message.notification?.title}');
  print('${message.notification?.body}');
  print('${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
              alert: true,
              announcement: true,
              badge: true,
              carPlay: true,
              criticalAlert: true,
              provisional: true,
              sound: true);
      // final ref = FirebaseDatabase.instance.ref('appVersion');
      // print(ref);
      await _firebaseMessaging.requestPermission();
      final fCMToken = await _firebaseMessaging.getToken();

      print(fCMToken);
      // final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('appVersion');



      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }
}
