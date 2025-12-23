import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditAlarmDialog extends StatefulWidget {
  final AlarmEntity alarm;

  const EditAlarmDialog({super.key, required this.alarm});

  @override
  State<EditAlarmDialog> createState() => _EditAlarmDialogState();
}

class _EditAlarmDialogState extends State<EditAlarmDialog> {
  DateTime dateTime = DateTime.now();
  bool isActive = false;
  String titleAlarm = '';

  @override
  void initState() {
    dateTime = widget.alarm.time;
    isActive = widget.alarm.isActive ?? false;
    titleAlarm = widget.alarm.getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      insetPadding: EdgeInsets.symmetric(horizontal: 12.0),
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        title: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: titleAlarm,
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'defaultSpace'.tr()),
              TextSpan(
                text: widget.alarm.message!,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        subtitle: CountdownAlarm(
          dateTime: dateTime,
          repeatTypeStr: widget.alarm.getTextByRepeatType(),
        ),
        trailing: Switch(
          value: isActive,
          onChanged: (value) {
            setState(() {
              isActive = value;
            });
          },
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 12 * 2,
        height: 200.0,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          initialDateTime: dateTime,
          showTimeSeparator: true,
          use24hFormat: true,
          onDateTimeChanged: (value) {
            setState(() {
              dateTime = value;
              titleAlarm = Formatter.formatTimeStr(dateTime);
            });
          },
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  final result =
                      await context.push('/alarm', extra: widget.alarm)
                          as AlarmEntity?;
                  _onBack(result);
                },
                elevation: 0.0,
                height: 48.0,
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'advanceText'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  context.pop({
                    'id': widget.alarm.alarmId,
                    "dateTime": dateTime,
                    "isActive": isActive,
                  });
                },
                elevation: 0.0,
                height: 48.0,
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'confirmText'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onBack(AlarmEntity? alarm) {
    if (alarm != null) {
      context.pop(alarm);
    } else {
      context.pop();
    }
  }
}
