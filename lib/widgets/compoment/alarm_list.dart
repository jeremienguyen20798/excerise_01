import 'package:excerise_01/entities/alarm.dart';
import 'package:excerise_01/features/home/bloc/home_bloc.dart';
import 'package:excerise_01/features/home/bloc/home_state.dart';
import 'package:excerise_01/widgets/compoment/empty_view.dart';
import 'package:excerise_01/widgets/items/item_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Alarm> alarms = [];

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
        }
        return alarms.isNotEmpty
            ? ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemAlarm(index: index, alarm: alarms[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 16.0),
                itemCount: alarms.length,
              )
            : EmptyView();
      },
    );
  }
}
