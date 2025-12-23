import 'package:easy_localization/easy_localization.dart';

import '../../domain/entities/alarm_repeat_type.dart';

extension AlarmRepeatExt on AlarmRepeatType {
  String getStr() {
    switch (this) {
      case AlarmRepeatType.onlyOnce:
        return 'defaultOnlyOnceText'.tr();
      case AlarmRepeatType.daily:
        return 'defaultDailyText'.tr();
      case AlarmRepeatType.mondayToFriday:
        return 'defaultMondayToFridayText'.tr();
      default:
        return 'defaultCustomText'.tr();
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
