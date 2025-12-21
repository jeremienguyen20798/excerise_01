import 'package:excerise_01/widgets/bottomsheet/custom_repeatType_bottomsheet.dart';
import 'package:excerise_01/widgets/bottomsheet/cancel_alarm_bottomsheet.dart';
import 'package:excerise_01/widgets/dialogs/edit_alarm_dialog.dart';
import 'package:excerise_01/widgets/dialogs/notification_warning_dialog.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/alarm_entity.dart';
import '../../widgets/bottomsheet/add_label_bottomsheet.dart';

class AppUtils {
  static void showEditAlarmDialog(
    BuildContext context,
    AlarmEntity alarm,
    Function(dynamic) onConfirm,
    Function(AlarmEntity) onUpdate,
  ) {
    showDialog(
      context: context,
      builder: (_) => EditAlarmDialog(alarm: alarm),
    ).then((value) {
      if (value != null && value is AlarmEntity) {
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      builder: (_) => CustomRepeatTypeBottomSheet(days: alarmDays),
    );
    return days;
  }

  static void showCancelAlarmBottomSheet(
    BuildContext context,
    AlarmEntity alarm,
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

  static void showAddLabelBottomSheet(
    BuildContext context,
    String? label,
    Function(String) onAdd,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      builder: (_) => AddLabelBottomSheet(label),
    ).then((value) {
      if (value != null) {
        onAdd(value);
      }
    });
  }
}
