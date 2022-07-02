import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: IOSInitializationSettings(
                requestSoundPermission: true,
                requestBadgePermission: true,
                requestAlertPermission: true,
                onDidReceiveLocalNotification: (int id, String? title,
                    String? body, String? payload) async {
                  log('---->>>ALERT FOR IOS');
                }));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      // Navigator.of(context).PushNamed(route);
    });
  }

  static void display(RemoteMessage message) {
    if (Platform.isIOS) {
      const NotificationDetails _details = NotificationDetails(
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentSound: true,
            presentBadge: true,
            // sound: 'emergency_pending.wav',
          ),
          android: AndroidNotificationDetails(
            "easyApproach",
            "easyApproach channel",
            importance: Importance.max,
            playSound: true,
            priority: Priority.high,
          ));
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        _details,
        payload: message.data['route'],
      );
    } else {
      const NotificationDetails _details = NotificationDetails(
          iOS: IOSNotificationDetails(),
          android: AndroidNotificationDetails(
            "easyApproach",
            "easyApproach channel",
            importance: Importance.max,
            playSound: true,
            priority: Priority.high,
          ));
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        _details,
      );
    }
  }

}
