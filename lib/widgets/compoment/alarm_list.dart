import 'package:excerise_01/domain/entities/alarm_entity.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:excerise_01/widgets/compoment/empty_view.dart';
import 'package:excerise_01/widgets/items/item_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<AlarmEntity> alarms = [];

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GetAlarmListState) {
          alarms = state.alarms;
        } else if (state is DeleteAlarmState) {
          alarms = state.alarms;
        } else if (state is ReloadAlarmListState) {
          alarms.add(state.alarm);
        } else if (state is UpdateItemForListState) {
          final item = state.alarm;
          final index = state.index;
          final removeItem = alarms.elementAt(index);
          alarms.remove(removeItem);
          alarms.insert(index, item);
        } else if (state is UpdateItemState) {
          final item = state.alarm;
          final index = state.index;
          final removeItem = alarms.elementAt(index);
          alarms.remove(removeItem);
          alarms.insert(index, item);
        } else if (state is AlarmDismissedFromNotificationState) {
          // Tìm index của alarm cần update
          final index = alarms.indexWhere(
            (e) => e.alarmId == state.entity?.alarmId,
          );
          if (index != -1 && state.entity != null) {
            alarms[index] =
                state.entity!; // Thay thế item cũ bằng item mới (đã tắt)
          }
        }
        return alarms.isNotEmpty
            ? SliverList.separated(
                itemCount: alarms.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemAlarm(index: index, alarm: alarms[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 16.0),
              )
            : EmptyView();
      },
    );
  }
}
