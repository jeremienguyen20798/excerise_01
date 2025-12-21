import 'dart:developer';

import 'package:excerise_01/core/extensions/alarm_repeat_ext.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/core/utils/formatter.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_bloc.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_event.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_state.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  DateTime dateTime = DateTime.now();
  String labelStr = labelInput, titleAlarm = titleAddAlarm;
  List<int> days = [];

  @override
  void initState() {
    if (widget.alarm != null) {
      log('Alarm with ${widget.alarm!.alarmId}');
      repeatType = widget.alarm!.repeatType;
      dateTime = widget.alarm!.time;
      labelStr = widget.alarm!.message ?? labelInput;
      titleAlarm = titleEditAlarm;
      days = widget.alarm!.days ?? [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlarmBloc, AlarmState>(
      builder: (context, state) {
        if (state is DateTimeChangedState) {
          dateTime = state.dateTime;
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.close, size: 32.0),
            ),
            centerTitle: true,
            title: Text(
              titleAlarm,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kTextHeightNone),
              child: CountdownAlarm(dateTime: dateTime),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (widget.alarm != null) {
                    BlocProvider.of<AlarmBloc>(context).add(
                      UpdateAlarmEvent(
                        id: widget.alarm!.alarmId,
                        dateTime: dateTime,
                        message: labelStr,
                        repeatType: repeatType,
                        days: days,
                      ),
                    );
                  } else {
                    BlocProvider.of<AlarmBloc>(context).add(
                      AddAlarmEvent(
                        dateTime: dateTime,
                        repeatType: repeatType,
                        message: labelStr == labelInput ? null : labelStr,
                        days: days,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.check, size: 32.0),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 300,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    showTimeSeparator: true,
                    itemExtent: kToolbarHeight,
                    initialDateTime: dateTime,
                    onDateTimeChanged: (value) {
                      BlocProvider.of<AlarmBloc>(
                        context,
                      ).add(OnDateTimeChangedEvent(value));
                    },
                    use24hFormat: true,
                    selectionOverlayBuilder:
                        (
                          BuildContext context, {
                          required int selectedIndex,
                          required int columnCount,
                        }) {
                          return const CupertinoPickerDefaultSelectionOverlay(
                            capStartEdge: false,
                            capEndEdge: false,
                            background: Colors.transparent,
                          );
                        },
                  ),
                ),
                SizedBox(height: 24.0),
                _buildItemLabel(ringtone, value: 'Báo thức tự nhiên'),
                _buildItemLabel(
                  repeat,
                  value: repeatType == AlarmRepeatType.custom && days.isNotEmpty
                      ? Formatter.formatDaysToStr(days)
                      : repeatType.getStr(),
                  onClick: () async {
                    final result = await context.push<dynamic>(
                      '/alarm/repeat',
                      extra: {"repeatType": repeatType, "days": days},
                    );
                    if (result != null) {
                      repeatType = result['repeatType'] as AlarmRepeatType;
                      days = result['days'];
                      setState(() {});
                      log(
                        'Alarm repeat type: ${repeatType.name} - days length: ${days.length}',
                      );
                    }
                  },
                ),
                _buildItemLabel(
                  vibrate,
                  widget: Switch(value: true, onChanged: (value) {}),
                ),
                _buildItemLabel(
                  deleteAlarm,
                  widget: Switch(value: false, onChanged: (value) {}),
                ),
                _buildItemLabel(
                  label,
                  value: labelStr,
                  isLabel: true,
                  onAddLabel: (label) {
                    setState(() {
                      labelStr = label;
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
          context.pop(alarm);
        } else if (state is UpdateAlarmState) {
          final alarm = state.alarm;
          context.pop(alarm);
        }
      },
    );
  }

  Widget _buildItemLabel(
    String title, {
    String? value,
    bool isLabel = false,
    Widget? widget,
    Function()? onClick,
    Function(String)? onAddLabel,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      onTap: isLabel
          ? () {
              AppUtils.showAddLabelBottomSheet(context, labelStr, (label) {
                if (onAddLabel != null) {
                  onAddLabel(label);
                }
              });
            }
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing:
          widget ??
          InkWell(
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              if (onClick != null) {
                onClick();
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value ?? '',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                isLabel == true
                    ? SizedBox()
                    : Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ],
            ),
          ),
    );
  }
}
