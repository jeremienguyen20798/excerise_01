import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:isar/isar.dart';

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

  Alarm({
    this.message = defaultMessage,
    required this.time,
    this.repeatType = AlarmRepeatType.onlyOnce,
    this.isActive = true,
  });

  String getTime() {
    return Formatter.formatTimeStr(time);
  }

  DateTime getTimeAlarm() {
    final now = DateTime.now();
    if (time.isBefore(now)) {
      final tomorrow = time.add(Duration(days: 1));
      return tomorrow;
    }
    return time;
  }

  String getTextByRepeatType() {
    switch (repeatType) {
      case AlarmRepeatType.onlyOnce:
        return defaultOnlyOnceText;
      case AlarmRepeatType.daily:
        return defaultDailyText;
      case AlarmRepeatType.week:
        return defaultWeekText;
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
}
