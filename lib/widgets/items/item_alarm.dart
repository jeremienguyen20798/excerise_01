import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/utils/app_utils.dart';
import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_event.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:excerise_01/widgets/compoment/countdown/countdown_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/alarm_repeat_type.dart';

class ItemAlarm extends StatefulWidget {
  final int index;
  final AlarmEntity alarm;

  const ItemAlarm({super.key, required this.index, required this.alarm});

  @override
  State<ItemAlarm> createState() => _ItemAlarmState();
}

class _ItemAlarmState extends State<ItemAlarm> {
  bool isChoose = false,
      isActive = false,
      isLongPress = false,
      isDeleteAllItems = false;
  List<int> itemDeleteIds = [];

  @override
  void initState() {
    isActive = widget.alarm.isActive ?? false;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemAlarm oldWidget) {
    if (oldWidget.alarm != widget.alarm) {
      isActive = widget.alarm.isActive ?? false;
    }
    super.didUpdateWidget(oldWidget);
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
          isChoose = false;
        } else if (state is DeleteAllAlarmsState) {
          isLongPress = true;
          isChoose = true;
          isDeleteAllItems = state.isDeleteAll;
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
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
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
                  TextSpan(text: 'defaultSpace'.tr()),
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
            subtitle: !isActive
                ? Text(
                    widget.alarm.getTextByRepeatType(),
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  )
                : CountdownAlarm(
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
                          ).add(AddItemForDeleteEvent(widget.alarm.alarmId));
                        } else {
                          BlocProvider.of<HomeBloc>(context).add(
                            RemoveItemForDeleteIdsEvent(widget.alarm.alarmId),
                          );
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
                              widget.alarm.alarmId,
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
                                  widget.alarm.alarmId,
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
