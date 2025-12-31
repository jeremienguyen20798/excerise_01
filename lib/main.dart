import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/notification/alarm_status_notifier.dart';
import 'package:excerise_01/data/local_db/alarm_local_db.dart';
import 'package:excerise_01/di.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  log('Cancel alarm notification with ${notificationResponse.id}');
  AlarmLocalDB alarmLocalDB = AlarmLocalDB();
  int alarmId = notificationResponse.id ?? -1;
  final payload = notificationResponse.payload;
  final alarmEntity = AlarmEntity.fromJson(jsonDecode(payload!));
  if (alarmEntity.isDeletedAfterRing ?? true) {
    await alarmLocalDB.deleteAlarmById(alarmId);
    AlarmStatusNotifier.instance.notifyDismissal(alarmEntity.toPayload());
  } else {
    final result = await alarmLocalDB.updateAlarmStatus(alarmId, false);
    if (result != null) {
      final entity = result.toEntity();
      AlarmStatusNotifier.instance.notifyDismissal(entity.toPayload());
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // Initialize the Mobile Ads SDK.
  MobileAds.instance.initialize();
  await DependencyInjection.setUp();
  // [QUAN TRỌNG] Khởi tạo lắng nghe Port
  AlarmStatusNotifier.instance.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('vi', 'VN')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}
