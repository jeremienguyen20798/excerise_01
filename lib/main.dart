import 'dart:developer';

import 'package:excerise_01/core/notification/alarm_notification.dart';
import 'package:excerise_01/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/constant/app_constant.dart';
import 'data/local_db/alarm_local_db.dart';
import 'features/home/view/home_page.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  log(
    'Cancel alarm notification with ${notificationResponse.id} on background',
  );
  AlarmLocalDB localDB = AlarmLocalDB();
  int alarmId = notificationResponse.id ?? -1;
  await localDB.updateAlarmStatus(alarmId, false);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: defaultAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
