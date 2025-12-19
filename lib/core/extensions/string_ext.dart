import 'package:excerise_01/domain/entities/alarm_repeat_type.dart';

extension StringExt on String {
  AlarmRepeatType getRepeatType() {
    switch (this) {
      case 'onlyOnce':
        return AlarmRepeatType.onlyOnce;
      case 'daily':
        return AlarmRepeatType.daily;
      case 'mondayToFriday':
        return AlarmRepeatType.mondayToFriday;
      case 'custom':
        return AlarmRepeatType.custom;
      default:
        return AlarmRepeatType.onlyOnce;
    }
  }
}
