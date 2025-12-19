import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/local_db/alarm_local_db.dart';
import '../../domain/entities/alarm_entity.dart';
import '../../domain/entities/alarm_repeat_type.dart';
import '../../main.dart';
import '../constant/app_constant.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AlarmLocalDB _localDB = AlarmLocalDB();

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
            int alarmId = notificationResponse.id ?? -1;
            await _localDB.updateAlarmStatus(alarmId, false);
          },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> showNotification(
    AlarmEntity alarm, {
    String? payloadData,
  }) async {
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
    final scheduleDateTime = alarm.getTimeAlarm();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      alarm.alarmId,
      alarm.getTime(),
      alarm.message,
      scheduleDateTime,
      notificationDetails,
      payload: payloadData,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: alarm.repeatType == AlarmRepeatType.daily
          ? DateTimeComponents.time
          : alarm.repeatType == AlarmRepeatType.custom ||
                alarm.repeatType == AlarmRepeatType.mondayToFriday
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
