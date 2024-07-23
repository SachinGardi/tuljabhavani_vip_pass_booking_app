import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future<void> onSelectNotification(String? payload) async {
  if (payload != null) {
    SharedPreferences preference = await SharedPreferences.getInstance();
    bool isDevoteeLoggedIn = preference.getBool('isRegister') ?? false;

    if (isDevoteeLoggedIn == true) {
      Get.offAllNamed("/devoteeNotificationScreen");
    } else {
      // Navigate to the login screen
      Get.offAllNamed('/dashBoard');
    }
  }
}




///FirebaseBackground Handler
@pragma("vm:entry-point")
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("*****${message.data.toString()}");


  RemoteNotification? notification = RemoteNotification(
   // title: message.data['body'] ?? '',
    body: message.data['m_message'] ?? '',
  );
  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,

      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          color: Colors.orange,

          styleInformation: BigTextStyleInformation(
            notification.body!,
          ),
        ),
      ));
      // onSelectNotification;

}

///Support above android 8 channel

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);

/// Initialize the FlutterLocalNotificationsPlugin package.

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

///to store fcmToken
String? fcmToken;


class FirebaseServiceData {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    'your_channel_id', // Match the channel ID you created
    'Your Notification Title',
    importance: Importance.high,
  );

  /// InitializationSettings  for Android
  InitializationSettings initializationSettings = const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  );

  Future<void> initNotifications() async {
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification:onSelectNotification
    );

    initializationSettings;
    FirebaseMessaging message = FirebaseMessaging.instance;

    await message.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    await message.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    ///To generate device specific token
    await FirebaseMessaging.instance
        .getToken()
        .then((token) => {fcmToken = token});

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onSelectNotification;
    });

    ///handle notification on background
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    ///when application is on foreground receive notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("*****${message.data.toString()}");

      RemoteNotification? notification = RemoteNotification(
       // title: message.data['body'] ?? '',
        body: message.data['m_message'] ?? '',
      );
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
              color: Colors.orange,
              styleInformation: BigTextStyleInformation(
                notification.body!,
              ),
            ),
          ));

    });
  }
}
