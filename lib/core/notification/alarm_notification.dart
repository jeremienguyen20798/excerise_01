import 'dart:typed_data';

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
    // // Ensure Android notification channel is created with vibration enabled.
    // final AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    //   'channelId', // same id as used in AndroidNotificationDetails
    //   'channelName',
    //   description: 'Channel for alarm notifications',
    //   importance: Importance.max,
    //   enableVibration: true,
    //   vibrationPattern: Int64List.fromList([250, 250, 250, 250]),
    // );
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(androidChannel);
  }

  Future<void> showNotification(
    AlarmEntity alarm, {
    String? payloadData,
  }) async {
    // 1. Định nghĩa pattern rung cho Android
    // 0 - Start immediately (Dừng 0ms)
    // 1000 - Vibrate for 1s (Rung 1 giây)
    // 500 - Pause for 0.5s (Dừng 0.5 giây)
    // 2000 - Vibrate for 2s (Rung 2 giây)
    Int64List vibrationPattern = Int64List.fromList([250, 250, 250, 250]);
    // Cấu hình thông báo cho Android
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          vibrationPattern: vibrationPattern,
          sound: RawResourceAndroidNotificationSound('clock_alarm'),
          audioAttributesUsage: AudioAttributesUsage.alarm,
          actions: [AndroidNotificationAction('cancel', 'Tắt')],
        );
    // Cấu hình thông báo cho IOS
    const DarwinNotificationDetails
    darwinPlatformChannelSpecifics = DarwinNotificationDetails(
      // Các thuộc tính này giúp thông báo được hiển thị và rung khi cần
      presentAlert: true,
      presentBadge: true,
      presentSound:
          true, // Nếu bật âm thanh, rung cũng sẽ đi kèm (nếu máy không im lặng)
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinPlatformChannelSpecifics,
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
