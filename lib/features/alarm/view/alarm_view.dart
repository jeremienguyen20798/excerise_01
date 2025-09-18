import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_bloc.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_event.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_constant.dart';
import '../../../entities/alarm.dart';
import '../../../entities/alarm_repeat_type.dart';

class AlarmView extends StatefulWidget {
  final Alarm? alarm;

  const AlarmView({super.key, this.alarm});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  AlarmRepeatType repeatType = AlarmRepeatType.onlyOnce;
  TextEditingController messageController = TextEditingController();
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    if (widget.alarm != null) {
      repeatType = widget.alarm!.repeatType;
      dateTime = widget.alarm!.time;
      messageController.text = widget.alarm!.message ?? defaultMessage;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlarmBloc, AlarmState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ),
            centerTitle: true,
            title: Text(
              titleAddAlarm,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (widget.alarm != null) {
                    BlocProvider.of<AlarmBloc>(context).add(
                      UpdateAlarmEvent(
                        widget.alarm!.id,
                        dateTime,
                        messageController.text,
                        repeatType,
                      ),
                    );
                  } else {
                    BlocProvider.of<AlarmBloc>(context).add(
                      AddAlarmEvent(
                        dateTime: dateTime,
                        repeatType: repeatType,
                        message: messageController.text,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.check),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    showTimeSeparator: true,
                    initialDateTime: dateTime,
                    onDateTimeChanged: (value) {
                      setState(() {
                        dateTime = value;
                      });
                    },
                    use24hFormat: true,
                  ),
                ),
                SizedBox(height: 24.0),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: labelAlarm,
                    hintText: contentAlarmHintText,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24.0),
                DropdownMenu<AlarmRepeatType>(
                  width: MediaQuery.of(context).size.width,
                  label: Text(
                    titleRepeat,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  initialSelection: repeatType,
                  dropdownMenuEntries: [
                    DropdownMenuEntry<AlarmRepeatType>(
                      value: AlarmRepeatType.onlyOnce,
                      label: defaultOnlyOnceText,
                    ),
                    DropdownMenuEntry<AlarmRepeatType>(
                      value: AlarmRepeatType.daily,
                      label: defaultDailyText,
                    ),
                    DropdownMenuEntry<AlarmRepeatType>(
                      value: AlarmRepeatType.week,
                      label: defaultWeekText,
                    ),
                    DropdownMenuEntry<AlarmRepeatType>(
                      value: AlarmRepeatType.custom,
                      label: defaultCustom,
                    ),
                  ],
                  onSelected: (AlarmRepeatType? newValue) {
                    setState(() {
                      repeatType = newValue ?? AlarmRepeatType.onlyOnce;
                      if (repeatType == AlarmRepeatType.custom) {
                        AppUtils.showCustomRepeatTypeBottomSheet(context);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddAlarmState) {
          final alarm = state.alarm;
          Navigator.pop(context, alarm);
        } else if (state is UpdateAlarmState) {
          final alarm = state.alarm;
          Navigator.pop(context, alarm);
        }
      },
    );
  }
}
