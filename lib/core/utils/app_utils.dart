import 'package:excerise_01/entities/alarm.dart';
import 'package:excerise_01/widgets/bottomsheet/custom_repeatType_bottomsheet.dart';
import 'package:excerise_01/widgets/bottomsheet/cancel_alarm_bottomsheet.dart';
import 'package:excerise_01/widgets/dialogs/edit_alarm_dialog.dart';
import 'package:excerise_01/widgets/dialogs/notification_warning_dialog.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static void showEditAlarmDialog(
    BuildContext context,
    Alarm alarm,
    Function(dynamic) onConfirm,
    Function(Alarm) onUpdate,
  ) {
    showDialog(
      context: context,
      builder: (_) => EditAlarmDialog(alarm: alarm),
    ).then((value) {
      if (value != null && value is Alarm) {
        onUpdate(value);
      } else if (value != null) {
        onConfirm(value);
      }
    });
  }

  static Future<List<int>?> showCustomRepeatTypeBottomSheet(
    BuildContext context,
    List<int> alarmDays,
  ) async {
    final days = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      builder: (_) => CustomRepeatTypeBottomSheet(days: alarmDays),
    );
    return days;
  }

  static void showCancelAlarmBottomSheet(
    BuildContext context,
    Alarm alarm,
    Function(String) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      builder: (_) => CancelAlarmBottomSheet(alarm: alarm),
    ).then((value) {
      if (value != null) {
        onChanged(value);
      }
    });
  }

  static void showNotificationWarningDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => NotificationWarningDialog());
  }
}
