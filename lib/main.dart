import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/controllers/page_index_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/modules/utils/key_value.dart';
import 'app/modules/utils/listen_notification.dart';
import 'app/routes/app_pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  "01",
  "High Importance Notifications",
  "This channel is used for important notifications.",
  importance: Importance.max,
  playSound: true,
  enableVibration: true,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await initNotifications(flutterLocalNotificationsPlugin);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await GetStorage.init();
  Get.put(PageIndexController(), permanent: true);
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(
      GetMaterialApp(
        title: "GmiSolaGraciaApps",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  });
}
