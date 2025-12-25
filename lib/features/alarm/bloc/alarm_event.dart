import '../../../domain/entities/alarm_repeat_type.dart';

abstract class AlarmEvent {}

class AddAlarmEvent extends AlarmEvent {
  DateTime dateTime;
  String? message;
  AlarmRepeatType? repeatType;
  List<int>? days;

  AddAlarmEvent({
    required this.dateTime,
    this.message,
    this.repeatType,
    this.days,
  });
}

class UpdateAlarmEvent extends AlarmEvent {
  int id;
  DateTime dateTime;
  String? message;
  AlarmRepeatType repeatType;
  List<int>? days;

  UpdateAlarmEvent({
    required this.id,
    required this.dateTime,
    this.message,
    required this.repeatType,
    this.days,
  });
}

class OnDateTimeChangedEvent extends AlarmEvent {
  final DateTime dateTime;

  OnDateTimeChangedEvent(this.dateTime);
}

class EnableDeletedAlarmAfterRingEvent extends AlarmEvent {
  final bool isEnable;

  EnableDeletedAlarmAfterRingEvent(this.isEnable);
}
