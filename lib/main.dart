import 'dart:async';
import 'dart:developer';

import 'package:excerise_01/core/notification/alarm_status_notifier.dart';
import 'package:excerise_01/data/local_db/alarm_local_db.dart';
import 'package:excerise_01/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'app.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  log('Cancel alarm notification with ${notificationResponse.id}');
  AlarmLocalDB alarmLocalDB = AlarmLocalDB();
  int alarmId = notificationResponse.id ?? -1;
  final result = await alarmLocalDB.updateAlarmStatus(alarmId, false);
  if (result != null) {
    final entity = result.toEntity();
    AlarmStatusNotifier.instance.notifyDismissal(entity.toPayload());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.setUp();
  // [QUAN TRỌNG] Khởi tạo lắng nghe Port
  AlarmStatusNotifier.instance.initialize();
  runApp(const MyApp());
}
