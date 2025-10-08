import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/entities/alarm.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/app_constant.dart';

class ItemAlarm extends StatefulWidget {
  final int index;
  final Alarm alarm;

  const ItemAlarm({super.key, required this.index, required this.alarm});

  @override
  State<ItemAlarm> createState() => _ItemAlarmState();
}

class _ItemAlarmState extends State<ItemAlarm> {
  bool isChoose = false, isActive = false, isLongPress = false;
  List<int> itemDeleteIds = [];

  @override
  void initState() {
    isActive = widget.alarm.isActive ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ItemAlarmLongPressState) {
          isLongPress = true;
        } else if (state is OnRestartState) {
          isLongPress = false;
          isChoose = false;
        } else if (state is DeleteAlarmState) {
          isLongPress = false;
        } else if (state is DeleteAllAlarmsState) {
          isLongPress = true;
          isChoose = true;
        } else if (state is CancelDeleteAllItemsState) {
          isChoose = false;
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            onLongPress: () {
              BlocProvider.of<HomeBloc>(context).add(ItemAlarmLongPressEvent());
            },
            onTap: () {
              AppUtils.showEditAlarmDialog(
                context,
                widget.alarm,
                (result) {
                  BlocProvider.of<HomeBloc>(
                    context,
                  ).add(UpdateAlarmEvent(widget.index, result));
                },
                (value) {
                  BlocProvider.of<HomeBloc>(
                    context,
                  ).add(UpdateItemForListEvent(widget.index, value));
                },
              );
            },
            title: RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: widget.alarm.getTime(),
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: defaultSpace),
                  TextSpan(
                    text: widget.alarm.message,
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
              repeatTypeStr: widget.alarm.getTextByRepeatType(),
              dateTime: widget.alarm.time,
            ),
            trailing: isLongPress
                ? Checkbox(
                    value: isChoose,
                    onChanged: (value) {
                      setState(() {
                        isChoose = value ?? false;
                        if (value == true) {
                          BlocProvider.of<HomeBloc>(
                            context,
                          ).add(AddItemForDeleteEvent(widget.alarm.id));
                        }
                      });
                    },
                  )
                : Switch(
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value;
                        if (widget.alarm.repeatType ==
                            AlarmRepeatType.onlyOnce) {
                          BlocProvider.of<HomeBloc>(context).add(
                            UpdateAlarmStatusEvent(
                              null,
                              widget.alarm.id,
                              isActive,
                            ),
                          );
                        } else {
                          AppUtils.showCancelAlarmBottomSheet(
                            context,
                            widget.alarm,
                            (option) {
                              BlocProvider.of<HomeBloc>(context).add(
                                UpdateAlarmStatusEvent(
                                  option,
                                  widget.alarm.id,
                                  isActive,
                                ),
                              );
                            },
                          );
                        }
                      });
                    },
                  ),
          ),
        );
      },
    );
  }
}
