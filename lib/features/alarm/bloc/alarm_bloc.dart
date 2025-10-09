import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/domain/usecase/add_alarm_usecase.dart';
import 'package:excerise_01/domain/usecase/update_alarm_usecase.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_event.dart';
import 'package:excerise_01/features/alarm/bloc/alarm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/notification/alarm_notification.dart';
import '../../../domain/entities/alarm_repeat_type.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final AlarmNotification _alarmNotification = AlarmNotification();

  AlarmBloc() : super(InitAlarmState()) {
    on<AddAlarmEvent>(_addAlarm);
    on<UpdateAlarmEvent>(_updateAlarm);
  }

  Future<void> _addAlarm(
    AddAlarmEvent event,
    Emitter<AlarmState> emitter,
  ) async {
    String message = event.message != null && event.message!.isNotEmpty
        ? event.message!
        : defaultMessage;
    final DateTime time = event.dateTime;
    final repeatType = event.repeatType ?? AlarmRepeatType.onlyOnce;
    final days = event.days;
    final alarmEntity = await AddAlarmUseCase().execute(
      time,
      message,
      repeatType,
      days,
    );
    if (alarmEntity != null) {
      await _alarmNotification.showNotification(
        alarmEntity,
        payloadData: alarmEntity.toPayload(),
      );
      emitter(AddAlarmState(alarmEntity));
    }
  }

  Future<void> _updateAlarm(
    UpdateAlarmEvent event,
    Emitter<AlarmState> emitter,
  ) async {
    int idAlarm = event.id;
    DateTime dateTime = event.dateTime;
    String? messageAlarm = event.message;
    List<int>? days = event.days;
    AlarmRepeatType alarmRepeatType = event.repeatType;
    final alarmEntity = await UpdateAlarmUseCase().execute(
      idAlarm,
      dateTime: dateTime,
      message: messageAlarm,
      repeatType: alarmRepeatType,
      days: days,
    );
    if (alarmEntity != null) {
      await _alarmNotification.showNotification(
        alarmEntity,
        payloadData: alarmEntity.toPayload(),
      );
      emitter(UpdateAlarmState(alarmEntity));
    }
  }
}
