import 'dart:developer';

import 'package:excerise_01/core/extensions/day_alarm_ext.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_bloc.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_event.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/entities/alarm_repeat_type.dart';

class AlarmView extends StatefulWidget {
  final AlarmEntity? alarm;

  const AlarmView({super.key, this.alarm});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  AlarmRepeatType repeatType = AlarmRepeatType.onlyOnce;
  TextEditingController messageController = TextEditingController();
  DateTime dateTime = DateTime.now();
  List<int>? days;

  @override
  void initState() {
    if (widget.alarm != null) {
      repeatType = widget.alarm!.repeatType;
      dateTime = widget.alarm!.time;
      messageController.text = widget.alarm!.message ?? defaultMessage;
      days = widget.alarm!.days;
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
                        id: widget.alarm!.alarmId,
                        dateTime: dateTime,
                        message: messageController.text,
                        repeatType: repeatType,
                        days: days,
                      ),
                    );
                  } else {
                    BlocProvider.of<AlarmBloc>(context).add(
                      AddAlarmEvent(
                        dateTime: dateTime,
                        repeatType: repeatType,
                        message: messageController.text,
                        days: days,
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
                  helperText:
                      repeatType == AlarmRepeatType.custom && days != null
                      ? 'Thời gian lặp lại: ${days!.map((item) => item.getStr())}'
                      : null,
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(),
                    helperStyle: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
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
                      value: AlarmRepeatType.mondayToFriday,
                      label: defaultMondayToFridayText,
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
                        _setDaysAlarmRepeat();
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

  Future<void> _setDaysAlarmRepeat() async {
    final result = await AppUtils.showCustomRepeatTypeBottomSheet(
      context,
      days ?? [],
    );
    setState(() {
      if (result != null) {
        days = result;
        log('Days length: ${days?.length}');
      }
    });
  }
}
