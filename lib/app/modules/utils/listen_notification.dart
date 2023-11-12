import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gmi_sola_gracia_apps/main.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    //Payload consumption after user clicks notification and add to stream
    onSelectNotification: (String? payload) async {
      selectNotificationSubject.add(payload ?? "{}");
    },
  );
}

void listenNotif() {
  ///Handle Notification on Foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        //Add message from fcm to payload local notification
        payload: json.encode(message.data),
      );
    }
  });

  ///Handle Notification if app minimized
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    ConfigureNotification.configureSelectNotificationFcm(message);
  });

  ///Handle Notification if app terminated
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      ConfigureNotification.configureSelectNotificationFcm(message);
    }
  });

  //Subscribe Topic
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('notification');
}

class ConfigureNotification {
  static void configureSelectNotificationFcm(RemoteMessage message) {
    print("ini routemessage: ${message}");
    final routeKey = message.data['page'];
    routeToPage(routeKey);
  }

  static void configureSelectNotificationForeground({String? route}) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        final data = json.decode(payload);
        final routeKey = data['page'];
        routeToPage(routeKey);
      },
    );
  }

  static void routeToPage(String? routeKey) {
    print("ini route cuy ${routeKey}");
    if (routeKey == null) {
      // Get.to(() => NotificationsPage());
    } else {
      if (routeKey == 'approval-lembur') {
        // Get.to(() => OvertimeApprovalPage());
      } else if (routeKey == 'approval-absensi') {
        // Get.to(() => PresenceApprovalPage());
      } else if (routeKey == 'approval-cuti') {
        // Get.to(() => PaidLeaveApprovePage());
      } else {
        // Get.to(() => NotificationsPage());
      }
    }
  }
}
