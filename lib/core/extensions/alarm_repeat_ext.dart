import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';

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
}
