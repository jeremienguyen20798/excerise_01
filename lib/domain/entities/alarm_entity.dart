import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/core/extensions/day_alarm_ext.dart';
import 'package:excerise_01/core/extensions/string_ext.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/data/models/alarm_model.dart';
import 'package:timezone/timezone.dart' as tz;

import 'alarm_repeat_type.dart';

class AlarmEntity {
  int alarmId;
  String? message;
  DateTime time;
  AlarmRepeatType repeatType;
  bool? isActive;
  List<int>? days;
  bool isVibration;
  bool? isDeletedAfterRing;

  AlarmEntity({
    required this.alarmId,
    this.message = defaultMessage,
    required this.time,
    this.repeatType = AlarmRepeatType.onlyOnce,
    this.isActive = true,
    this.days,
    this.isVibration = true,
    this.isDeletedAfterRing,
  });

  factory AlarmEntity.fromJson(Map<String, dynamic> json) {
    return AlarmEntity(
      alarmId: json['alarmId'],
      time: DateTime.parse(json['time'].toString()),
      message: json['message'],
      repeatType: json['repeatType'].toString().getRepeatType(),
      isActive: json['isActive'],
      days: json['days'] != null
          ? List<int>.from(json['days'] as List<dynamic>)
          : null,
      isVibration: json['isVibration'],
      isDeletedAfterRing: json['isDeletedAfterRing'],
    );
  }

  String getTime() {
    return Formatter.formatTimeStr(time);
  }

  String getTitle() {
    return '${'defaultTitle'.tr()} ${getTime()}';
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
        return 'defaultOnlyOnceText'.tr();
      case AlarmRepeatType.daily:
        return 'defaultDailyText'.tr();
      case AlarmRepeatType.mondayToFriday:
        return 'defaultMondayToFridayText'.tr();
      case AlarmRepeatType.custom:
        if (days != null) {
          return _getDays();
        }
        return 'defaultCustomText'.tr();
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

  String _getDays() {
    String daysStr = '';
    if (days != null && days!.isNotEmpty) {
      for (int day in days!) {
        daysStr += '${day.getStr()} ';
      }
    }
    return daysStr;
  }

  String toPayload() {
    final data = {
      'alarmId': alarmId,
      'message': message,
      'time': time.toString(),
      'repeatType': repeatType.name,
      'isActive': isActive,
      'days': days,
      'isVibration': isVibration,
      'isDeletedAfterRing': isDeletedAfterRing,
    };
    return jsonEncode(data);
  }

  AlarmModel toModel() {
    return AlarmModel(
      time: time,
      message: message,
      repeatType: repeatType,
      isActive: isActive,
      days: days,
      isVibration: isVibration,
      isDeletedAfterRing: isDeletedAfterRing,
    );
  }
}
