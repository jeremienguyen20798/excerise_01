import 'dart:convert';

import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:isar/isar.dart';
import 'package:timezone/timezone.dart' as tz;

part 'alarm.g.dart';

@collection
class Alarm {
  Id id = Isar.autoIncrement;

  //Tin nhan bao thuc
  @Index(type: IndexType.value)
  String? message;

  //Thoi gian bao thuc
  @Index(type: IndexType.value)
  DateTime time;

  //Che do lap lai bao thuc
  @enumerated
  AlarmRepeatType repeatType;

  //Trang thai bao thuc
  @Index(type: IndexType.value)
  bool? isActive;

  //Danh sach cac ngay bao thuc
  @Index(type: IndexType.value)
  List<int>? days;

  Alarm({
    this.message = defaultMessage,
    required this.time,
    this.repeatType = AlarmRepeatType.onlyOnce,
    this.isActive = true,
    this.days,
  });

  String getTime() {
    return Formatter.formatTimeStr(time);
  }

  tz.TZDateTime getTimeAlarm() {
    switch (repeatType) {
      case AlarmRepeatType.mondayToFriday:
        final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
        if (time.isBefore(now)) {
          final scheduleDatTime = tz.TZDateTime(
            now.location,
            now.year,
            now.month,
            now.day,
            time.hour,
            time.minute,
            time.second,
          );
          if (now.day == DateTime.friday) {
            final mondayOfNextWeek = scheduleDatTime.add(Duration(days: 3));
            return mondayOfNextWeek;
          } else if (now.day == DateTime.saturday) {
            final mondayOfNextWeek = scheduleDatTime.add(Duration(days: 2));
            return mondayOfNextWeek;
          } else {
            final tomorrow = scheduleDatTime.add(Duration(days: 1));
            return tomorrow;
          }
        }
        return tz.TZDateTime.from(time, tz.local);
      case AlarmRepeatType.custom:
        return tz.TZDateTime.now(tz.local);
      default:
        final now = DateTime.now();
        if (time.isBefore(now)) {
          final tomorrow = time.add(Duration(days: 1));
          return tz.TZDateTime.from(tomorrow, tz.local);
        }
        return tz.TZDateTime.from(time, tz.local);
    }
  }

  String getTextByRepeatType() {
    switch (repeatType) {
      case AlarmRepeatType.onlyOnce:
        return defaultOnlyOnceText;
      case AlarmRepeatType.daily:
        return defaultDailyText;
      case AlarmRepeatType.mondayToFriday:
        return defaultMondayToFridayText;
      case AlarmRepeatType.custom:
        return defaultCustom;
    }
  }

  String getAlarmDistance() {
    Duration duration = Duration.zero;
    final now = DateTime.now();
    if (time.day != now.day) {
      int distance = now.difference(time).inDays;
      final tomorrowTime = time.add(Duration(days: distance + 1));
      duration = tomorrowTime.difference(now);
      return Formatter.formatTime(duration);
    } else {
      if (time.isAfter(now)) {
        duration = time.difference(now);
        return Formatter.formatTime(duration);
      } else {
        final tomorrowTime = time.add(const Duration(days: 1));
        duration = tomorrowTime.difference(now);
        return Formatter.formatTime(duration);
      }
    }
  }

  String toPayload() {
    final data = {
      'message': message,
      'time': time.toString(),
      'repeatType': repeatType.name,
      'isActive': isActive,
      'days': days?.map((item) => item.toString()).toList(),
    };
    return jsonEncode(data);
  }
}
