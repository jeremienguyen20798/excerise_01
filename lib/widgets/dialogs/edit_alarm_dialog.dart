import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/entities/alarm.dart';
import 'package:excerise_01/features/alarm/view/alarm_page.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAlarmDialog extends StatefulWidget {
  final Alarm alarm;

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
      insetPadding: EdgeInsets.symmetric(horizontal: 24.0),
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          titleAlarm,
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: widget.alarm.message != null
            ? Text(
          widget.alarm.message!,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.ellipsis,
          ),
        )
            : null,
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
        width: MediaQuery
            .of(context)
            .size
            .width - 24 * 2,
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
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: MaterialButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AlarmPage(alarm: widget.alarm),
                    ),
                  );
                  if (result != null) {
                    Navigator.pop(context, result);
                  }
                },
                elevation: 0.0,
                height: 48.0,
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  advanceText,
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
                  Navigator.pop(context, {
                    'id': widget.alarm.id,
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
                  confirmText,
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
}
