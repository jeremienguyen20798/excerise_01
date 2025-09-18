import 'package:excerise_01/entities/alarm_repeat_type.dart';

abstract class AlarmEvent {}

class AddAlarmEvent extends AlarmEvent {
  final DateTime dateTime;
  final String? message;
  final AlarmRepeatType? repeatType;

  AddAlarmEvent({required this.dateTime, this.message, this.repeatType});
}

class UpdateAlarmEvent extends AlarmEvent {
  int id;
  final DateTime dateTime;
  final String? message;
  final AlarmRepeatType? repeatType;

  UpdateAlarmEvent(this.id, this.dateTime, this.message, this.repeatType);
}
