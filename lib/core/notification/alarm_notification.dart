import 'dart:convert';
import 'dart:developer';

import 'package:excerise_01/core/local_db/alarm_local_db.dart';
import 'package:excerise_01/entities/alarm.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';
import '../constant/app_constant.dart';
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AlarmLocalDB localDB = AlarmLocalDB();

class AlarmNotification {
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_notification');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          darwinNotificationCategoryText,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.text(
              'text_1',
              'Action 1',
              buttonTitle: 'Tắt',
              placeholder: 'Placeholder',
            ),
          ],
        ),
      ];

  Future<void> notificationInitial() async {
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          notificationCategories: darwinNotificationCategories,
        );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
            if (notificationResponse.actionId == 'cancel') {
              log('Cancel alarm notification');
            }
          },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> showNotification(Alarm alarm) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('clock_alarm'),
          audioAttributesUsage: AudioAttributesUsage.alarm,
          actions: [AndroidNotificationAction('cancel', 'Tắt')],
        );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    final duration = alarm.getTimeAlarm().difference(DateTime.now());
    await flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.id,
      alarm.getTime(),
      alarm.message,
      tz.TZDateTime.now(tz.local).add(duration),
      notificationDetails,
      payload: jsonEncode(alarm),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: alarm.repeatType == AlarmRepeatType.daily
          ? DateTimeComponents.time
          : alarm.repeatType == AlarmRepeatType.week
          ? DateTimeComponents.dayOfWeekAndTime
          : null,
    );
  }

  Future<void> cancelAllAlarmRing() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelAlarmRingById(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
