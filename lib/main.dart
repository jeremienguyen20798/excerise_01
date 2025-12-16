import 'dart:async';

import 'package:excerise_01/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app.dart';
import 'data/local_db/alarm_local_db.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  AlarmLocalDB localDB = AlarmLocalDB();
  int alarmId = notificationResponse.id ?? -1;
  await localDB.updateAlarmStatus(alarmId, false);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.setUp();
  runApp(const MyApp());
}
