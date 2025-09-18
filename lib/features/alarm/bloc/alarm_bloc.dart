import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/entities/alarm.dart';
import 'package:excerise_01/entities/alarm_repeat_type.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_event.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/local_db/alarm_local_db.dart';
import '../../../core/notification/alarm_notification.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  AlarmLocalDB localDB = AlarmLocalDB();
  AlarmNotification alarmNotification = AlarmNotification();

  AlarmBloc() : super(InitAlarmState()) {
    on<AddAlarmEvent>(_addAlarm);
    on<UpdateAlarmEvent>(_updateAlarm);
  }

  Future<void> _addAlarm(
    AddAlarmEvent event,
    Emitter<AlarmState> emitter,
  ) async {
    String message = event.message != null && event.message != ''
        ? event.message!
        : defaultMessage;
    final DateTime time = event.dateTime;
    final repeatType = event.repeatType ?? AlarmRepeatType.onlyOnce;
    final alarm = Alarm(time: time)
      ..message = message
      ..repeatType = repeatType;
    await localDB.writeAlarm(alarm);
    await alarmNotification.showNotification(alarm);
    emitter(AddAlarmState(alarm));
  }

  Future<void> _updateAlarm(
    UpdateAlarmEvent event,
    Emitter<AlarmState> emitter,
  ) async {
    int idAlarm = event.id;
    DateTime dateTime = event.dateTime;
    String? messageAlarm = event.message;
    AlarmRepeatType? alarmRepeatType = event.repeatType;
    await localDB.updateDetailAlarm(
      idAlarm: idAlarm,
      dateTime: dateTime,
      message: messageAlarm,
      repeatType: alarmRepeatType,
    );
    Alarm? alarm = await localDB.getAlarmById(idAlarm);
    if (alarm != null) {
      await alarmNotification.showNotification(alarm);
      emitter(UpdateAlarmState(alarm));
    }
  }
}
