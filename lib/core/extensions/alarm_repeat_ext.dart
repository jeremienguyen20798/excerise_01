import 'package:excerise_01/core/constant/app_constant.dart';

import '../../domain/entities/alarm_repeat_type.dart';

extension AlarmRepeatExt on AlarmRepeatType {
  String getStr() {
    switch (this) {
      case AlarmRepeatType.onlyOnce:
        return defaultOnlyOnceText;
      case AlarmRepeatType.daily:
        return defaultDailyText;
      case AlarmRepeatType.mondayToFriday:
        return defaultMondayToFridayText;
      default:
        return defaultCustomText;
    }
  }

  List<int> getDays() {
    switch (this) {
      case AlarmRepeatType.daily:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.saturday,
          DateTime.sunday,
        ];
      case AlarmRepeatType.mondayToFriday:
        return [
          DateTime.monday,
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
        ];
      default:
        return [];
    }
  }
}
